// gcc -O2 -pthread -o udp_checksum_checker udp_checksum_checker.c
// Ejecuta: sudo ./udp_checksum_checker

#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <signal.h>
#include <arpa/inet.h>
#include <sys/socket.h>
#include <fcntl.h>
#include <errno.h>
#include <unistd.h>
#include <time.h>
#include <netinet/udp.h>
#include <netinet/ip.h>
#include <inttypes.h>

// ================= CONFIGURACIÓN =================
#define PORT 9999
#define FPGA_IP "192.168.1.100"   // IP local del FPGA
#define BUFFER_SIZE 9000          // Tamaño suficiente para IP + UDP + payload
#define PAYLOAD_SIZE 8192         // Bytes por paquete UDP
#define NUMBERS_PER_PACKET (PAYLOAD_SIZE / 8)  // 8192/8 = 1024 números de 64 bits
#define TEST_MESSAGE UINT64_C(0x0A2E545345542E0A) // "\n.TEST.\n" en little-endian
#define MAX_TEST_MESSAGES_LOG 20  // Reducido para solo los últimos
// =================================================

static volatile sig_atomic_t running = 1;

// Estructura para cabecera IP (sin opciones)
struct ip_header {
    uint8_t  ihl:4, version:4;
    uint8_t  tos;
    uint16_t tot_len;
    uint16_t id;
    uint16_t frag_off;
    uint8_t  ttl;
    uint8_t  protocol;
    uint16_t check;
    uint32_t saddr;
    uint32_t daddr;
};

// Estructura para cabecera UDP
struct udp_header {
    uint16_t source;
    uint16_t dest;
    uint16_t len;
    uint16_t check;
};

// Variables globales para el estado actual
uint64_t current_test_period = 0;  // Período actual en mensajes UDP
uint64_t current_test_offset = 0;
uint64_t packet_loss_count = 0;
uint64_t total_test_messages = 0;
uint64_t messages_since_last_test = 0; // Contador de mensajes desde último TEST
uint64_t last_test_packet = 0;         // Último paquete donde se detectó TEST
uint64_t last_period = 0;              // Período anterior para detección de cambios

// Función para calcular checksum (algoritmo estándar de Internet)
uint16_t calculate_checksum(const void *data, int length) {
    const uint16_t *words = (const uint16_t *)data;
    uint32_t sum = 0;
    
    for (int i = 0; i < length / 2; i++) {
        sum += words[i];
    }
    
    if (length % 2) {
        uint16_t final = ((const uint8_t *)data)[length - 1] << 8;
        sum += final;
    }
    
    while (sum >> 16) {
        sum = (sum & 0xFFFF) + (sum >> 16);
    }
    
    return (uint16_t)~sum;
}

// Función para calcular checksum UDP con pseudo-header
uint16_t calculate_udp_checksum(const struct ip_header *ip, const struct udp_header *udp, const void *payload, int payload_len) {
    struct pseudo_header {
        uint32_t src_ip;
        uint32_t dst_ip;
        uint8_t zero;
        uint8_t protocol;
        uint16_t udp_length;
    } __attribute__((packed));
    
    struct pseudo_header ph;
    ph.src_ip = ip->saddr;
    ph.dst_ip = ip->daddr;
    ph.zero = 0;
    ph.protocol = IPPROTO_UDP;
    ph.udp_length = udp->len;
    
    int total_len = sizeof(ph) + sizeof(struct udp_header) + payload_len;
    if (payload_len % 2) total_len++;
    
    uint8_t *check_buf = malloc(total_len);
    if (!check_buf) return 0;
    
    memcpy(check_buf, &ph, sizeof(ph));
    
    struct udp_header udp_temp = *udp;
    udp_temp.check = 0;
    memcpy(check_buf + sizeof(ph), &udp_temp, sizeof(udp_temp));
    
    memcpy(check_buf + sizeof(ph) + sizeof(udp_temp), payload, payload_len);
    
    if (payload_len % 2) {
        check_buf[total_len - 1] = 0;
    }
    
    uint16_t checksum = calculate_checksum(check_buf, total_len);
    free(check_buf);
    return checksum;
}

void int_handler(int sig) {
    (void)sig;
    running = 0;
    printf("\n[Signal] Ctrl+C - deteniendo verificacion...\n");
}

double now_seconds() {
    struct timespec ts;
    clock_gettime(CLOCK_MONOTONIC, &ts);
    return ts.tv_sec + ts.tv_nsec * 1e-9;
}

// Función para detectar mensaje TEST
static inline int is_test_message(uint64_t value) {
    return (value == TEST_MESSAGE);
}

// Función para procesar un nuevo mensaje TEST
void process_test_message(uint64_t pkt_num, int pos_in_pkt) {
    total_test_messages++;
    
    // Calcular período actual (mensajes desde el último TEST)
    uint64_t new_period = messages_since_last_test;
    
    // Si no es el primer TEST
    if (last_test_packet > 0) {
        // Si el período se hizo menor que el fijado entonces posible perdida de paquetes
        if (new_period < current_test_period) {
            uint64_t lost_tests = current_test_period - new_period;
            packet_loss_count += lost_tests;
            printf("PERDIDA: %" PRIu64 " Mensajes | Periodo %" PRIu64 " -> %" PRIu64 " | Offset: %d\n\n", 
                lost_tests, current_test_period, new_period, pos_in_pkt);
        }
        
    } else {
        // Primer TEST
        printf("PRIMER TEST: Periodo %" PRIu64 " fijado | Offset: %d\n\n", new_period, pos_in_pkt);
        current_test_period = new_period; // Fijar el periodo con el primer test
    }
    
    current_test_offset = pos_in_pkt;
    last_test_packet = pkt_num;
    
    // Resetear contador para próximo TEST
    messages_since_last_test = 0;
}

// Función para limpiar la pantalla (mover cursor arriba)
void clear_lines(int lines) {
    for (int i = 0; i < lines; i++) {
        printf("\033[1A\033[2K"); // Mover arriba y limpiar línea
    }
}

int main(void) {
    signal(SIGINT, int_handler);
    signal(SIGTERM, int_handler);

    printf("=== UDP Checksum & Sequence Checker ===\n");
    printf("Escuchando en %s:%d | Buscando TEST: 0x%016" PRIX64 "\n", FPGA_IP, PORT, TEST_MESSAGE);
    printf("Presiona Ctrl+C para detener y mostrar estadisticas\n\n");

    // Crear socket RAW para recibir cabeceras IP
    int sockfd = socket(AF_INET, SOCK_RAW, IPPROTO_UDP);
    if (sockfd < 0) {
        perror("socket RAW");
        printf("Necesitas permisos de root para socket RAW.\n");
        return 1;
    }

    int opt = 1;
    setsockopt(sockfd, SOL_SOCKET, SO_REUSEADDR, &opt, sizeof(opt));

    int rcvbuf = 1024 * 1024;
    setsockopt(sockfd, SOL_SOCKET, SO_RCVBUF, &rcvbuf, sizeof(rcvbuf));

    struct sockaddr_in addr;
    memset(&addr, 0, sizeof(addr));
    addr.sin_family = AF_INET;
    addr.sin_port = htons(PORT);
    addr.sin_addr.s_addr = inet_addr(FPGA_IP);

    if (bind(sockfd, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
        perror("bind");
        close(sockfd);
        return 1;
    }

    struct timeval tv;
    tv.tv_sec = 1;
    tv.tv_usec = 0;
    setsockopt(sockfd, SOL_SOCKET, SO_RCVTIMEO, &tv, sizeof(tv));

    uint8_t buffer[BUFFER_SIZE];
    unsigned long long total_packets = 0;
    unsigned long long total_checksum_errors = 0;
    unsigned long long total_checksum_ok = 0;
    unsigned long long total_numbers = 0;

    double start_t = now_seconds();
    double last_t = start_t;
    double last_stats_t = start_t;

    int stats_lines = 0; // Para controlar cuántas líneas limpiar

    while (running) {
        ssize_t r = recv(sockfd, buffer, sizeof(buffer), 0);
        if (r < 0) {
            if (errno == EINTR) continue;
            if (errno == EAGAIN || errno == EWOULDBLOCK) { 
                usleep(1000); 
                continue; 
            }
            perror("recv");
            break;
        }

        total_packets++;

        // Incrementar contador de mensajes desde último TEST (cada paquete UDP cuenta como 1 mensaje)
        messages_since_last_test++;

        if (r >= (ssize_t)(sizeof(struct ip_header) + sizeof(struct udp_header))) {
            struct ip_header *ip = (struct ip_header *)buffer;
            struct udp_header *udp = (struct udp_header *)(buffer + (ip->ihl * 4));
            
            int ip_header_len = ip->ihl * 4;
            int udp_len = ntohs(udp->len) - sizeof(struct udp_header);
            void *payload = buffer + ip_header_len + sizeof(struct udp_header);
            
            if (udp_len > 0 && udp_len <= (r - ip_header_len - sizeof(struct udp_header))) {
                uint16_t received_checksum = udp->check;
                
                // Verificar checksum incluyendo el 0
                uint16_t calculated_checksum = calculate_udp_checksum(ip, udp, payload, udp_len);
                if (calculated_checksum == received_checksum) {
                    total_checksum_ok++;
                } else {
                    total_checksum_errors++;
                }
                
                // Buscar mensajes TEST en el payload
                if (udp_len >= 8) {
                    uint64_t *numbers = (uint64_t *)payload;
                    int num_numbers = udp_len / 8;
                    
                    for (int i = 0; i < num_numbers; i++) {
                        if (is_test_message(numbers[i])) {
                            process_test_message(total_packets, i);
                            break; // Solo procesar un TEST por paquete
                        }
                    }
                    total_numbers += num_numbers;
                }
            }
        }

        double now = now_seconds();
        
        // Actualizar estadísticas cada 0.5 segundos (más suave)
        if (now - last_stats_t >= 0.5) {
            
            double elapsed = now - start_t;
            double pps = total_packets / elapsed;
            double mbps = (total_packets * PAYLOAD_SIZE * 8.0) / elapsed / 1e6;
            
            // Línea 1: Estadísticas generales
            printf("[%.1fs] Pkts: %llu | OK: %llu | Err: %llu | TEST: %llu | Perdidas: %" PRIu64 "\n", 
                   elapsed, total_packets, total_checksum_ok, total_checksum_errors, total_test_messages, packet_loss_count);
            
            // Línea 2: Rendimiento e información del TEST actual
            if (current_test_period > 0) {
                printf("        Vel: %.1f pps (%.1f Mbps) | Periodo: %" PRIu64 " | Offset: %" PRIu64 "\n", 
                       pps, mbps, current_test_period, current_test_offset);
            } else {
                printf("        Vel: %.1f pps (%.1f Mbps) | Esperando primer TEST...\n", pps, mbps);
            }
            
            clear_lines(2); // Dos líneas a limpiar
            last_stats_t = now;
        }
        
        last_t = now;
    }

    double end_t = now_seconds();
    double elapsed = end_t - start_t;

    printf("\n=== RESULTADOS FINALES ===\n");
    printf("Total de paquetes recibidos: %llu\n", total_packets);
    printf("Total de numeros procesados: %llu\n", total_numbers);
    printf("Checksums correctos: %llu\n", total_checksum_ok);
    printf("Errores de checksum: %llu\n", total_checksum_errors);
    printf("Mensajes TEST detectados: %llu\n", total_test_messages);
    printf("Perdidas de paquetes detectadas: %" PRIu64 "\n", packet_loss_count);
    
    double mbps = (total_packets * PAYLOAD_SIZE * 8.0) / elapsed / 1e6;
    printf("Velocidad promedio: %.1f Mbps\n", mbps);
    printf("Duracion: %.2f segundos\n", elapsed);

    close(sockfd);
    return 0;
}