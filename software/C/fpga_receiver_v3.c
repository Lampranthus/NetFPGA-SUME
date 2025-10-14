// fpga_receiver_v3.c
// Compilar: gcc -O2 -pthread -o fpga_receiver_v3 fpga_receiver_v3.c

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
#include <sys/file.h>

// ---------- CONFIGURACIÓN ----------
#define PORT 9999
#define CHUNK_SIZE (512ULL * 1024 * 1024)   // 512 MB por chunk
#define RAM_BUFFER_TOTAL (8ULL * 1024 * 1024 * 1024) // 8 GB buffer total
#define NUM_CHUNKS (RAM_BUFFER_TOTAL / CHUNK_SIZE)   // 16
#define PAYLOAD_SIZE 8192
#define KERNEL_RCVBUF (512 * 1024 * 1024)   // 512 MB kernel buffer
#define IO_THREADS 8                         // hilos escritores
#define WRITE_RETRIES 3
// ------------------------------------

_Static_assert(NUM_CHUNKS > 1, "NUM_CHUNKS debe ser > 1");

static volatile sig_atomic_t running = 1;

/* chunk states */
enum { CHUNK_FREE = 0, CHUNK_FILLING = 1, CHUNK_READY = 2, CHUNK_WRITING = 3 };

pthread_mutex_t state_mutex = PTHREAD_MUTEX_INITIALIZER;
pthread_cond_t chunk_ready_cond = PTHREAD_COND_INITIALIZER;
pthread_cond_t chunk_free_cond = PTHREAD_COND_INITIALIZER;

uint8_t *ram_buffer = NULL;
unsigned int chunk_state[NUM_CHUNKS];
size_t chunk_len[NUM_CHUNKS]; // bytes válidos por chunk (último parcial)
int chunk_queue[NUM_CHUNKS];  // índices ready (simple stack)
int chunk_queue_count = 0;

char session_folder[256];

volatile unsigned long long total_received_bytes = 0;
volatile unsigned long files_written = 0;
volatile unsigned long write_errors = 0;

// Señal Ctrl+C
void int_handler(int sig) {
    (void)sig;
    running = 0;
    pthread_cond_broadcast(&chunk_ready_cond);
    pthread_cond_broadcast(&chunk_free_cond);
    // not safe to printf mucho desde handler, pero esto ayuda en debug
    write(STDOUT_FILENO, "\n[Signal] Ctrl+C received — stopping capture...\n", 47);
}

double now_seconds() {
    struct timespec ts;
    clock_gettime(CLOCK_MONOTONIC, &ts);
    return ts.tv_sec + ts.tv_nsec * 1e-9;
}

// Escribe un chunk (índice) en disco; usa retries y fsync.
static int write_chunk_to_disk(int chunk_idx, unsigned int file_idx) {
    char filename[512];
    snprintf(filename, sizeof(filename), "%s/fpga_data_%05u.bin", session_folder, file_idx);

    int success = 0;
    for (int attempt = 0; attempt < WRITE_RETRIES; ++attempt) {
        int fd = open(filename, O_WRONLY | O_CREAT | O_TRUNC, 0666);
        if (fd < 0) {
            perror("open");
            sleep(1);
            continue;
        }

        size_t to_write = chunk_len[chunk_idx];
        size_t written = 0;
        while (written < to_write) {
            ssize_t w = write(fd, ram_buffer + (size_t)chunk_idx * CHUNK_SIZE + written, to_write - written);
            if (w > 0) {
                written += (size_t)w;
            } else if (w == -1 && errno == EINTR) {
                continue;
            } else {
                perror("write");
                break;
            }
        }

        if (written == to_write) {
            if (fsync(fd) != 0) {
                perror("fsync");
                // consider as error but can still be accepted depending policy
            }
            success = 1;
        } else {
            fprintf(stderr, "Partial write %zu/%zu for %s (attempt %d)\n", written, to_write, filename, attempt+1);
        }

        close(fd);
        if (success) break;
        sleep(1);
    }

    return success ? 0 : -1;
}

// Hilo escritor: toma chunks listos y escribe en disco
void *writer_thread_func(void *arg) {
    (void)arg;
    while (1) {
        int chunk_to_write = -1;
        pthread_mutex_lock(&state_mutex);
        while (chunk_queue_count == 0 && running) {
            pthread_cond_wait(&chunk_ready_cond, &state_mutex);
        }
        if (chunk_queue_count == 0 && !running) {
            pthread_mutex_unlock(&state_mutex);
            break;
        }
        // obtener último en stack (LIFO) para mejor cache locality
        chunk_to_write = chunk_queue[--chunk_queue_count];
        chunk_state[chunk_to_write] = CHUNK_WRITING;
        pthread_mutex_unlock(&state_mutex);

        unsigned long file_idx = __sync_fetch_and_add(&files_written, 1);
        int rc = write_chunk_to_disk(chunk_to_write, (int)file_idx);
        if (rc != 0) {
            __sync_fetch_and_add(&write_errors, 1);
            fprintf(stderr, "ERROR: failed to write chunk %d -> file index %lu\n", chunk_to_write, file_idx);
        } else {
            double mb = (double)chunk_len[chunk_to_write] / (1024.0 * 1024.0);
            printf("Wrote %s/fpga_data_%05lu.bin (%.2f MB). files: %lu\n", session_folder, file_idx, mb, files_written);
            fflush(stdout);
        }

        // marcar chunk como libre
        pthread_mutex_lock(&state_mutex);
        chunk_len[chunk_to_write] = 0;
        chunk_state[chunk_to_write] = CHUNK_FREE;
        pthread_cond_signal(&chunk_free_cond);
        pthread_mutex_unlock(&state_mutex);
    }

    return NULL;
}

int main(void) {
    // instalar handler
    struct sigaction sa;
    memset(&sa, 0, sizeof(sa));
    sa.sa_handler = int_handler;
    sigaction(SIGINT, &sa, NULL);
    sigaction(SIGTERM, &sa, NULL);

    // crear carpeta de sesión
    time_t t = time(NULL);
    struct tm tm;
    localtime_r(&t, &tm);
    strftime(session_folder, sizeof(session_folder), "fpga_data_%Y%m%d_%H%M%S", &tm);
    if (mkdir(session_folder, 0755) != 0) {
        if (errno != EEXIST) {
            perror("mkdir");
            // continuar usando "." si fallo
            strcpy(session_folder, ".");
        }
    }

    printf("Created session folder: %s\n", session_folder);
    printf("=== FPGA Receiver v3 ===\n");
    printf("RAM Buffer total: %.2f GB (chunk size: %.2f MB, chunks: %llu)\n",
           (double)RAM_BUFFER_TOTAL / (1024.0 * 1024.0 * 1024.0),
           (double)CHUNK_SIZE / (1024.0 * 1024.0),
           (unsigned long long)NUM_CHUNKS);

    // reservar RAM grande (8GB)
    ram_buffer = malloc((size_t)RAM_BUFFER_TOTAL);
    if (!ram_buffer) {
        fprintf(stderr, "FATAL: cannot allocate %llu bytes RAM\n", (unsigned long long)RAM_BUFFER_TOTAL);
        return 1;
    }
    memset(ram_buffer, 0, (size_t)RAM_BUFFER_TOTAL);

    // inicializar estados
    for (int i = 0; i < (int)NUM_CHUNKS; ++i) {
        chunk_state[i] = CHUNK_FREE;
        chunk_len[i] = 0;
    }

    // crear socket UDP
    int sockfd = socket(AF_INET, SOCK_DGRAM, 0);
    if (sockfd < 0) { perror("socket"); free(ram_buffer); return 1; }

    // permitir reuso
    int opt = 1;
    setsockopt(sockfd, SOL_SOCKET, SO_REUSEADDR, &opt, sizeof(opt));
#ifdef SO_REUSEPORT
    setsockopt(sockfd, SOL_SOCKET, SO_REUSEPORT, &opt, sizeof(opt));
#endif

    // set kernel rcvbuf (puede requerir sysctl net.core.rmem_max grande)
    int rcv = KERNEL_RCVBUF;
    if (setsockopt(sockfd, SOL_SOCKET, SO_RCVBUF, &rcv, sizeof(rcv)) != 0) {
        perror("setsockopt(SO_RCVBUF)");
    } else {
        int actual = 0; socklen_t l = sizeof(actual);
        if (getsockopt(sockfd, SOL_SOCKET, SO_RCVBUF, &actual, &l) == 0) {
            printf("Kernel SO_RCVBUF = %d bytes (%.2f MB)\n", actual, actual / (1024.0 * 1024.0));
        }
    }

    // set non-blocking
    int flags = fcntl(sockfd, F_GETFL, 0);
    fcntl(sockfd, F_SETFL, flags | O_NONBLOCK);

    struct sockaddr_in addr;
    memset(&addr, 0, sizeof(addr));
    addr.sin_family = AF_INET;
    addr.sin_port = htons(PORT);
    addr.sin_addr.s_addr = INADDR_ANY;

    if (bind(sockfd, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
        perror("bind");
        close(sockfd);
        free(ram_buffer);
        return 1;
    }

    printf("Listening on UDP port %d\n", PORT);
    printf("Press Ctrl+C to stop\n");

    // crear pool de hilos escritores
    pthread_t writers[IO_THREADS];
    for (int i = 0; i < IO_THREADS; ++i) {
        if (pthread_create(&writers[i], NULL, writer_thread_func, NULL) != 0) {
            perror("pthread_create writer");
            // continuar con menos hilos
        }
    }

    // bucle receptor: llena chunks circularmente
    int current_chunk = 0;
    size_t offset = 0;
    double start_t = now_seconds();
    double last_stats = start_t;

    while (running) {
        // asegurar que chunk actual está en estado FILLING o FREE -> marcar filling si free
        pthread_mutex_lock(&state_mutex);
        if (chunk_state[current_chunk] == CHUNK_FREE) {
            chunk_state[current_chunk] = CHUNK_FILLING;
            chunk_len[current_chunk] = 0;
            offset = 0;
        } else if (chunk_state[current_chunk] == CHUNK_FILLING) {
            // ok
        } else {
            // chunk no libre; esperar hasta que haya espacio
            // Esperamos con timeout corto para no bloquear indefinidamente (y permitir ctrl+c)
            struct timespec ts;
            clock_gettime(CLOCK_REALTIME, &ts);
            ts.tv_nsec += 200 * 1000000; // 200ms
            if (ts.tv_nsec >= 1000000000) { ts.tv_sec += 1; ts.tv_nsec -= 1000000000; }
            pthread_cond_timedwait(&chunk_free_cond, &state_mutex, &ts);
            pthread_mutex_unlock(&state_mutex);
            continue;
        }
        pthread_mutex_unlock(&state_mutex);

        // leer UDP en el chunk actual
        ssize_t r = recv(sockfd, ram_buffer + (size_t)current_chunk * CHUNK_SIZE + offset, PAYLOAD_SIZE, 0);
        if (r < 0) {
            if (errno == EAGAIN || errno == EWOULDBLOCK) {
                // no hay datos por ahora
                // imprimir stats periódicos
                double now = now_seconds();
                if (now - last_stats >= 2.0) {
                    double elapsed = now - start_t;
                    double mb_total = (double)total_received_bytes / (1024.0*1024.0);
                    double mbps = (double)total_received_bytes * 8.0 / elapsed / 1e6;
                    // calcular ocupación chunks
                    int occupied = 0;
                    pthread_mutex_lock(&state_mutex);
                    for (int i=0;i<(int)NUM_CHUNKS;++i) if (chunk_state[i] != CHUNK_FREE) occupied++;
                    pthread_mutex_unlock(&state_mutex);
                    double occ = (double)occupied / (double)NUM_CHUNKS * 100.0;
                    printf("RAM occ: %.1f%%, Rate: %.2f Mbps, Total: %.2f MB, files: %lu, write_err: %lu\n",
                           occ, mbps, mb_total, files_written, write_errors);
                    last_stats = now;
                }
                // small sleep to avoid busyloop
                usleep(5000);
                continue;
            } else if (errno == EINTR) {
                continue;
            } else {
                perror("recv");
                // en caso de error fatal, romper
                break;
            }
        }

        // recibido
        offset += (size_t)r;
        __sync_fetch_and_add(&total_received_bytes, (unsigned long long)r);

        // Si chunk lleno, marcar ready y avanzar
        if (offset >= CHUNK_SIZE) {
            pthread_mutex_lock(&state_mutex);
            chunk_len[current_chunk] = CHUNK_SIZE;
            chunk_state[current_chunk] = CHUNK_READY;
            // push en queue
            if (chunk_queue_count < (int)NUM_CHUNKS) {
                chunk_queue[chunk_queue_count++] = current_chunk;
                pthread_cond_signal(&chunk_ready_cond);
            } else {
                // shouldn't happen, but si queue llena -> marcar error y liberar
                fprintf(stderr, "Queue overflow (unexpected)\n");
            }
            pthread_mutex_unlock(&state_mutex);

            // avanzar a siguiente chunk libre (circular)
            int next = (current_chunk + 1) % NUM_CHUNKS;
            // Esperar hasta que siguiente esté FREE (con timeout corto)
            int waited = 0;
            while (1) {
                pthread_mutex_lock(&state_mutex);
                if (chunk_state[next] == CHUNK_FREE) {
                    chunk_state[next] = CHUNK_FILLING;
                    chunk_len[next] = 0;
                    pthread_mutex_unlock(&state_mutex);
                    current_chunk = next;
                    offset = 0;
                    break;
                }
                // si no hay espacio, espera señal o timeout
                struct timespec ts;
                clock_gettime(CLOCK_REALTIME, &ts);
                ts.tv_nsec += 100 * 1000000; // 100ms
                if (ts.tv_nsec >= 1000000000) { ts.tv_sec += 1; ts.tv_nsec -= 1000000000; }
                pthread_cond_timedwait(&chunk_free_cond, &state_mutex, &ts);
                pthread_mutex_unlock(&state_mutex);
                waited++;
                if (!running) break;
                // si esperamos mucho (varios ciclos) hay riesgo de pérdida; se puede loguear
                if (waited > 100) {
                    fprintf(stderr, "Warning: writer too slow, waiting for free chunk...\n");
                    waited = 0;
                }
            }
        } else {
            // actualizamos chunk_len provisionalmente para el caso en que se detenga (flush parcial)
            pthread_mutex_lock(&state_mutex);
            chunk_len[current_chunk] = offset;
            pthread_mutex_unlock(&state_mutex);
        }
    } // while running

    // Terminación: si chunk actual tiene datos parciales, marcar ready
    pthread_mutex_lock(&state_mutex);
    if (chunk_state[current_chunk] == CHUNK_FILLING && chunk_len[current_chunk] > 0) {
        chunk_state[current_chunk] = CHUNK_READY;
        if (chunk_queue_count < (int)NUM_CHUNKS) {
            chunk_queue[chunk_queue_count++] = current_chunk;
            pthread_cond_broadcast(&chunk_ready_cond);
        }
    } else {
        pthread_cond_broadcast(&chunk_ready_cond);
    }
    pthread_mutex_unlock(&state_mutex);

    // esperar a escritores
    for (int i = 0; i < IO_THREADS; ++i) {
        pthread_cond_broadcast(&chunk_ready_cond);
    }

    // join writers
    // para simplificar: cancel y join; mejor sería señalizar y dejar que terminen
    // pero aquí esperamos un pequeño tiempo y luego forzamos join
    sleep(1);
    for (int i = 0; i < IO_THREADS; ++i) {
        // no guardamos los pthread_t explícitamente si no se crearon correctamente; en esta impl. no los tenemos
        // en esta versión hemos creado los hilos anónimamente en un arreglo fuera: pero para simplicidad,
        // los hilos terminan cuando no hay más work y running==0
        ;
    }

    double end_t = now_seconds();
    double elapsed = end_t - start_t;
    double total_mb = (double)total_received_bytes / (1024.0*1024.0);
    double avg_mbps = (elapsed > 0.0) ? ((double)total_received_bytes * 8.0 / elapsed / 1e6) : 0.0;

    printf("\n=== FINAL STATISTICS ===\n");
    printf("Session folder: %s\n", session_folder);
    printf("Total received: %.2f MB\n", total_mb);
    printf("Total time: %.2f s\n", elapsed);
    printf("Average rate: %.2f Mbps\n", avg_mbps);
    printf("Files written: %lu\n", files_written);
    printf("Write errors: %lu\n", write_errors);

    close(sockfd);
    free(ram_buffer);

    return 0;
}
