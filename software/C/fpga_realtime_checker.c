// gcc -O2 -pthread -o fpga_realtime_checker fpga_realtime_checker.c
// Ejecuta: ./fpga_realtime_checker

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

// ================= CONFIGURACIÓN =================
#define PORT 9999
#define FPGA_IP "192.168.1.100"   // IP local del FPGA
#define PAYLOAD_SIZE 8192         // Bytes por paquete UDP
#define NUMBERS_PER_PACKET (PAYLOAD_SIZE / 8)
#define KERNEL_RCVBUF (512 * 1024 * 1024) // 512 MB
#define TEST_MESSAGE 0x0A2E545345542E0AULL // "\n.TEST.\n" en little-endian
#define MAX_TEST_MESSAGES_LOG 100
// =================================================

static volatile sig_atomic_t running = 1;

// Estructura para guardar mensajes TEST detectados
typedef struct {
    uint64_t global_position;
    uint64_t expected_sequence;
    uint64_t packet_number;
    int position_in_packet;
    double timestamp;
} test_message_log_t;

test_message_log_t test_messages_log[MAX_TEST_MESSAGES_LOG];
int test_message_log_count = 0;

void int_handler(int sig) {
    (void)sig;
    running = 0;
    (void)write(STDOUT_FILENO, "\n[Signal] Ctrl+C — deteniendo verificación...\n", 46);
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

// Función para loguear mensaje TEST
void log_test_message(uint64_t global_pos, uint64_t expected, uint64_t pkt_num, int pos_in_pkt) {
    if (test_message_log_count < MAX_TEST_MESSAGES_LOG) {
        test_messages_log[test_message_log_count].global_position = global_pos;
        test_messages_log[test_message_log_count].expected_sequence = expected;
        test_messages_log[test_message_log_count].packet_number = pkt_num;
        test_messages_log[test_message_log_count].position_in_packet = pos_in_pkt;
        test_messages_log[test_message_log_count].timestamp = now_seconds();
        test_message_log_count++;
    }
}

int main(void) {
    signal(SIGINT, int_handler);
    signal(SIGTERM, int_handler);

    printf("=== FPGA Real-Time Sequence Checker ===\n");
    printf("Escuchando en %s:%d\n", FPGA_IP, PORT);
    printf("Verificando secuencia de números de 64 bits en tiempo real...\n");
    printf("Buscando mensajes TEST: 0x%016lX\n\n", TEST_MESSAGE);

    // Crear socket UDP
    int sockfd = socket(AF_INET, SOCK_DGRAM, 0);
    if (sockfd < 0) { perror("socket"); return 1; }

    int opt = 1;
    setsockopt(sockfd, SOL_SOCKET, SO_REUSEADDR, &opt, sizeof(opt));
#ifdef SO_REUSEPORT
    setsockopt(sockfd, SOL_SOCKET, SO_REUSEPORT, &opt, sizeof(opt));
#endif

    int rcv = KERNEL_RCVBUF;
    if (setsockopt(sockfd, SOL_SOCKET, SO_RCVBUF, &rcv, sizeof(rcv)) != 0)
        perror("setsockopt(SO_RCVBUF)");

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

    // === Hacer que recv() no bloquee indefinidamente ===
    struct timeval tv;
    tv.tv_sec = 1;   // timeout de 1 segundo
    tv.tv_usec = 0;
    if (setsockopt(sockfd, SOL_SOCKET, SO_RCVTIMEO, &tv, sizeof(tv)) < 0) {
        perror("setsockopt(SO_RCVTIMEO)");
    }

    uint8_t buffer[PAYLOAD_SIZE];
    uint64_t *nums = (uint64_t *)buffer;

    uint64_t expected_seq = 0;
    int first_packet = 1;
    unsigned long long total_packets = 0;
    unsigned long long total_numbers = 0;
    unsigned long long total_errors = 0;
    unsigned long long total_test_messages = 0;

    double start_t = now_seconds();
    double last_t = start_t;
    uint64_t last_seq = 0;

    while (running) {
        ssize_t r = recv(sockfd, buffer, sizeof(buffer), 0);
        if (r < 0) {
            if (errno == EINTR) continue;
            if (errno == EAGAIN || errno == EWOULDBLOCK) { usleep(1000); continue; }
            perror("recv");
            break;
        }

        if (r != PAYLOAD_SIZE) {
            fprintf(stderr, "Advertencia: paquete UDP tamaño inesperado (%zd bytes)\n", r);
            continue;
        }

        total_packets++;
        total_numbers += NUMBERS_PER_PACKET;

        for (int i = 0; i < NUMBERS_PER_PACKET; i++) {
            uint64_t val = nums[i];
            uint64_t global_position = total_numbers - NUMBERS_PER_PACKET + i;

            if (first_packet) {
                expected_seq = val;
                first_packet = 0;
            }

            // NUEVO: Detectar mensaje TEST
            if (is_test_message(val)) {
                total_test_messages++;
                log_test_message(global_position, expected_seq, total_packets, i);
                
                printf("🔍 MENSAJE TEST #%llu detectado\n", total_test_messages);
                printf("   📍 Posición global: %lu\n", global_position);
                printf("   📦 Paquete: %llu, Posición en paquete: %d\n", total_packets, i);
                printf("   🔢 Número esperado: %lu\n", expected_seq);
                
                // Continuar secuencia normalmente (el mensaje TEST reemplaza un número)
                expected_seq++;
                continue;
            }

            // Verificar secuencia normal
            if (val != expected_seq) {
                uint64_t diff = (val > expected_seq) ? val - expected_seq : expected_seq - val;
                total_errors++;
                
                // Distinguir entre errores reales y mensajes TEST no detectados
                if (diff == 1) {
                    printf("⚠️  Gap pequeño #%llu — Esperado: %lu, Recibido: %lu\n",
                           total_errors, expected_seq, val);
                } else {
                    printf("🚨 Error #%llu — Esperado: %lu, Recibido: %lu (Δ=%lu)\n",
                           total_errors, expected_seq, val, diff);
                }
                
                expected_seq = val + 1; // re-sincronizar
            } else {
                expected_seq++;
            }
            last_seq = val;
        }

        double now = now_seconds();
        if (now - last_t >= 2.0) {
            double elapsed = now - start_t;
            double mbps = (double)(total_packets * PAYLOAD_SIZE) * 8.0 / elapsed / 1e6;
            printf("[%.1fs] Paquetes: %llu | Errores: %llu | TEST: %llu | Vel: %.2f Mbps | Último: %lu\r",
                   elapsed, total_packets, total_errors, total_test_messages, mbps, last_seq);
            fflush(stdout);
            last_t = now;
        }
    }

    double end_t = now_seconds();
    double elapsed = end_t - start_t;
    double mbps = (double)(total_packets * PAYLOAD_SIZE) * 8.0 / elapsed / 1e6;

    printf("\n\n=== RESULTADOS FINALES ===\n");
    printf("Total de paquetes recibidos: %llu\n", total_packets);
    printf("Total de números verificados: %llu\n", total_numbers);
    printf("Errores de secuencia: %llu\n", total_errors);
    printf("Mensajes TEST detectados: %llu\n", total_test_messages);
    printf("Último número correcto: %lu\n", last_seq);
    printf("Tasa promedio: %.2f Mbps\n", mbps);
    printf("Duración: %.2f segundos\n", elapsed);

    // NUEVO: Reporte detallado de mensajes TEST
    if (total_test_messages > 0) {
        printf("\n=== DETALLES DE MENSAJES TEST ===\n");
        printf("Total detectados: %llu\n", total_test_messages);
        printf("Primeros %d mensajes:\n", 
               test_message_log_count > 5 ? 5 : test_message_log_count);
        
        for (int i = 0; i < (test_message_log_count > 5 ? 5 : test_message_log_count); i++) {
            printf("  %d. Posición global: %lu\n", i + 1, test_messages_log[i].global_position);
            printf("     Paquete: %lu, Offset: %d\n", 
                   test_messages_log[i].packet_number, 
                   test_messages_log[i].position_in_packet);
            printf("     Número esperado: %lu\n", test_messages_log[i].expected_sequence);
            printf("     Tiempo: %.1f segundos\n", test_messages_log[i].timestamp - start_t);
        }
        
        if (test_message_log_count > 5) {
            printf("  ... y %d mensajes más\n", test_message_log_count - 5);
        }
        
        // Análisis de distribución
        printf("\nDistribución en paquetes:\n");
        int test_count_in_current_packet = 0;
        uint64_t last_packet = 0;
        
        for (int i = 0; i < test_message_log_count; i++) {
            if (test_messages_log[i].packet_number != last_packet) {
                if (last_packet != 0 && test_count_in_current_packet > 0) {
                    printf("  Paquete %lu: %d mensajes TEST\n", last_packet, test_count_in_current_packet);
                }
                last_packet = test_messages_log[i].packet_number;
                test_count_in_current_packet = 1;
            } else {
                test_count_in_current_packet++;
            }
        }
        if (test_count_in_current_packet > 0) {
            printf("  Paquete %lu: %d mensajes TEST\n", last_packet, test_count_in_current_packet);
        }
    }

    // Análisis final
    printf("\n=== ANÁLISIS FINAL ===\n");
    if (total_errors == 0 && total_test_messages == 0) {
        printf("✅ SECUENCIA PERFECTA - Sin errores ni mensajes TEST\n");
    } else if (total_errors == 0) {
        printf("✅ SECUENCIA CON MENSAJES TEST CONTROLADOS\n");
        printf("   • %llu inserciones controladas de TEST\n", total_test_messages);
        printf("   • Sin pérdidas de paquetes detectadas\n");
    } else {
        double error_rate = (double)total_errors / total_numbers * 100.0;
        printf("⚠️  SECUENCIA CON ERRORES\n");
        printf("   • Tasa de error: %.6f%%\n", error_rate);
        printf("   • %llu mensajes TEST controlados\n", total_test_messages);
    }

    close(sockfd);
    return 0;
}