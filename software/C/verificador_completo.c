/*
gcc -O2 -pthread -o fpga_receiver_improved fpga_receiver_improved.c
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <dirent.h>
#include <sys/stat.h>
#include <time.h>
#include <stdint.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/mman.h>

#define UDP_PAYLOAD_SIZE 8192
#define NUMBERS_PER_PACKET 1024
#define PROGRESS_UPDATE 1000000 // Actualizar progreso cada 1M números

typedef struct {
    char filename[256];
    long size;
    uint64_t first_sequence;
    uint64_t last_sequence;
    long errors;
    long total_numbers;
} file_info_t;

// Función optimizada para convertir little-endian
static inline uint64_t le64_to_host(uint64_t le_value) {
    return le_value;
}

int compare_files(const void *a, const void *b) {
    return strcmp(((file_info_t*)a)->filename, ((file_info_t*)b)->filename);
}

int get_bin_files(const char *folder_path, file_info_t **files) {
    DIR *dir;
    struct dirent *entry;
    struct stat file_stat;
    int count = 0;
    int capacity = 100;
    
    *files = malloc(capacity * sizeof(file_info_t));
    if (!*files) return -1;
    
    if ((dir = opendir(folder_path)) == NULL) {
        free(*files);
        return -1;
    }
    
    while ((entry = readdir(dir)) != NULL) {
        if (strstr(entry->d_name, ".bin") != NULL) {
            char full_path[512];
            snprintf(full_path, sizeof(full_path), "%s/%s", folder_path, entry->d_name);
            
            if (stat(full_path, &file_stat) == 0 && S_ISREG(file_stat.st_mode)) {
                if (count >= capacity) {
                    capacity *= 2;
                    file_info_t *new_files = realloc(*files, capacity * sizeof(file_info_t));
                    if (!new_files) {
                        closedir(dir);
                        free(*files);
                        return -1;
                    }
                    *files = new_files;
                }
                
                strncpy((*files)[count].filename, full_path, sizeof((*files)[count].filename) - 1);
                (*files)[count].size = file_stat.st_size;
                (*files)[count].errors = 0;
                (*files)[count].total_numbers = 0;
                count++;
            }
        }
    }
    
    closedir(dir);
    if (count > 0) {
        qsort(*files, count, sizeof(file_info_t), compare_files);
    }
    
    return count;
}

void verify_sequence_complete(file_info_t *files, int file_count) {
    printf("🔍 VERIFICACIÓN COMPLETA UNO POR UNO\n");
    printf("=====================================\n\n");
    
    uint64_t expected_sequence = 0;
    uint64_t global_first_sequence = 0;
    long total_numbers_checked = 0;
    long total_errors = 0;
    int first_number = 1;
    
    // Estadísticas para reporte
    uint64_t last_gap_position = 0;
    uint64_t largest_gap = 0;
    uint64_t largest_gap_position = 0;
    
    for (int file_idx = 0; file_idx < file_count; file_idx++) {
        printf("📁 Procesando: %s\n", files[file_idx].filename);
        
        int fd = open(files[file_idx].filename, O_RDONLY);
        if (fd == -1) {
            printf("   ❌ Error abriendo archivo\n");
            continue;
        }
        
        struct stat sb;
        if (fstat(fd, &sb) == -1) {
            close(fd);
            continue;
        }
        
        // Memory mapping para acceso ultra-rápido
        void *file_data = mmap(NULL, sb.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
        if (file_data == MAP_FAILED) {
            close(fd);
            continue;
        }
        
        uint64_t *data = (uint64_t*)file_data;
        size_t num_elements = sb.st_size / 8;
        
        files[file_idx].total_numbers = num_elements;
        
        // Procesar cada número individualmente
        for (size_t i = 0; i < num_elements; i++) {
            uint64_t current_sequence = le64_to_host(data[i]);
            total_numbers_checked++;
            
            // Capturar primer número del primer archivo
            if (first_number) {
                global_first_sequence = current_sequence;
                expected_sequence = current_sequence;
                first_number = 0;
                files[file_idx].first_sequence = current_sequence;
                printf("   ⚡ Iniciando secuencia en: %lu\n", current_sequence);
            }
            
            // Verificar secuencia
            if (current_sequence != expected_sequence) {
                uint64_t gap = current_sequence - expected_sequence;
                
                // Solo reportar gaps significativos (mayores a 1)
                if (gap > 1) {
                    printf("   🚨 SALTO en posición %lu: %lu -> %lu (gap: %lu)\n", 
                           total_numbers_checked, expected_sequence, current_sequence, gap);
                    
                    if (gap > largest_gap) {
                        largest_gap = gap;
                        largest_gap_position = total_numbers_checked;
                    }
                    
                    // Análisis del gap
                    if (gap >= NUMBERS_PER_PACKET) {
                        long packets_lost = gap / NUMBERS_PER_PACKET;
                        printf("      📦 Pérdida: %ld paquetes UDP completos\n", packets_lost);
                    }
                }
                
                files[file_idx].errors++;
                total_errors++;

                printf("   Error en la secuencia: %lu: %lu -> %lu\n", 
                           total_numbers_checked, expected_sequence, current_sequence);

                expected_sequence = current_sequence;
            }
            
            expected_sequence++;
            
            // Mostrar progreso cada 1M números
            if (total_numbers_checked % PROGRESS_UPDATE == 0) {
                printf("   📊 Progreso: %ldM números verificados, %ld errores\n", 
                       total_numbers_checked / 1000000, total_errors);
            }
        }
        
        files[file_idx].last_sequence = le64_to_host(data[num_elements - 1]);
        
        munmap(file_data, sb.st_size);
        close(fd);
        
        printf("   ✅ Archivo completado: %ld números, %ld errores\n", 
               files[file_idx].total_numbers, files[file_idx].errors);
        printf("   📈 Rango: %lu -> %lu\n\n", 
               files[file_idx].first_sequence, files[file_idx].last_sequence);
        
        // Verificar transición al siguiente archivo
        if (file_idx < file_count - 1) {
            int next_fd = open(files[file_idx + 1].filename, O_RDONLY);
            if (next_fd != -1) {
                uint64_t first_buffer[1];
                if (read(next_fd, first_buffer, 8) == 8) {
                    uint64_t next_first_seq = le64_to_host(first_buffer[0]);
                    uint64_t expected_next = files[file_idx].last_sequence + 1;
                    
                    if (next_first_seq != expected_next) {
                        uint64_t gap = next_first_seq - expected_next;
                        printf("   🔄 SALTO ENTRE ARCHIVOS: %lu -> %lu (gap: %lu)\n", 
                               files[file_idx].last_sequence, next_first_seq, gap);
                        
                        if (gap >= NUMBERS_PER_PACKET) {
                            long packets_lost = gap / NUMBERS_PER_PACKET;
                            printf("      📦 Pérdida entre archivos: %ld paquetes UDP\n", packets_lost);
                        }
                        
                        total_errors++;
                    }
                }
                close(next_fd);
            }
        }
    }
    
    // REPORTE FINAL DETALLADO
    printf("\n=====================================\n");
    printf("🎯 INFORME FINAL - VERIFICACIÓN COMPLETA\n");
    printf("=====================================\n");
    
    printf("📊 ESTADÍSTICAS GLOBALES:\n");
    printf("   • Archivos procesados: %d\n", file_count);
    printf("   • Números verificados: %ld\n", total_numbers_checked);
    printf("   • Paquetes UDP equivalentes: %ld\n", total_numbers_checked / NUMBERS_PER_PACKET);
    printf("   • Errores de secuencia: %ld\n", total_errors);
    printf("   • Rango total: %lu -> %lu\n", global_first_sequence, expected_sequence - 1);
    
    if (total_errors > 0) {
        double error_rate = (double)total_errors / total_numbers_checked * 100.0;
        printf("\n🚨 ANÁLISIS DE ERRORES:\n");
        printf("   • Tasa de error: %.8f%%\n", error_rate);
        printf("   • Gap más grande: %lu números en posición %lu\n", largest_gap, largest_gap_position);
        printf("   • Paquetes perdidos estimados: ~%lu\n", largest_gap / NUMBERS_PER_PACKET);
        
        // Análisis por archivo
        printf("\n📁 ERRORES POR ARCHIVO:\n");
        for (int i = 0; i < file_count; i++) {
            if (files[i].errors > 0) {
                double file_error_rate = (double)files[i].errors / files[i].total_numbers * 100.0;
                printf("   • %s: %ld errores (%.6f%%)\n", 
                       files[i].filename, files[i].errors, file_error_rate);
            }
        }
    } else {
        printf("\n🎉 ¡VERIFICACIÓN EXITOSA!\n");
        printf("   • Secuencia perfecta desde %lu hasta %lu\n", 
               global_first_sequence, expected_sequence - 1);
        printf("   • No se detectaron pérdidas de paquetes\n");
        printf("   • Todos los %ld números están en secuencia correcta\n", total_numbers_checked);
    }
    
    printf("\n⏱️  Throughput de verificación: %.2f millones de números/segundo\n", 
           (double)total_numbers_checked / (clock() / CLOCKS_PER_SEC) / 1000000);
}

int main(int argc, char *argv[]) {
    if (argc != 2) {
        printf("Uso: %s <carpeta>\n", argv[0]);
        printf("Ejemplo: %s fpga_data_20251006_192757\n", argv[0]);
        return 1;
    }
    
    const char *folder_path = argv[1];
    
    printf("=== VERIFICADOR COMPLETO UNO POR UNO ===\n");
    printf("Carpeta: %s\n", folder_path);
    printf("Verificando cada número individualmente...\n\n");
    
    file_info_t *files = NULL;
    int file_count = get_bin_files(folder_path, &files);
    
    if (file_count <= 0) {
        printf("❌ No se encontraron archivos .bin\n");
        return 1;
    }
    
    printf("Encontrados %d archivos .bin\n\n", file_count);
    
    clock_t start_time = clock();
    
    // Verificación completa uno por uno
    verify_sequence_complete(files, file_count);
    
    clock_t end_time = clock();
    double elapsed_seconds = (double)(end_time - start_time) / CLOCKS_PER_SEC;
    
    printf("\n⏱️  Tiempo total: %.2f segundos\n", elapsed_seconds);
    printf("📈 Velocidad: %.2f números/segundo\n", 
           (files[0].total_numbers * file_count) / elapsed_seconds);
    
    if (files) free(files);
    return 0;
}

/*
gcc -O2 -o verificador_completo verificador_completo.c
*/