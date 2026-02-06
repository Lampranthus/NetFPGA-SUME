/*
gcc -O3 -o interval_only interval_only.c -lm
Uso: ./interval_only N
*/

#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <math.h>
#include <arpa/inet.h>
#include <sys/socket.h>
#include <time.h>
#include <unistd.h>

#define LOCAL_PORT 9999
#define PAYLOAD_SIZE 8192

int main(int argc, char *argv[]) {

    if (argc != 2) {
        printf("Uso: %s <numero_de_paquetes>\n", argv[0]);
        return 1;
    }

    long N = atol(argv[1]);
    if (N < 2) {
        printf("N debe ser >= 2\n");
        return 1;
    }

    long *intervals = malloc((N - 1) * sizeof(long));
    if (!intervals) {
        perror("malloc");
        return 1;
    }

    int sock = socket(AF_INET, SOCK_DGRAM, 0);

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
    long idx = 0;

    printf("Esperando %ld paquetes UDP...\n", N);

    while (count < N) {

        recv(sock, buffer, PAYLOAD_SIZE, 0);
        count++;

        clock_gettime(CLOCK_MONOTONIC, &current);

        if (last.tv_sec != 0) {
            long interval_ns =
                (current.tv_sec - last.tv_sec) * 1000000000L +
                (current.tv_nsec - last.tv_nsec);

            intervals[idx++] = interval_ns;
        }

        last = current;
    }

    // Estadística
    long min = intervals[0];
    long max = intervals[0];
    double sum = 0.0;

    for (long i = 0; i < idx; i++) {
        if (intervals[i] < min) min = intervals[i];
        if (intervals[i] > max) max = intervals[i];
        sum += intervals[i];
    }

    double mean = sum / idx;

    double variance = 0.0;
    for (long i = 0; i < idx; i++) {
        double diff = intervals[i] - mean;
        variance += diff * diff;
    }
    variance /= idx;

    double stddev = sqrt(variance);

    printf("\n===== ESTADISTICAS =====\n");
    printf("Muestras          : %ld\n", idx);
    printf("Intervalo medio   : %.2f ns\n", mean);
    printf("Desviacion std    : %.2f ns\n", stddev);
    printf("Minimo            : %ld ns\n", min);
    printf("Maximo            : %ld ns\n", max);

    free(intervals);
    close(sock);
    return 0;
}
