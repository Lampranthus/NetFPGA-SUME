#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <time.h>
#include <fcntl.h>
#include <sys/stat.h>
#include <signal.h>
#include <sys/types.h>
#include <errno.h>

// Configuración
#define RAM_BUFFER_SIZE (2ULL * 1024 * 1024 * 1024)  // 2GB buffer
#define WRITE_CHUNK_SIZE (256 * 1024 * 1024)         // 256MB por escritura
#define PAYLOAD_SIZE 8192

volatile sig_atomic_t running = 1;

void int_handler(int sig) {
    running = 0;
    printf("\nReceived interrupt signal, flushing data...\n");
}

// Crear directorio con timestamp
void create_session_folder(char* folder_path, size_t size) {
    time_t now = time(NULL);
    struct tm *t = localtime(&now);
    snprintf(folder_path, size, "fpga_data_%04d%02d%02d_%02d%02d%02d",
             t->tm_year + 1900, t->tm_mon + 1, t->tm_mday,
             t->tm_hour, t->tm_min, t->tm_sec);
    
    if (mkdir(folder_path, 0755) == 0) {
        printf("Created session folder: %s\n", folder_path);
    } else {
        printf("Warning: Could not create folder %s: %s\n", folder_path, strerror(errno));
        strcpy(folder_path, ".");  // Usar directorio actual
    }
}

int main() {
    signal(SIGINT, int_handler);
    signal(SIGTERM, int_handler);
    
    char session_folder[128];
    create_session_folder(session_folder, sizeof(session_folder));
    
    size_t actual_buffer_size = RAM_BUFFER_SIZE;
    
    printf("=== FPGA RAM Buffer Receiver ===\n");
    printf("Session folder: %s\n", session_folder);
    printf("RAM Buffer: %.2f GB\n", (double)actual_buffer_size / (1024*1024*1024));
    
    // Reservar buffer en RAM
    char *ram_buffer = malloc(actual_buffer_size);
    if (!ram_buffer) {
        printf("ERROR: Cannot allocate RAM. Trying 1GB...\n");
        actual_buffer_size = 1ULL * 1024 * 1024 * 1024;
        ram_buffer = malloc(actual_buffer_size);
        if (!ram_buffer) {
            printf("ERROR: Cannot allocate 1GB either. Exiting.\n");
            return 1;
        }
    }
    
    int sockfd, filefd;
    struct sockaddr_in servaddr;
    size_t ram_offset = 0, total_received = 0;
    int file_counter = 0;
    int write_errors = 0;
    
    // Socket UDP
    sockfd = socket(AF_INET, SOCK_DGRAM, 0);
    int rcvbuf = 32 * 1024 * 1024;
    setsockopt(sockfd, SOL_SOCKET, SO_RCVBUF, &rcvbuf, sizeof(rcvbuf));
    
    memset(&servaddr, 0, sizeof(servaddr));
    servaddr.sin_family = AF_INET;
    servaddr.sin_addr.s_addr = INADDR_ANY;
    servaddr.sin_port = htons(9999);
    
    if (bind(sockfd, (const struct sockaddr *)&servaddr, sizeof(servaddr)) < 0) {
        perror("bind failed");
        free(ram_buffer);
        return 1;
    }
    
    printf("Listening on UDP port 9999...\n");
    printf("Press Ctrl+C to stop\n\n");
    
    struct timespec start_time, last_stats;
    clock_gettime(CLOCK_MONOTONIC, &start_time);
    last_stats = start_time;
    
    while (running) {
        struct timeval tv;
        fd_set readfds;
        FD_ZERO(&readfds);
        FD_SET(sockfd, &readfds);
        tv.tv_sec = 0;
        tv.tv_usec = 100000;
        
        int ready = select(sockfd + 1, &readfds, NULL, NULL, &tv);
        
        if (ready > 0 && FD_ISSET(sockfd, &readfds)) {
            ssize_t received = recv(sockfd, ram_buffer + ram_offset, PAYLOAD_SIZE, 0);
            
            if (received > 0) {
                ram_offset += received;
                total_received += received;
                
                if (ram_offset >= WRITE_CHUNK_SIZE) {
                    char filename[256];
                    snprintf(filename, sizeof(filename), "%s/fpga_data_%04d.bin", 
                             session_folder, file_counter);
                    
                    filefd = open(filename, O_WRONLY | O_CREAT | O_TRUNC, 0666);
                    if (filefd >= 0) {
                        ssize_t written = 0;
                        size_t to_write = WRITE_CHUNK_SIZE;
                        
                        while (written < to_write) {
                            size_t chunk = (to_write - written) > (16 * 1024 * 1024) ? 
                                         (16 * 1024 * 1024) : (to_write - written);
                            
                            ssize_t result = write(filefd, ram_buffer + written, chunk);
                            if (result > 0) written += result;
                            else { write_errors++; break; }
                        }
                        
                        close(filefd);
                        
                        if (written == to_write) {
                            memmove(ram_buffer, ram_buffer + WRITE_CHUNK_SIZE, ram_offset - WRITE_CHUNK_SIZE);
                            ram_offset -= WRITE_CHUNK_SIZE;
                            file_counter++;
                            
                            struct timespec current_time;
                            clock_gettime(CLOCK_MONOTONIC, &current_time);
                            double elapsed = (current_time.tv_sec - start_time.tv_sec) + 
                                           (current_time.tv_nsec - start_time.tv_nsec) / 1e9;
                            double mbps = (total_received * 8) / elapsed / 1e6;
                            
                            printf("File %04d: %.2f MB, Total: %.2f MB, Rate: %.2f Mbps\n",
                                   file_counter, WRITE_CHUNK_SIZE / (1024.0 * 1024.0),
                                   total_received / (1024.0 * 1024.0), mbps);
                        }
                    } else {
                        printf("Error creating file: %s\n", filename);
                        write_errors++;
                    }
                }
                
                struct timespec current_time;
                clock_gettime(CLOCK_MONOTONIC, &current_time);
                double time_since_stats = (current_time.tv_sec - last_stats.tv_sec) + 
                                        (current_time.tv_nsec - last_stats.tv_nsec) / 1e9;
                
                if (time_since_stats >= 2.0) {
                    double elapsed = (current_time.tv_sec - start_time.tv_sec) + 
                                   (current_time.tv_nsec - start_time.tv_nsec) / 1e9;
                    double mbps = (total_received * 8) / elapsed / 1e6;
                    double ram_usage = (double)ram_offset / actual_buffer_size * 100.0;
                    
                    printf("RAM: %.1f%%, Rate: %.2f Mbps, Total: %.2f MB, Files: %d\n",
                           ram_usage, mbps, total_received / (1024.0 * 1024.0), file_counter);
                    
                    last_stats = current_time;
                }
            }
        }
        
        if (ram_offset > (actual_buffer_size - (100 * 1024 * 1024))) {
            printf("WARNING: RAM buffer almost full (%.1f%%). Forcing write...\n", 
                   (double)ram_offset / actual_buffer_size * 100.0);
            
            char filename[256];
            snprintf(filename, sizeof(filename), "%s/fpga_emergency_%04d.bin", 
                     session_folder, file_counter);
            
            filefd = open(filename, O_WRONLY | O_CREAT | O_TRUNC, 0666);
            if (filefd >= 0) {
                ssize_t written = write(filefd, ram_buffer, ram_offset);
                if (written > 0) {
                    printf("Emergency write: %.2f MB\n", written / (1024.0 * 1024.0));
                }
                close(filefd);
                ram_offset = 0;
                file_counter++;
            }
        }
    }
    
    printf("\nFlushing remaining data...\n");
    if (ram_offset > 0) {
        char filename[256];
        snprintf(filename, sizeof(filename), "%s/fpga_final_%04d.bin", 
                 session_folder, file_counter);
        filefd = open(filename, O_WRONLY | O_CREAT | O_TRUNC, 0666);
        if (filefd >= 0) {
            ssize_t written = write(filefd, ram_buffer, ram_offset);
            if (written > 0) {
                printf("Final flush: %.2f MB to %s\n", written / (1024.0 * 1024.0), filename);
            }
            close(filefd);
        }
    }
    
    struct timespec end_time;
    clock_gettime(CLOCK_MONOTONIC, &end_time);
    double total_elapsed = (end_time.tv_sec - start_time.tv_sec) + 
                         (end_time.tv_nsec - start_time.tv_nsec) / 1e9;
    
    printf("\n=== FINAL STATISTICS ===\n");
    printf("Session folder: %s\n", session_folder);
    printf("Total received: %.2f MB\n", total_received / (1024.0 * 1024.0));
    printf("Total time: %.2f seconds\n", total_elapsed);
    printf("Average rate: %.2f Mbps\n", (total_received * 8) / total_elapsed / 1e6);
    printf("Files created: %d\n", file_counter + (ram_offset > 0 ? 1 : 0));
    printf("Write errors: %d\n", write_errors);
    
    free(ram_buffer);
    close(sockfd);
    
    return 0;
}

/*
gcc -O2 -o fpga_receiver fpga_receiver.c
*/