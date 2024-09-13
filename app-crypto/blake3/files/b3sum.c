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
#include <ctype.h>

#define CHUNK_SIZE 65536
#define BLAKE3_OUT_LEN 32

pthread_mutex_t output_mutex = PTHREAD_MUTEX_INITIALIZER;

typedef struct {
  const char *filename;
  int check;
  int tag;
  int zero;
  int ignore_missing;
  int quiet;
  int status;
  int strict;
  int warn;
} file_arg_t;

static void print_help(void) {
  printf("Usage: b3sum [OPTION]... [FILE]...\n");
  printf("Print or check BLAKE3 (256-bit) checksums.\n\n");
  printf("With no FILE, or when FILE is -, read standard input.\n");
  printf("  -c, --check           read checksums from the FILES and check them\n");
  printf("      --tag             create a BSD-style checksum\n");
  printf("  -z, --zero            end each output line with NUL, not newline,\n");
  printf("                        and disable file name escaping\n\n");
  printf("The following options are useful only when verifying checksums:\n");
  printf("      --ignore-missing  don't fail or report status for missing files\n");
  printf("      --quiet           don't print OK for each successfully verified file\n");
  printf("      --status          don't output anything, status code shows success\n");
  printf("      --strict          exit non-zero for improperly formatted checksum lines\n");
  printf("  -w, --warn            warn about improperly formatted checksum lines\n\n");
  printf("      --help            display this help and exit\n");
  printf("      --version         output version information and exit\n\n");
  printf("The sums are computed using the BLAKE3 hash function, which is a cryptographic hash function\n");
  printf("designed to be fast, secure, and efficient. BLAKE3 outputs a 256-bit hash value.\n");
}

static void print_version(void) {
  printf("b3sum version 1.0\n");
}

static void *hash_file_thread(void *arg) {
  file_arg_t *file_arg = (file_arg_t *)arg;
  const char *filename = file_arg->filename;

  int fd = open(filename, O_RDONLY);
  if (fd < 0) {
    perror("open");
    return NULL;
  }

  struct stat st;
  if (fstat(fd, &st) < 0) {
    perror("fstat");
    close(fd);
    return NULL;
  }

  size_t file_size = st.st_size;
  if (file_size == 0) {
    fprintf(stderr, "empty file: %s\n", filename);
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
    perror("read");
    close(fd);
    return NULL;
  }

  close(fd);

  uint8_t output[BLAKE3_OUT_LEN];
  blake3_hasher_finalize(&hasher, output, BLAKE3_OUT_LEN);

  pthread_mutex_lock(&output_mutex);

  if (file_arg->tag) {
    printf("BLAKE3 ");
  }

  for (size_t i = 0; i < BLAKE3_OUT_LEN; i++) {
    printf("%02x", output[i]);
  }

  if (file_arg->zero) {
    printf("\0");
  } else {
    printf("  %s\n", filename);
  }

  pthread_mutex_unlock(&output_mutex);

  return NULL;
}

static void process_files_concurrently(int argc, char **argv, file_arg_t *file_args) {
  int num_cpus = sysconf(_SC_NPROCESSORS_ONLN);
  pthread_t *threads = malloc(sizeof(pthread_t) * num_cpus);
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
}

int main(int argc, char **argv) {
  file_arg_t *file_args;
  int check = 0;
  int tag = 0;
  int zero = 0;
  int ignore_missing = 0;
  int quiet = 0;
  int status = 0;
  int strict = 0;
  int warn = 0;

  if (argc < 2) {
    print_help();
    return EXIT_FAILURE;
  }

  for (int i = 1; i < argc; i++) {
    if (strcmp(argv[i], "--check") == 0) {
      check = 1;
    } else if (strcmp(argv[i], "--tag") == 0) {
      tag = 1;
    } else if (strcmp(argv[i], "-z") == 0 || strcmp(argv[i], "--zero") == 0) {
      zero = 1;
    } else if (strcmp(argv[i], "--ignore-missing") == 0) {
      ignore_missing = 1;
    } else if (strcmp(argv[i], "--quiet") == 0) {
      quiet = 1;
    } else if (strcmp(argv[i], "--status") == 0) {
      status = 1;
    } else if (strcmp(argv[i], "--strict") == 0) {
      strict = 1;
    } else if (strcmp(argv[i], "-w") == 0 || strcmp(argv[i], "--warn") == 0) {
      warn = 1;
    } else if (strcmp(argv[i], "--help") == 0) {
      print_help();
      return EXIT_SUCCESS;
    } else if (strcmp(argv[i], "--version") == 0) {
      print_version();
      return EXIT_SUCCESS;
    }
  }

  file_args = malloc(sizeof(file_arg_t) * (argc - 1));
  for (int i = 0; i < argc - 1; i++) {
    file_args[i].check = check;
    file_args[i].tag = tag;
    file_args[i].zero = zero;
    file_args[i].ignore_missing = ignore_missing;
    file_args[i].quiet = quiet;
    file_args[i].status = status;
    file_args[i].strict = strict;
    file_args[i].warn = warn;
  }

  process_files_concurrently(argc, argv, file_args);

  free(file_args);
  pthread_mutex_destroy(&output_mutex);

  return EXIT_SUCCESS;
}
