#include "blake3.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <errno.h>
#include <pthread.h>

#define CHUNK_SIZE 65536

typedef struct {
    const char *filename;
} file_arg_t;

void *hash_file_thread(void *arg) {
    const char *filename = ((file_arg_t *)arg)->filename;

    int fd = open(filename, O_RDONLY);
    if (fd < 0) {
        perror("Failed to open file");
        return NULL;
    }

    struct stat st;
    if (fstat(fd, &st) < 0) {
        perror("Failed to get file size");
        close(fd);
        return NULL;
    }

    size_t file_size = st.st_size;
    if (file_size == 0) {
        fprintf(stderr, "Empty file: %s\n", filename);
        close(fd);
        return NULL;
    }

    blake3_hasher hasher;
    blake3_hasher_init(&hasher);

    uint8_t buffer[CHUNK_SIZE];
    ssize_t bytes_read;

    while ((bytes_read = read(fd, buffer, CHUNK_SIZE)) > 0) {
        blake3_hasher_update(&hasher, buffer, bytes_read);
    }

    if (bytes_read < 0) {
        perror("Error reading file");
        close(fd);
        return NULL;
    }

    close(fd);

    uint8_t output[BLAKE3_OUT_LEN];
    blake3_hasher_finalize(&hasher, output, BLAKE3_OUT_LEN);

    for (size_t i = 0; i < BLAKE3_OUT_LEN; i++) {
        printf("%02x", output[i]);
    }
    printf("  %s\n", filename);

    return NULL;
}

void process_files_concurrently(int argc, char **argv) {
    int num_cpus = sysconf(_SC_NPROCESSORS_ONLN);
    pthread_t *threads = malloc(sizeof(pthread_t) * num_cpus);
    file_arg_t *file_args = malloc(sizeof(file_arg_t) * num_cpus);
    int thread_count = 0;

    for (int i = 1; i < argc; i++) {
        file_args[thread_count].filename = argv[i];
        pthread_create(&threads[thread_count], NULL, hash_file_thread, &file_args[thread_count]);

        thread_count++;

        if (thread_count == num_cpus || i == argc - 1) {
            for (int t = 0; t < thread_count; t++) {
                pthread_join(threads[t], NULL);
            }
            thread_count = 0;
        }
    }

    free(threads);
    free(file_args);
}

int main(int argc, char **argv) {
    if (argc < 2) {
        fprintf(stderr, "Usage: %s <file1> <file2> ...\n", argv[0]);
        return 1;
    }

    process_files_concurrently(argc, argv);
    return 0;
}
