/*
gcc -O3 -o simple_latency simple_latency.c
Uso: ./simple_latency <num_paquetes>
*/

#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <unistd.h>
#include <arpa/inet.h>
#include <sys/socket.h>
#include <sys/time.h>

#define FPGA_IP "192.168.1.128"
#define FPGA_PORT 1234
#define LOCAL_PORT 9999
#define PAYLOAD_SIZE 1024

// Función para obtener timestamp en microsegundos
uint64_t get_time_us() {
    struct timeval tv;
    gettimeofday(&tv, NULL);
    return (uint64_t)tv.tv_sec * 1000000 + tv.tv_usec;
}

int main(int argc, char *argv[]) {
    if (argc != 2) {
        printf("Uso: %s <num_paquetes>\n", argv[0]);
        return 1;
    }
    
    int num_packets = atoi(argv[1]);
    
    // Crear sockets
    int send_sock = socket(AF_INET, SOCK_DGRAM, 0);
    int recv_sock = socket(AF_INET, SOCK_DGRAM, 0);
    
    // Configurar recepción
    struct sockaddr_in local_addr = {0};
    local_addr.sin_family = AF_INET;
    local_addr.sin_addr.s_addr = INADDR_ANY;
    local_addr.sin_port = htons(LOCAL_PORT);
    bind(recv_sock, (struct sockaddr*)&local_addr, sizeof(local_addr));
    
    // Timeout de 1 segundo
    struct timeval tv = {1, 0};
    setsockopt(recv_sock, SOL_SOCKET, SO_RCVTIMEO, &tv, sizeof(tv));
    
    // Dirección FPGA
    struct sockaddr_in fpga_addr = {0};
    fpga_addr.sin_family = AF_INET;
    fpga_addr.sin_port = htons(FPGA_PORT);
    inet_pton(AF_INET, FPGA_IP, &fpga_addr.sin_addr);
    
    // Buffer
    uint8_t buffer[PAYLOAD_SIZE];
    memset(buffer, 0xAA, PAYLOAD_SIZE);  // Patrón simple
    
    printf("Midiendo latencia...\n");
    printf("Seq | Latencia (us)\n");
    printf("----|--------------\n");
    
    uint64_t total_latency = 0;
    int received = 0;
    
    for (int seq = 0; seq < num_packets; seq++) {
        // Marcar secuencia
        *(uint32_t*)buffer = seq;
        
        // Enviar y medir
        uint64_t start = get_time_us();
        sendto(send_sock, buffer, PAYLOAD_SIZE, 0, 
              (struct sockaddr*)&fpga_addr, sizeof(fpga_addr));
        
        // Recibir
        if (recv(recv_sock, buffer, PAYLOAD_SIZE, 0) == PAYLOAD_SIZE) {
            uint64_t end = get_time_us();
            uint64_t latency = end - start;
            
            printf("%3d | %lu\n", seq, latency);
            total_latency += latency;
            received++;
        } else {
            printf("%3d | TIMEOUT\n", seq);
        }
        
        usleep(10000);  // 10ms entre paquetes
    }
    
    // Resultados
    printf("\nResumen:\n");
    printf("Paquetes enviados: %d\n", num_packets);
    printf("Paquetes recibidos: %d\n", received);
    printf("Latencia promedio: %.2f us\n", 
           received > 0 ? (double)total_latency / received : 0);
    
    close(send_sock);
    close(recv_sock);
    
    return 0;
}