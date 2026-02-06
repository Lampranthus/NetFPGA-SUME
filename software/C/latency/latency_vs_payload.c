/*
gcc -O3 -o latency_vs_payload latency_vs_payload.c -lm
Uso: ./latency_vs_payload <num_muestras_por_punto> <payload_min> <payload_max> <incremento>
Ejemplo: ./latency_vs_payload 1000 1 65507 1000
*/

#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <unistd.h>
#include <math.h>
#include <arpa/inet.h>
#include <sys/socket.h>
#include <sys/time.h>

#define FPGA_IP "192.168.1.128"
#define FPGA_PORT 1234
#define LOCAL_PORT 9999
#define MAX_PAYLOAD 65507  // Máximo para UDP (65535 - 20 IP - 8 UDP)
#define DEFAULT_SAMPLES 1000

// Estructura para estadísticas
typedef struct {
    double min;
    double max;
    double mean;
    double stddev;
    double percentile_50;
    double percentile_95;
    double percentile_99;
} stats_t;

// Función para obtener timestamp en microsegundos
uint64_t get_time_us() {
    struct timeval tv;
    gettimeofday(&tv, NULL);
    return (uint64_t)tv.tv_sec * 1000000 + tv.tv_usec;
}

// Función para comparar (qsort)
int compare_uint64(const void *a, const void *b) {
    uint64_t x = *(uint64_t*)a;
    uint64_t y = *(uint64_t*)b;
    if (x < y) return -1;
    if (x > y) return 1;
    return 0;
}

// Calcular estadísticas
void calculate_stats(uint64_t *latencies, int count, stats_t *stats) {
    if (count == 0) {
        memset(stats, 0, sizeof(stats_t));
        return;
    }
    
    // Ordenar para percentiles
    qsort(latencies, count, sizeof(uint64_t), compare_uint64);
    
    // Mínimo y máximo
    stats->min = latencies[0];
    stats->max = latencies[count - 1];
    
    // Media
    double sum = 0;
    for (int i = 0; i < count; i++) {
        sum += latencies[i];
    }
    stats->mean = sum / count;
    
    // Desviación estándar
    double variance = 0;
    for (int i = 0; i < count; i++) {
        double diff = latencies[i] - stats->mean;
        variance += diff * diff;
    }
    stats->stddev = sqrt(variance / count);
    
    // Percentiles
    stats->percentile_50 = latencies[(int)(count * 0.5)];
    stats->percentile_95 = latencies[(int)(count * 0.95)];
    stats->percentile_99 = latencies[(int)(count * 0.99)];
}

// Medir latencia para un tamaño de payload específico
int measure_latency_for_payload(int payload_size, int num_samples, 
                               uint64_t *latencies, int sock_send, 
                               int sock_recv, struct sockaddr_in *fpga_addr) {
    
    // Preparar buffer con el tamaño específico
    uint8_t *buffer = malloc(payload_size);
    if (!buffer) {
        fprintf(stderr, "Error: No se pudo asignar memoria para buffer de %d bytes\n", payload_size);
        return -1;
    }
    
    memset(buffer, 0xAA, payload_size);
    int received = 0;
    
    for (int seq = 0; seq < num_samples; seq++) {
        // Marcar secuencia y timestamp
        *(uint32_t*)buffer = seq;
        *(uint64_t*)(buffer + 4) = get_time_us();
        
        // Enviar y medir tiempo
        uint64_t start = get_time_us();
        if (sendto(sock_send, buffer, payload_size, 0, 
                  (struct sockaddr*)fpga_addr, sizeof(*fpga_addr)) != payload_size) {
            printf("Error enviando paquete %d\n", seq);
            continue;
        }
        
        // Recibir respuesta
        struct sockaddr_in from_addr;
        socklen_t from_len = sizeof(from_addr);
        
        int recv_bytes = recvfrom(sock_recv, buffer, payload_size, 0,
                                 (struct sockaddr*)&from_addr, &from_len);
        
        if (recv_bytes == payload_size) {
            uint64_t end = get_time_us();
            latencies[received] = end - start;
            received++;
        } else if (recv_bytes < 0) {
            // Timeout o error
            if (seq % 100 == 0) {  // Reportar cada 100 timeout
                printf("  Timeout en paquete %d/%d\n", seq, num_samples);
            }
        }
        
        // Pequeña pausa para no saturar (ajustable)
        if (payload_size < 1000) {
            usleep(1000);  // 1ms para payloads pequeños
        } else {
            usleep(2000);  // 2ms para payloads grandes
        }
    }
    
    free(buffer);
    return received;
}

// Guardar datos en formato CSV
void save_to_csv(const char *filename, int *payload_sizes, stats_t *stats, 
                int num_points, int samples_per_point) {
    FILE *fp = fopen(filename, "w");
    if (!fp) {
        perror("Error abriendo archivo CSV");
        return;
    }
    
    // Encabezados
    fprintf(fp, "payload_size,samples,min_us,max_us,mean_us,stddev_us,"
                "p50_us,p95_us,p99_us\n");
    
    // Datos
    for (int i = 0; i < num_points; i++) {
        fprintf(fp, "%d,%d,%.2f,%.2f,%.2f,%.2f,%.2f,%.2f,%.2f\n",
                payload_sizes[i],
                samples_per_point,
                stats[i].min,
                stats[i].max,
                stats[i].mean,
                stats[i].stddev,
                stats[i].percentile_50,
                stats[i].percentile_95,
                stats[i].percentile_99);
    }
    
    fclose(fp);
    printf("\nDatos guardados en: %s\n", filename);
}

// Generar script gnuplot
void generate_gnuplot_script(const char *data_file, const char *output_file) {
    FILE *fp = fopen("plot_latency.gp", "w");
    if (!fp) return;
    
    fprintf(fp, "#!/usr/bin/gnuplot\n");
    fprintf(fp, "set terminal pngcairo size 1600,1200 enhanced font 'Verdana,12'\n");
    fprintf(fp, "set output '%s'\n", output_file);
    fprintf(fp, "set multiplot layout 2,2 title 'Análisis de Latencia vs Tamaño de Payload' font 'Verdana,14'\n\n");
    
    // Gráfica 1: Latencia media con barras de error (stddev)
    fprintf(fp, "set title 'Latencia Media y Desviación Estándar'\n");
    fprintf(fp, "set xlabel 'Tamaño de Payload (bytes)'\n");
    fprintf(fp, "set ylabel 'Latencia (μs)'\n");
    fprintf(fp, "set grid\n");
    fprintf(fp, "plot '%s' using 1:4:5 with yerrorlines title 'Media ± σ' lc rgb 'blue', \\\n", data_file);
    fprintf(fp, "     '%s' using 1:4 with lines notitle lc rgb 'blue'\n\n", data_file);
    
    // Gráfica 2: Percentiles
    fprintf(fp, "set title 'Percentiles de Latencia (P50, P95, P99)'\n");
    fprintf(fp, "set xlabel 'Tamaño de Payload (bytes)'\n");
    fprintf(fp, "set ylabel 'Latencia (μs)'\n");
    fprintf(fp, "set grid\n");
    fprintf(fp, "plot '%s' using 1:7 with lines title 'P50' lw 2 lc rgb 'green', \\\n", data_file);
    fprintf(fp, "     '%s' using 1:8 with lines title 'P95' lw 2 lc rgb 'orange', \\\n", data_file);
    fprintf(fp, "     '%s' using 1:9 with lines title 'P99' lw 2 lc rgb 'red'\n\n", data_file);
    
    // Gráfica 3: Rango mínimo-máximo
    fprintf(fp, "set title 'Rango de Latencia (Mín-Máx)'\n");
    fprintf(fp, "set xlabel 'Tamaño de Payload (bytes)'\n");
    fprintf(fp, "set ylabel 'Latencia (μs)'\n");
    fprintf(fp, "set grid\n");
    fprintf(fp, "plot '%s' using 1:3:2 with yerrorlines title 'Rango' lc rgb 'purple' fill transparent solid 0.2\n\n", data_file);
    
    // Gráfica 4: Desviación estándar normalizada
    fprintf(fp, "set title 'Coeficiente de Variación (σ/μ)'\n");
    fprintf(fp, "set xlabel 'Tamaño de Payload (bytes)'\n");
    fprintf(fp, "set ylabel 'CV (σ/μ, %%)'\n");
    fprintf(fp, "set grid\n");
    fprintf(fp, "plot '%s' using 1:($5/$4*100) with linespoints title 'Coeficiente de Variación' lc rgb 'brown' lw 2\n\n", data_file);
    
    fprintf(fp, "unset multiplot\n");
    fclose(fp);
    
    printf("Script gnuplot generado: plot_latency.gp\n");
    printf("Ejecutar con: gnuplot plot_latency.gp\n");
}

int main(int argc, char *argv[]) {
    // Configuración por defecto
    int samples_per_point = DEFAULT_SAMPLES;
    int payload_min = 1;          // Mínimo posible (solo headers)
    int payload_max = MAX_PAYLOAD; // Máximo UDP
    int payload_step = 1000;      // Incremento
    
    // Parsear argumentos
    if (argc >= 2) samples_per_point = atoi(argv[1]);
    if (argc >= 3) payload_min = atoi(argv[2]);
    if (argc >= 4) payload_max = atoi(argv[3]);
    if (argc >= 5) payload_step = atoi(argv[4]);
    
    if (payload_min < 1) payload_min = 1;
    if (payload_max > MAX_PAYLOAD) payload_max = MAX_PAYLOAD;
    if (payload_step < 1) payload_step = 100;
    
    printf("Configuración:\n");
    printf("  Muestras por punto: %d\n", samples_per_point);
    printf("  Payload mínimo: %d bytes\n", payload_min);
    printf("  Payload máximo: %d bytes\n", payload_max);
    printf("  Incremento: %d bytes\n", payload_step);
    printf("  Puntos a medir: %d\n\n", (payload_max - payload_min) / payload_step + 1);
    
    // Crear sockets
    int send_sock = socket(AF_INET, SOCK_DGRAM, 0);
    int recv_sock = socket(AF_INET, SOCK_DGRAM, 0);
    
    if (send_sock < 0 || recv_sock < 0) {
        perror("Error creando sockets");
        return 1;
    }
    
    // Configurar recepción
    struct sockaddr_in local_addr = {0};
    local_addr.sin_family = AF_INET;
    local_addr.sin_addr.s_addr = INADDR_ANY;
    local_addr.sin_port = htons(LOCAL_PORT);
    
    if (bind(recv_sock, (struct sockaddr*)&local_addr, sizeof(local_addr)) < 0) {
        perror("Error bind");
        close(send_sock);
        close(recv_sock);
        return 1;
    }
    
    // Timeout de recepción (2 segundos)
    struct timeval tv = {2, 0};
    setsockopt(recv_sock, SOL_SOCKET, SO_RCVTIMEO, &tv, sizeof(tv));
    
    // Dirección FPGA
    struct sockaddr_in fpga_addr = {0};
    fpga_addr.sin_family = AF_INET;
    fpga_addr.sin_port = htons(FPGA_PORT);
    inet_pton(AF_INET, FPGA_IP, &fpga_addr.sin_addr);
    
    // Preparar arrays para resultados
    int num_points = (payload_max - payload_min) / payload_step + 1;
    int *payload_sizes = malloc(num_points * sizeof(int));
    stats_t *stats = malloc(num_points * sizeof(stats_t));
    uint64_t *latencies = malloc(samples_per_point * sizeof(uint64_t));
    
    if (!payload_sizes || !stats || !latencies) {
        perror("Error asignando memoria");
        free(payload_sizes);
        free(stats);
        free(latencies);
        close(send_sock);
        close(recv_sock);
        return 1;
    }
    
    // Generar secuencia de tamaños de payload
    for (int i = 0; i < num_points; i++) {
        payload_sizes[i] = payload_min + i * payload_step;
    }
    
    printf("Iniciando mediciones...\n");
    printf("════════════════════════════════════════════════════════════════\n");
    
    // Medir para cada tamaño de payload
    for (int i = 0; i < num_points; i++) {
        int payload_size = payload_sizes[i];
        
        printf("\nPayload: %d bytes [%d/%d]\n", payload_size, i+1, num_points);
        printf("  Midiendo %d muestras...", samples_per_point);
        fflush(stdout);
        
        int received = measure_latency_for_payload(payload_size, samples_per_point,
                                                  latencies, send_sock, recv_sock,
                                                  &fpga_addr);
        
        if (received > 0) {
            calculate_stats(latencies, received, &stats[i]);
            
            printf(" OK (recibidos: %d/%d)\n", received, samples_per_point);
            printf("  Estadísticas: Min=%.2fμs, Max=%.2fμs, Mean=%.2fμs, σ=%.2fμs\n",
                   stats[i].min, stats[i].max, stats[i].mean, stats[i].stddev);
            printf("  Percentiles: P50=%.2fμs, P95=%.2fμs, P99=%.2fμs\n",
                   stats[i].percentile_50, stats[i].percentile_95, stats[i].percentile_99);
        } else {
            printf(" ERROR: No se recibieron respuestas\n");
            memset(&stats[i], 0, sizeof(stats_t));
        }
        
        // Pausa entre diferentes tamaños de payload
        if (i < num_points - 1) {
            usleep(500000);  // 0.5 segundos
        }
    }
    
    printf("\n════════════════════════════════════════════════════════════════\n");
    printf("Mediciones completadas.\n");
    
    // Guardar resultados
    save_to_csv("latency_results.csv", payload_sizes, stats, num_points, samples_per_point);
    
    // Generar script de visualización
    generate_gnuplot_script("latency_results.csv", "latency_analysis.png");
    
    // Imprimir resumen de mejores/peores casos
    printf("\nResumen:\n");
    printf("----------------------------------------\n");
    
    int best_idx = 0, worst_idx = 0;
    for (int i = 1; i < num_points; i++) {
        if (stats[i].mean > 0 && (stats[best_idx].mean == 0 || stats[i].mean < stats[best_idx].mean))
            best_idx = i;
        if (stats[i].mean > stats[worst_idx].mean)
            worst_idx = i;
    }
    
    printf("Mejor latencia: %.2fμs @ %d bytes\n", stats[best_idx].mean, payload_sizes[best_idx]);
    printf("Peor latencia:  %.2fμs @ %d bytes\n", stats[worst_idx].mean, payload_sizes[worst_idx]);
    
    // Liberar recursos
    free(payload_sizes);
    free(stats);
    free(latencies);
    close(send_sock);
    close(recv_sock);
    
    printf("\nPara visualizar los datos:\n");
    printf("1. Instalar gnuplot: sudo apt-get install gnuplot\n");
    printf("2. Generar gráfica: gnuplot plot_latency.gp\n");
    printf("3. Abrir: latency_analysis.png\n");
    printf("4. Los datos crudos están en: latency_results.csv\n");
    
    return 0;
}
