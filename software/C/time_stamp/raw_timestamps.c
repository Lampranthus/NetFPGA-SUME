/*
gcc -O3 -o raw_timestamps raw_timestamps.c
Uso: sudo ./raw_timestamps <archivo> <paquetes>
Ejemplo: sudo ./raw_timestamps datos.csv 1000
*/

#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <arpa/inet.h>
#include <sys/socket.h>
#include <unistd.h>
#include <signal.h>

#define PORT 9999
#define FPGA_IP "192.168.1.100"
#define PAYLOAD_SIZE 256
#define CLOCK_NS 6.4

volatile sig_atomic_t running = 1;

void handle_signal(int sig) {
    running = 0;
}

int main(int argc, char *argv[]) {
    signal(SIGINT, handle_signal);
    
    if (argc != 3) {
        printf("Uso: %s <archivo> <paquetes>\n", argv[0]);
        return 1;
    }
    
    char *filename = argv[1];
    int max_packets = atoi(argv[2]);
    
    // Configurar socket
    int sock = socket(AF_INET, SOCK_DGRAM, 0);
    struct sockaddr_in addr = {0};
    addr.sin_family = AF_INET;
    addr.sin_port = htons(PORT);
    inet_pton(AF_INET, FPGA_IP, &addr.sin_addr);
    bind(sock, (struct sockaddr*)&addr, sizeof(addr));
    
    // Abrir archivo
    FILE *file = fopen(filename, "w");
    if (!file) {
        perror("Error abriendo archivo");
        close(sock);
        return 1;
    }
    
    // Encabezado mínimo
    fprintf(file, "packet,start,end\n");
    
    uint8_t buffer[PAYLOAD_SIZE];
    uint64_t last_start = 0;
    int packets = 0;
    
    printf("Guardando en %s... ", filename);
    fflush(stdout);
    
    while (running && packets < max_packets) {
        if (recv(sock, buffer, PAYLOAD_SIZE, 0) == PAYLOAD_SIZE) {
            uint64_t start = *((uint64_t*)buffer);
            uint64_t end = *((uint64_t*)(buffer + PAYLOAD_SIZE - 8));
            
            fprintf(file, "%d,%lu,%lu\n", packets, start, end);
            
            packets++;
            last_start = start;
            
            // Mostrar punto cada 100 paquetes
            if (packets % 100 == 0) {
                printf(".");
                fflush(stdout);
                fflush(file);
            }
        }
    }
    
    fclose(file);
    close(sock);
    
    printf("\nGuardados %d paquetes en %s\n", packets, filename);
    return 0;
}