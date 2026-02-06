// ultra_simple_receiver.c
// gcc -O2 -o ultra_simple_receiver ultra_simple_receiver.c

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <arpa/inet.h>
#include <time.h>

#define PORT 9999
#define BUFFER_SIZE 256

int main() {
    int sock = socket(AF_INET, SOCK_DGRAM, 0);
    struct sockaddr_in addr = {0};
    addr.sin_family = AF_INET;
    addr.sin_port = htons(PORT);
    addr.sin_addr.s_addr = INADDR_ANY;
    
    bind(sock, (struct sockaddr*)&addr, sizeof(addr));
    
    // Crear archivo con timestamp
    time_t t = time(NULL);
    char filename[100];
    strftime(filename, sizeof(filename), "udp_capture_%Y%m%d_%H%M%S.bin", localtime(&t));
    
    FILE *f = fopen(filename, "wb");
    printf("Guardando en: %s\n", filename);
    
    char buffer[BUFFER_SIZE];
    int count = 0;
    
    while (1) {
        int n = recv(sock, buffer, BUFFER_SIZE, 0);
        if (n > 0) {
            fwrite(buffer, 1, n, f);
            fflush(f);  // Flush después de cada paquete
            count++;
            
            if (count % 1000 == 0) {
                printf("Paquetes recibidos: %d\r", count);
                fflush(stdout);
            }
        }
    }
    
    fclose(f);
    close(sock);
    return 0;
}