/*
gcc -O3 -o simple_timestamp_reader simple_timestamp_reader.c
Ejecutar: sudo ./simple_timestamp_reader
*/

#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <arpa/inet.h>
#include <sys/socket.h>
#include <unistd.h>  // <-- AQUÍ FALTA ESTA INCLUSIÓN
#include <time.h>

#define PORT 9999
#define FPGA_IP "192.168.1.100"
#define PAYLOAD_SIZE 256
#define CLOCK_NS 6.4

int main() {
    // Crear socket UDP
    int sock = socket(AF_INET, SOCK_DGRAM, 0);
    if (sock < 0) {
        perror("Error creando socket");
        return 1;
    }
    
    // Configurar dirección
    struct sockaddr_in addr;
    memset(&addr, 0, sizeof(addr));
    addr.sin_family = AF_INET;
    addr.sin_port = htons(PORT);
    
    if (inet_pton(AF_INET, FPGA_IP, &addr.sin_addr) <= 0) {
        perror("Error en dirección IP");
        close(sock);
        return 1;
    }
    
    // Hacer bind al puerto
    if (bind(sock, (struct sockaddr*)&addr, sizeof(addr)) < 0) {
        perror("Error en bind");
        close(sock);
        return 1;
    }
    
    // Buffer para recibir datos
    uint8_t buffer[PAYLOAD_SIZE];
    
    // Variables para tracking
    uint64_t last_start = 0, last_end = 0;
    int packet_num = 0;
    
    printf("=== FPGA Timestamp Reader (Simple) ===\n");
    printf("Escuchando en %s:%d\n", FPGA_IP, PORT);
    printf("Tamaño de paquete: %d bytes\n", PAYLOAD_SIZE);
    printf("Reloj FPGA: %.1f ns por ciclo\n\n", CLOCK_NS);
    
    printf(" # | Start Timestamp | End Timestamp | Intra (ns) | Inter (ns) | Intra (µs) | Inter (µs)\n");
    printf("---|-----------------|---------------|------------|------------|------------|------------\n");
    
    // Bucle principal
    while (1) {
        ssize_t received = recv(sock, buffer, sizeof(buffer), 0);
        
        if (received < 0) {
            perror("Error en recv");
            break;
        }
        
        if (received != PAYLOAD_SIZE) {
            printf("Advertencia: Paquete de tamaño %zd (esperado %d)\n", received, PAYLOAD_SIZE);
            continue;
        }
        
        // Extraer timestamps (asumiendo little-endian)
        uint64_t start = *((uint64_t*)buffer);
        uint64_t end = *((uint64_t*)(buffer + PAYLOAD_SIZE - sizeof(uint64_t)));
        
        // Calcular tiempos
        double intra_ns = (double)(end - start) * CLOCK_NS;
        double inter_ns = 0.0;
        
        if (last_start != 0) {
            inter_ns = (double)(start - last_start) * CLOCK_NS;
        }
        
        // Mostrar resultados
        printf("%3d | %15lu | %15lu | %9.1f | %9.1f | %8.3f | %8.3f\n",
               packet_num++, 
               start, 
               end, 
               intra_ns, 
               inter_ns,
               intra_ns / 1000.0,
               inter_ns / 1000.0);
        
        // Actualizar para próximo cálculo
        last_start = start;
        last_end = end;
        
        // Opcional: Salir después de ciertos paquetes
        if (packet_num >= 1000) {  // Cambia este número según necesites
            printf("\nLímite de paquetes alcanzado (1000)\n");
            break;
        }
    }
    
    // Cerrar socket
    close(sock);
    printf("\nPrograma terminado.\n");
    
    return 0;
}