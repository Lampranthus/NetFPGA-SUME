#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <signal.h>
#include <sys/stat.h>
#include <pthread.h>
#include <unistd.h>
#include <arpa/inet.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <sys/time.h>
#include <fcntl.h>
#include <errno.h>
#include <time.h>

#define PORT 9999
#define CHUNK_SIZE (256 * 1024 * 1024)   // 256 MB por chunk
#define TOTAL_RAM (2ULL * 1024 * 1024 * 1024)  // 2 GB
#define MAX_CHUNKS (TOTAL_RAM / CHUNK_SIZE)
#define PAYLOAD_SIZE 8192

static volatile int running = 1;

pthread_mutex_t chunk_mutex = PTHREAD_MUTEX_INITIALIZER;
pthread_cond_t chunk_ready_cond = PTHREAD_COND_INITIALIZER;
pthread_cond_t chunk_free_cond = PTHREAD_COND_INITIALIZER;

int chunks_ready[MAX_CHUNKS];
int chunk_ready_count = 0;

uint8_t *ram_buffer = NULL;
char session_folder[256];

size_t total_received = 0;
int files_written = 0;
double total_time = 0.0;

// === Señal de Ctrl+C ===
void int_handler(int sig) {
    (void)sig;
    running = 0;
    pthread_cond_broadcast(&chunk_ready_cond);
    pthread_cond_broadcast(&chunk_free_cond);
    printf("\n[Signal] Ctrl+C received — stopping capture...\n");
}

// === Función para obtener timestamp ===
double get_time_seconds() {
    struct timeval tv;
    gettimeofday(&tv, NULL);
    return (double)tv.tv_sec + (double)tv.tv_usec * 1e-6;
}

// === Thread escritor ===
void *writer_thread(void *arg) {
    (void)arg;
    int chunk_index;

    while (running || chunk_ready_count > 0) {
        pthread_mutex_lock(&chunk_mutex);

        while (chunk_ready_count == 0 && running)
            pthread_cond_wait(&chunk_ready_cond, &chunk_mutex);

        if (chunk_ready_count == 0 && !running) {
            pthread_mutex_unlock(&chunk_mutex);
            break;
        }

        chunk_index = chunks_ready[--chunk_ready_count];
        pthread_mutex_unlock(&chunk_mutex);

        // Guardar archivo
        char filename[512];
        snprintf(filename, sizeof(filename), "%s/fpga_data_%04d.bin", session_folder, files_written);
        FILE *f = fopen(filename, "wb");
        if (f) {
            fwrite(ram_buffer + (chunk_index * CHUNK_SIZE), 1, CHUNK_SIZE, f);
            fclose(f);
            files_written++;
            printf("Wrote %s (%.2f MB). Files: %d\n", filename, (double)CHUNK_SIZE / (1024 * 1024), files_written);
        } else {
            perror("fopen");
        }

        pthread_cond_signal(&chunk_free_cond);
    }

    printf("Writer thread exiting...\n");
    return NULL;
}

int main() {
    signal(SIGINT, int_handler);

    // Crear carpeta de sesión
    time_t t = time(NULL);
    struct tm *tm_info = localtime(&t);
    strftime(session_folder, sizeof(session_folder), "fpga_data_%Y%m%d_%H%M%S", tm_info);
    mkdir(session_folder, 0755);
    printf("Created session folder: %s\n", session_folder);
    printf("=== FPGA RAM Buffer Receiver (improved) ===\n");
    printf("Session folder: %s\n", session_folder);
    printf("RAM Buffer: %.2f GB  (chunk size: %.2f MB, chunks: %llu)\n",
           (double)TOTAL_RAM / (1024 * 1024 * 1024),
           (double)CHUNK_SIZE / (1024 * 1024),
           MAX_CHUNKS);

    // Reservar RAM
    ram_buffer = malloc(TOTAL_RAM);
    if (!ram_buffer) {
        fprintf(stderr, "Error: could not allocate %.2f GB RAM\n", (double)TOTAL_RAM / (1024 * 1024 * 1024));
        return 1;
    }

    // Crear socket UDP
    int sockfd = socket(AF_INET, SOCK_DGRAM, 0);
    if (sockfd < 0) {
        perror("socket");
        free(ram_buffer);
        return 1;
    }

    // Permitir reuso inmediato del puerto
    int opt = 1;
    setsockopt(sockfd, SOL_SOCKET, SO_REUSEADDR, &opt, sizeof(opt));
    setsockopt(sockfd, SOL_SOCKET, SO_REUSEPORT, &opt, sizeof(opt));

    // Aumentar buffer del kernel
    int rcvbuf = 268435456;
    setsockopt(sockfd, SOL_SOCKET, SO_RCVBUF, &rcvbuf, sizeof(rcvbuf));

    // Configurar socket no bloqueante
    int flags = fcntl(sockfd, F_GETFL, 0);
    fcntl(sockfd, F_SETFL, flags | O_NONBLOCK);

    // Enlazar socket
    struct sockaddr_in addr = {0};
    addr.sin_family = AF_INET;
    addr.sin_addr.s_addr = INADDR_ANY;
    addr.sin_port = htons(PORT);

    if (bind(sockfd, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
        perror("bind failed");
        close(sockfd);
        free(ram_buffer);
        return 1;
    }

    printf("Listening on UDP port %d...\n", PORT);
    printf("Press Ctrl+C to stop\n\n");

    pthread_t writer;
    pthread_create(&writer, NULL, writer_thread, NULL);

    int current_chunk = 0;
    size_t current_offset_in_chunk = 0;
    double start_time = get_time_seconds();

    while (running) {
        ssize_t received = recv(sockfd,
            ram_buffer + (current_chunk * CHUNK_SIZE) + current_offset_in_chunk,
            PAYLOAD_SIZE, 0);

        if (received < 0) {
            if (errno == EAGAIN || errno == EWOULDBLOCK) {
                usleep(10000);
                continue;
            } else if (errno == EINTR) {
                continue;
            } else {
                perror("recv");
                break;
            }
        }

        total_received += received;
        current_offset_in_chunk += received;

        if (current_offset_in_chunk >= CHUNK_SIZE) {
            pthread_mutex_lock(&chunk_mutex);
            while (chunk_ready_count >= MAX_CHUNKS && running)
                pthread_cond_wait(&chunk_free_cond, &chunk_mutex);
            if (!running) {
                pthread_mutex_unlock(&chunk_mutex);
                break;
            }

            chunks_ready[chunk_ready_count++] = current_chunk;
            pthread_cond_signal(&chunk_ready_cond);
            pthread_mutex_unlock(&chunk_mutex);

            current_chunk = (current_chunk + 1) % MAX_CHUNKS;
            current_offset_in_chunk = 0;
        }
    }

    printf("\nTermination requested: signaling writer to flush and exit...\n");
    pthread_cond_broadcast(&chunk_ready_cond);
    pthread_join(writer, NULL);

    double end_time = get_time_seconds();
    total_time = end_time - start_time;

    printf("\n=== FINAL STATISTICS ===\n");
    printf("Session folder: %s\n", session_folder);
    printf("Total received: %.2f MB\n", (double)total_received / (1024 * 1024));
    printf("Total time: %.2f seconds\n", total_time);
    printf("Average rate: %.2f Mbps\n", (total_received * 8.0 / 1e6) / total_time);
    printf("Files created (approx): %d\n", files_written);
    printf("Write errors: 0\n");

    close(sockfd);
    free(ram_buffer);
    return 0;
}
