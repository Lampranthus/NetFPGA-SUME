// udp_counter.c - Versión precisa con microsegundos
// Compilar: gcc -o udp_counter udp_counter.c
// Ejecutar: ./udp_counter

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <signal.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <sys/time.h>
#include <fcntl.h>

int running = 1;

void handle_ctrl_c(int sig) {
    running = 0;
    printf("\nDeteniendo...\n");
}

int main() {
    signal(SIGINT, handle_ctrl_c);
    
    int sock = socket(AF_INET, SOCK_DGRAM, 0);
    if (sock < 0) {
        printf("Error creando socket\n");
        return 1;
    }
    
    struct sockaddr_in addr;
    memset(&addr, 0, sizeof(addr));
    addr.sin_family = AF_INET;
    addr.sin_port = htons(9999);
    addr.sin_addr.s_addr = INADDR_ANY;
    
    if (bind(sock, (struct sockaddr*)&addr, sizeof(addr)) < 0) {
        printf("Error vinculando socket\n");
        close(sock);
        return 1;
    }
    
    printf("Escuchando en puerto 9999...\n");
    printf("Presiona Ctrl+C para detener\n\n");
    
    int packet_count = 0;
    int byte_count = 0;
    char buffer[65535];
    
    // Variables para medición por segundo
    struct timeval last_time, current_time;
    gettimeofday(&last_time, NULL);
    
    int packets_in_period = 0;
    int bytes_in_period = 0;
    
    // Hacer socket no bloqueante
    int flags = fcntl(sock, F_GETFL, 0);
    fcntl(sock, F_SETFL, flags | O_NONBLOCK);
    
    while (running) {
        // Recibir todos los paquetes disponibles
        while (1) {
            int bytes = recv(sock, buffer, sizeof(buffer), 0);
            
            if (bytes > 0) {
                packet_count++;
                byte_count += bytes;
                packets_in_period++;
                bytes_in_period += bytes;
            } else {
                break; // No hay más paquetes
            }
        }
        
        // Verificar si pasó 1 segundo
        gettimeofday(&current_time, NULL);
        double elapsed = (current_time.tv_sec - last_time.tv_sec) + 
                        (current_time.tv_usec - last_time.tv_usec) / 1000000.0;
        
        if (elapsed >= 2.0) {
            double mbps = (bytes_in_period * 8.0) / elapsed / 1000000.0;
            
            printf("%.1fs: %d paquetes, %d bytes, %.1f Kbps\n", 
                   elapsed, 
                   packets_in_period, 
                   bytes_in_period,
                   mbps * 1000.0);
            
            // Resetear para el próximo período
            last_time = current_time;
            packets_in_period = 0;
            bytes_in_period = 0;
        }
        
        // Pequeña pausa
        usleep(1000); // 1 ms
    }
    
    printf("\n=== TOTAL ===\n");
    printf("Paquetes totales: %d\n", packet_count);
    printf("Bytes totales: %d\n", byte_count);
    printf("Tamaño promedio: %.1f bytes/paquete\n", 
           packet_count > 0 ? (float)byte_count / packet_count : 0);
    
    close(sock);
    return 0;
}