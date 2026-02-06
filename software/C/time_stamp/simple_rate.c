/*
gcc -O3 -o interval_only interval_only.c
Uso: ./interval_only
*/

#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include <arpa/inet.h>
#include <sys/socket.h>
#include <time.h>
#include <unistd.h>

#define LOCAL_PORT 9999
#define PAYLOAD_SIZE 8192

int main() {
    int sock = socket(AF_INET, SOCK_DGRAM, 0);
    
    // Configuración para baja latencia
    int opt = 1;
    setsockopt(sock, SOL_SOCKET, SO_REUSEADDR, &opt, sizeof(opt));
    
    struct sockaddr_in addr = {0};
    addr.sin_family = AF_INET;
    addr.sin_addr.s_addr = INADDR_ANY;
    addr.sin_port = htons(LOCAL_PORT);
    
    bind(sock, (struct sockaddr*)&addr, sizeof(addr));
    
    uint8_t buffer[PAYLOAD_SIZE];
    struct timespec last = {0}, current;
    long count = 0;
    
    printf("Medición de intervalos entre paquetes UDP\n");
    printf("Formato: <número_paquete> <intervalo_ns>\n\n");
    
    while (1) {
        recv(sock, buffer, PAYLOAD_SIZE, 0);
        count++;
        
        clock_gettime(CLOCK_MONOTONIC, &current);
        
        if (last.tv_sec != 0) {
            long interval_ns = (current.tv_sec - last.tv_sec) * 1000000000L + 
                              (current.tv_nsec - last.tv_nsec);
            
            printf("%ld %ld\n", count, interval_ns);
        }
        
        last = current;
    }
    
    close(sock);
    return 0;
}