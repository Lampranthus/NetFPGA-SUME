/*
gcc -O3 -o udp_loopback_test udp_loopback_test.c
Uso: ./udp_loopback_test <num_packets>

Ejemplo: ./udp_loopback_test 1000

Descripción:
- Envía paquetes UDP de 8192 bytes a FPGA 192.168.1.128:1234
- FPGA reenvía a SOURCE_IP:9999
- Verifica que los datos recibidos sean idénticos a los enviados
*/

#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <unistd.h>
#include <arpa/inet.h>
#include <sys/socket.h>
#include <sys/time.h>
#include <sys/select.h>
#include <fcntl.h>
#include <time.h>
#include <errno.h>
#include <signal.h>

#define FPGA_IP "192.168.1.128"
#define FPGA_PORT 1234
#define LOCAL_PORT 9999
#define PAYLOAD_SIZE 8192
#define UDP_HEADER_SIZE 8
#define IP_HEADER_SIZE 20
#define ETH_HEADER_SIZE 14
#define TOTAL_PACKET_SIZE (PAYLOAD_SIZE + UDP_HEADER_SIZE + IP_HEADER_SIZE + ETH_HEADER_SIZE)

// Estadísticas globales
typedef struct {
    uint64_t packets_sent;
    uint64_t packets_received;
    uint64_t bytes_sent;
    uint64_t bytes_received;
    uint64_t errors;
    uint64_t out_of_order;
    uint32_t last_sequence;
} stats_t;

static volatile int running = 1;
static stats_t stats;

static double now_seconds() {
    struct timespec ts;
    clock_gettime(CLOCK_MONOTONIC, &ts);
    return ts.tv_sec + ts.tv_nsec * 1e-9;
}

void print_stats() {
    printf("\n--- Estadísticas Finales ---\n");
    printf("Paquetes enviados:    %lu\n", stats.packets_sent);
    printf("Paquetes recibidos:   %lu\n", stats.packets_received);
    printf("Bytes enviados:       %lu\n", stats.bytes_sent);
    printf("Bytes recibidos:      %lu\n", stats.bytes_received);
    printf("Errores:              %lu\n", stats.errors);
    printf("Paquetes fuera de orden: %lu\n", stats.out_of_order);
    printf("Paquetes perdidos:    %lu\n", 
           stats.packets_sent - stats.packets_received);
    
    if (stats.packets_sent > 0) {
        double loss_percent = (double)(stats.packets_sent - stats.packets_received) * 100.0 / stats.packets_sent;
        printf("Porcentaje de pérdida: %.2f%%\n", loss_percent);
    }
}

void signal_handler(int sig) {
    running = 0;
    printf("\nSeñal recibida, terminando...\n");
}

// Generar datos pseudo-aleatorios con patrón verificable
void generate_payload(uint8_t *buffer, uint32_t sequence) {
    // Patrón: [sequence][timestamp][datos pseudo-aleatorios]
    uint32_t *buf32 = (uint32_t*)buffer;
    struct timeval tv;
    gettimeofday(&tv, NULL);
    
    // Header del paquete
    buf32[0] = sequence;                    // Número de secuencia
    buf32[1] = tv.tv_sec;                   // Timestamp segundos
    buf32[2] = tv.tv_usec;                  // Timestamp microsegundos
    buf32[3] = 0xDEADBEEF;                  // Magic number
    
    // Datos pseudo-aleatorios (reproducibles)
    for (int i = 16; i < PAYLOAD_SIZE; i++) {
        buffer[i] = (sequence + i) & 0xFF;
    }
}

// Verificar que los datos recibidos sean correctos
int verify_payload(const uint8_t *buffer, uint32_t expected_sequence) {
    const uint32_t *buf32 = (const uint32_t*)buffer;
    
    // Verificar magic number
    if (buf32[3] != 0xDEADBEEF) {
        printf("ERROR: Magic number incorrecto: 0x%08X\n", buf32[3]);
        return 0;
    }
    
    // Verificar secuencia
    if (buf32[0] != expected_sequence) {
        printf("WARNING: Secuencia esperada %u, recibida %u\n", 
               expected_sequence, buf32[0]);
        stats.out_of_order++;
        // Continuamos la verificación a pesar del out-of-order
    }
    
    // Verificar datos
    for (int i = 16; i < PAYLOAD_SIZE; i++) {
        uint8_t expected = (expected_sequence + i) & 0xFF;
        if (buffer[i] != expected) {
            printf("ERROR: Byte %d incorrecto: esperado 0x%02X, recibido 0x%02X\n",
                   i, expected, buffer[i]);
            return 0;
        }
    }
    
    return 1;
}

int main(int argc, char *argv[]) {
    if (argc != 2) {
        printf("Uso: %s <num_paquetes>\n", argv[0]);
        printf("Ejemplo: %s 1000\n", argv[0]);
        return 1;
    }
    
    int num_packets = atoi(argv[1]);
    if (num_packets <= 0) {
        printf("Error: número de paquetes debe ser positivo\n");
        return 1;
    }
    
    printf("Iniciando test UDP Loopback\n");
    printf("FPGA: %s:%d\n", FPGA_IP, FPGA_PORT);
    printf("Local port: %d\n", LOCAL_PORT);
    printf("Payload size: %d bytes\n", PAYLOAD_SIZE);
    printf("Paquetes a enviar: %d\n", num_packets);
    printf("Tamaño total por paquete: %d bytes\n", TOTAL_PACKET_SIZE);
    printf("---\n");
    
    // Configurar manejador de señales
    signal(SIGINT, signal_handler);
    signal(SIGTERM, signal_handler);
    
    // Inicializar estadísticas
    memset(&stats, 0, sizeof(stats));
    
    // Crear socket para enviar
    int send_sock = socket(AF_INET, SOCK_DGRAM, 0);
    if (send_sock < 0) {
        perror("Error creando socket de envío");
        return 1;
    }
    
    // Configurar socket de envío
    int send_buf_size = 4 * 1024 * 1024; // 4MB
    setsockopt(send_sock, SOL_SOCKET, SO_SNDBUF, &send_buf_size, sizeof(send_buf_size));
    
    // Crear socket para recibir
    int recv_sock = socket(AF_INET, SOCK_DGRAM, 0);
    if (recv_sock < 0) {
        perror("Error creando socket de recepción");
        close(send_sock);
        return 1;
    }
    
    // Configurar socket de recepción
    int recv_buf_size = 16 * 1024 * 1024; // 16MB
    setsockopt(recv_sock, SOL_SOCKET, SO_RCVBUF, &recv_buf_size, sizeof(recv_buf_size));
    
    // Bind al puerto local para recibir loopbacks
    struct sockaddr_in local_addr;
    memset(&local_addr, 0, sizeof(local_addr));
    local_addr.sin_family = AF_INET;
    local_addr.sin_addr.s_addr = INADDR_ANY;
    local_addr.sin_port = htons(LOCAL_PORT);
    
    if (bind(recv_sock, (struct sockaddr*)&local_addr, sizeof(local_addr)) < 0) {
        perror("Error haciendo bind al puerto local");
        close(send_sock);
        close(recv_sock);
        return 1;
    }
    
    // Dirección de la FPGA
    struct sockaddr_in fpga_addr;
    memset(&fpga_addr, 0, sizeof(fpga_addr));
    fpga_addr.sin_family = AF_INET;
    fpga_addr.sin_port = htons(FPGA_PORT);
    inet_pton(AF_INET, FPGA_IP, &fpga_addr.sin_addr);
    
    // Buffer para enviar y recibir
    uint8_t send_buffer[PAYLOAD_SIZE];
    uint8_t recv_buffer[PAYLOAD_SIZE + 64]; // Margen extra
    
    // Hacer socket de recepción no bloqueante
    int flags = fcntl(recv_sock, F_GETFL, 0);
    fcntl(recv_sock, F_SETFL, flags | O_NONBLOCK);
    
    double start_time = now_seconds();
    double last_stats_time = start_time;
    
    printf("Iniciando envío y recepción...\n");
    
    // Bucle principal
    for (uint32_t sequence = 0; sequence < num_packets && running; sequence++) {
        // Generar y enviar paquete
        generate_payload(send_buffer, sequence);
        
        ssize_t sent = sendto(send_sock, send_buffer, PAYLOAD_SIZE, 0,
                             (struct sockaddr*)&fpga_addr, sizeof(fpga_addr));
        
        if (sent == PAYLOAD_SIZE) {
            stats.packets_sent++;
            stats.bytes_sent += sent;
        } else {
            printf("Error enviando paquete %u: %s\n", sequence, strerror(errno));
            stats.errors++;
            continue;
        }
        
        // Intentar recibir paquetes pendientes
        int packets_received_this_cycle = 0;
        while (packets_received_this_cycle < 100 && running) { // Limitar por ciclo
            struct sockaddr_in src_addr;
            socklen_t addr_len = sizeof(src_addr);
            ssize_t received = recvfrom(recv_sock, recv_buffer, sizeof(recv_buffer), 0,
                                      (struct sockaddr*)&src_addr, &addr_len);
            
            if (received < 0) {
                if (errno == EAGAIN || errno == EWOULDBLOCK) {
                    break; // No hay más datos
                }
                perror("Error en recvfrom");
                break;
            }
            
            if (received == PAYLOAD_SIZE) {
                stats.packets_received++;
                stats.bytes_received += received;
                packets_received_this_cycle++;
                
                // Extraer secuencia del paquete recibido
                uint32_t recv_sequence = *(uint32_t*)recv_buffer;
                
                // Verificar integridad
                if (!verify_payload(recv_buffer, recv_sequence)) {
                    stats.errors++;
                }
                
                stats.last_sequence = recv_sequence;
            } else {
                printf("Paquete de tamaño incorrecto: %zd (esperado %d)\n", 
                       received, PAYLOAD_SIZE);
                stats.errors++;
            }
        }
        
        // Mostrar estadísticas periódicas
        double current_time = now_seconds();
        if (current_time - last_stats_time >= 1.0) {
            double elapsed = current_time - start_time;
            double send_rate = stats.packets_sent / elapsed;
            double recv_rate = stats.packets_received / elapsed;
            double throughput_mbps = (stats.bytes_received * 8.0) / (elapsed * 1e6);
            
            printf("Progress: %u/%d | TX: %.1f pps | RX: %.1f pps | Throughput: %.2f Mbps | Loss: %.1f%%\r",
                   sequence + 1, num_packets, send_rate, recv_rate, throughput_mbps,
                   (double)(stats.packets_sent - stats.packets_received) * 100.0 / stats.packets_sent);
            fflush(stdout);
            
            last_stats_time = current_time;
        }
        
        // Pequeña pausa para no saturar (ajustable)
        usleep(100);
    }
    
    // Esperar paquetes pendientes por 2 segundos
    printf("\nEsperando paquetes pendientes...\n");
    double wait_start = now_seconds();
    while ((now_seconds() - wait_start) < 2.0 && running) {
        struct sockaddr_in src_addr;
        socklen_t addr_len = sizeof(src_addr);
        ssize_t received = recvfrom(recv_sock, recv_buffer, sizeof(recv_buffer), 0,
                                  (struct sockaddr*)&src_addr, &addr_len);
        
        if (received > 0 && received == PAYLOAD_SIZE) {
            stats.packets_received++;
            stats.bytes_received += received;
            
            uint32_t recv_sequence = *(uint32_t*)recv_buffer;
            if (!verify_payload(recv_buffer, recv_sequence)) {
                stats.errors++;
            }
            stats.last_sequence = recv_sequence;
        } else if (received < 0 && (errno == EAGAIN || errno == EWOULDBLOCK)) {
            usleep(10000); // 10ms
        }
    }
    
    double total_time = now_seconds() - start_time;
    
    // Estadísticas finales
    printf("\n--- Test completado en %.2f segundos ---\n", total_time);
    print_stats();
    
    if (total_time > 0) {
        double avg_tx_pps = stats.packets_sent / total_time;
        double avg_rx_pps = stats.packets_received / total_time;
        double avg_tx_mbps = (stats.bytes_sent * 8.0) / (total_time * 1e6);
        double avg_rx_mbps = (stats.bytes_received * 8.0) / (total_time * 1e6);
        
        printf("\nRendimiento promedio:\n");
        printf("TX: %.2f paquetes/seg, %.2f Mbps\n", avg_tx_pps, avg_tx_mbps);
        printf("RX: %.2f paquetes/seg, %.2f Mbps\n", avg_rx_pps, avg_rx_mbps);
    }
    
    // Limpieza
    close(send_sock);
    close(recv_sock);
    
    return 0;
}
