// udp_recorder.c - Registra paquetes UDP en tiempo real
// Compilar: gcc -O2 -o udp_recorder udp_recorder.c
// Ejecutar: ./udp_recorder -d datos_captura

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <signal.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <sys/time.h>
#include <fcntl.h>
#include <errno.h>
#include <time.h>
#include <sys/stat.h>
#include <dirent.h>

// Configuración
#define PORT 9999
#define BUFFER_SIZE (64 * 1024 * 1024)  // 64 MB buffer
#define MAX_PACKET_SIZE 65535
#define WRITE_CHUNK (4 * 1024 * 1024)   // 4 MB por archivo

int running = 1;
int total_packets = 0;
int total_bytes = 0;

void handle_ctrl_c(int sig) {
    running = 0;
    printf("\nDeteniendo captura...\n");
}

// Crear directorio si no existe
void create_directory(const char *path) {
    struct stat st = {0};
    if (stat(path, &st) == -1) {
        mkdir(path, 0755);
        printf("Directorio creado: %s\n", path);
    }
}

int main(int argc, char *argv[]) {
    signal(SIGINT, handle_ctrl_c);
    
    // Directorio por defecto o proporcionado
    char output_dir[256] = "udp_capture";
    if (argc > 1 && strcmp(argv[1], "-d") == 0 && argc > 2) {
        strncpy(output_dir, argv[2], sizeof(output_dir)-1);
    }
    
    create_directory(output_dir);
    
    // Crear socket
    int sock = socket(AF_INET, SOCK_DGRAM, 0);
    if (sock < 0) {
        perror("Error creando socket");
        return 1;
    }
    
    // Configurar buffer grande
    int buf_size = BUFFER_SIZE;
    setsockopt(sock, SOL_SOCKET, SO_RCVBUF, &buf_size, sizeof(buf_size));
    
    // Bind
    struct sockaddr_in addr = {0};
    addr.sin_family = AF_INET;
    addr.sin_port = htons(PORT);
    addr.sin_addr.s_addr = INADDR_ANY;
    
    if (bind(sock, (struct sockaddr*)&addr, sizeof(addr)) < 0) {
        perror("Error haciendo bind");
        close(sock);
        return 1;
    }
    
    printf("=== UDP Recorder ===\n");
    printf("Directorio: %s\n", output_dir);
    printf("Puerto: %d\n", PORT);
    printf("Ctrl+C para detener\n\n");
    
    // Buffer para recibir
    unsigned char packet_buffer[MAX_PACKET_SIZE];
    
    // Variables para escritura
    unsigned char *write_buffer = malloc(WRITE_CHUNK);
    size_t write_offset = 0;
    int file_counter = 0;
    int current_fd = -1;
    
    // Abrir primer archivo
    char filename[512];
    snprintf(filename, sizeof(filename), "%s/capture_%05d.bin", 
             output_dir, file_counter);
    current_fd = open(filename, O_WRONLY | O_CREAT | O_TRUNC, 0644);
    if (current_fd < 0) {
        perror("Error creando archivo");
        free(write_buffer);
        close(sock);
        return 1;
    }
    printf("Archivo: %s\n", filename);
    
    // Variables para estadísticas
    struct timeval start_time, last_stats, current_time;
    gettimeofday(&start_time, NULL);
    gettimeofday(&last_stats, NULL);
    
    int packets_since_last = 0;
    int bytes_since_last = 0;
    
    printf("Esperando paquetes...\n");
    
    // Bucle principal
    while (running) {
        // Recibir paquete
        ssize_t bytes = recv(sock, packet_buffer, MAX_PACKET_SIZE, 0);
        
        if (bytes > 0) {
            total_packets++;
            total_bytes += bytes;
            packets_since_last++;
            bytes_since_last += bytes;
            
            // Verificar si cabe en el buffer actual
            if (write_offset + bytes <= WRITE_CHUNK) {
                memcpy(write_buffer + write_offset, packet_buffer, bytes);
                write_offset += bytes;
            } else {
                // Buffer lleno, escribir a disco
                write(current_fd, write_buffer, write_offset);
                close(current_fd);
                
                // Crear nuevo archivo
                file_counter++;
                snprintf(filename, sizeof(filename), "%s/capture_%05d.bin", 
                         output_dir, file_counter);
                current_fd = open(filename, O_WRONLY | O_CREAT | O_TRUNC, 0644);
                if (current_fd < 0) {
                    perror("Error creando archivo");
                    break;
                }
                
                printf("Nuevo archivo: %s\n", filename);
                
                // Reiniciar buffer
                memcpy(write_buffer, packet_buffer, bytes);
                write_offset = bytes;
            }
            
            // Mostrar estadísticas periódicas
            gettimeofday(&current_time, NULL);
            double elapsed = (current_time.tv_sec - last_stats.tv_sec) + 
                           (current_time.tv_usec - last_stats.tv_usec) / 1000000.0;
            
            if (elapsed >= 1.0) {
                double mbps = (bytes_since_last * 8.0) / elapsed / 1000000.0;
                printf("Tasa: %.1f Mbps | Paquetes: %d | Archivo: %s\n", 
                       mbps, packets_since_last, filename);
                
                packets_since_last = 0;
                bytes_since_last = 0;
                last_stats = current_time;
            }
        } else if (bytes < 0 && errno != EINTR) {
            perror("Error recibiendo");
            break;
        }
    }
    
    // Escribir datos restantes
    if (write_offset > 0 && current_fd >= 0) {
        write(current_fd, write_buffer, write_offset);
    }
    
    // Cerrar archivo actual
    if (current_fd >= 0) {
        close(current_fd);
    }
    
    // Calcular estadísticas finales
    gettimeofday(&current_time, NULL);
    double total_elapsed = (current_time.tv_sec - start_time.tv_sec) + 
                          (current_time.tv_usec - start_time.tv_usec) / 1000000.0;
    
    printf("\n=== CAPTURA COMPLETADA ===\n");
    printf("Tiempo total: %.2f segundos\n", total_elapsed);
    printf("Paquetes capturados: %d\n", total_packets);
    printf("Bytes capturados: %d (%.2f MB)\n", 
           total_bytes, total_bytes / (1024.0 * 1024.0));
    printf("Archivos creados: %d\n", file_counter + 1);
    printf("Tasa promedio: %.2f Mbps\n", 
           (total_bytes * 8.0) / total_elapsed / 1000000.0);
    
    // Listar archivos creados
    printf("\nArchivos en '%s':\n", output_dir);
    DIR *dir = opendir(output_dir);
    if (dir) {
        struct dirent *entry;
        int file_count = 0;
        long long total_size = 0;
        
        while ((entry = readdir(dir)) != NULL) {
            if (entry->d_type == DT_REG) {
                char filepath[512];
                snprintf(filepath, sizeof(filepath), "%s/%s", 
                         output_dir, entry->d_name);
                
                struct stat file_stat;
                if (stat(filepath, &file_stat) == 0) {
                    printf("  %s - %.2f MB\n", 
                           entry->d_name, 
                           file_stat.st_size / (1024.0 * 1024.0));
                    total_size += file_stat.st_size;
                    file_count++;
                }
            }
        }
        closedir(dir);
        
        printf("\nTotal: %d archivos, %.2f MB\n", 
               file_count, total_size / (1024.0 * 1024.0));
    }
    
    // Liberar recursos
    free(write_buffer);
    close(sock);
    
    return 0;
}