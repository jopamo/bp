#include "blake3.h"

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <fcntl.h>
#include <unistd.h>
#include <errno.h>
#include <pthread.h>
#include <sys/stat.h>
#include <getopt.h>

#define BLAKE3_OUT_LEN 32
#define CHUNK_SIZE (BLAKE3_OUT_LEN * 1024)

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

static void print_file_error(const char *filename) {
  fprintf(stderr, "b3sum: %s: No such file or directory\n", filename);
}

static int is_directory(const char *path) {
  struct stat path_stat;
  if (stat(path, &path_stat) != 0) {
    return 0;
  }
  return S_ISDIR(path_stat.st_mode);
}

static void *hash_file_thread(void *arg) {
  file_arg_t *file_arg = (file_arg_t *)arg;
  const char *filename = file_arg->filename;

  if (is_directory(filename)) {
    fprintf(stderr, "b3sum: %s: Is a directory\n", filename);
    return NULL;
  }

  int fd;
  if (strcmp(filename, "-") == 0) {
    fd = STDIN_FILENO;
  } else {
    fd = open(filename, O_RDONLY);
    if (fd < 0) {
      if (!file_arg->ignore_missing) {
        print_file_error(filename);
      }
      return NULL;
    }
  }

  blake3_hasher hasher;
  blake3_hasher_init(&hasher);

  uint8_t buffer[CHUNK_SIZE];
  ssize_t bytes_read;

  while ((bytes_read = read(fd, buffer, CHUNK_SIZE)) > 0) {
    blake3_hasher_update(&hasher, buffer, bytes_read);
  }

  if (bytes_read < 0 && fd != STDIN_FILENO) {
    perror("read");
    close(fd);
    return NULL;
  }

  if (fd != STDIN_FILENO) {
    close(fd);
  }

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
    printf("  %s\n", strcmp(filename, "-") == 0 ? "-" : filename);
  }

  pthread_mutex_unlock(&output_mutex);

  return NULL;
}

static void process_files_concurrently(int file_count, char **files, file_arg_t *file_args) {
  int num_cpus = sysconf(_SC_NPROCESSORS_ONLN);
  pthread_t *threads = malloc(sizeof(pthread_t) * num_cpus);
  if (threads == NULL) {
    perror("malloc");
    exit(EXIT_FAILURE);
  }

  int thread_count = 0;

  for (int i = 0; i < file_count; i++) {
    file_args[thread_count].filename = files[i];
    if (pthread_create(&threads[thread_count], NULL, hash_file_thread, &file_args[thread_count]) != 0) {
      perror("pthread_create");
      exit(EXIT_FAILURE);
    }

    thread_count++;

    if (thread_count == num_cpus || i == file_count - 1) {
      for (int t = 0; t < thread_count; t++) {
        pthread_join(threads[t], NULL);
      }
      thread_count = 0;
    }
  }

  free(threads);
}

static void process_files(int file_count, char **files, int check) {
  file_arg_t *file_args = malloc(sizeof(file_arg_t) * file_count);
  if (file_args == NULL) {
    perror("malloc");
    exit(EXIT_FAILURE);
  }

  for (int i = 0; i < file_count; i++) {
    file_args[i].filename = files[i];
    file_args[i].check = check;
    file_args[i].tag = 0;
    file_args[i].zero = 0;
    file_args[i].ignore_missing = 0;
    file_args[i].quiet = 0;
    file_args[i].status = 0;
    file_args[i].strict = 0;
    file_args[i].warn = 0;
  }

  process_files_concurrently(file_count, files, file_args);

  free(file_args);
}

static void process_stdin(int check) {
  char *stdin_file = "-";
  file_arg_t *file_args = malloc(sizeof(file_arg_t));
  if (file_args == NULL) {
    perror("malloc");
    exit(EXIT_FAILURE);
  }

  file_args[0].filename = stdin_file;
  file_args[0].check = check;
  file_args[0].tag = 0;
  file_args[0].zero = 0;
  file_args[0].ignore_missing = 0;
  file_args[0].quiet = 0;
  file_args[0].status = 0;
  file_args[0].strict = 0;
  file_args[0].warn = 0;

  process_files_concurrently(1, &stdin_file, file_args);
  free(file_args);
}

static int handle_options(int argc, char **argv, int *check) {
  int opt;
  static struct option long_options[] = {
    {"check", no_argument, NULL, 'c'},
    {"tag", no_argument, NULL, 't'},
    {"zero", no_argument, NULL, 'z'},
    {"ignore-missing", no_argument, NULL, 'i'},
    {"quiet", no_argument, NULL, 'q'},
    {"status", no_argument, NULL, 's'},
    {"strict", no_argument, NULL, 'S'},
    {"warn", no_argument, NULL, 'w'},
    {"help", no_argument, NULL, 'h'},
    {"version", no_argument, NULL, 'v'},
    {0, 0, 0, 0}
  };

  int long_index = 0;
  while ((opt = getopt_long(argc, argv, "ctzwiqSswhv", long_options, &long_index)) != -1) {
    switch (opt) {
      case 'c':
        *check = 1;
        break;
      case 't':
        break;
      case 'z':
        break;
      case 'i':
        break;
      case 'q':
        break;
      case 's':
        break;
      case 'S':
        break;
      case 'w':
        break;
      case 'h':
        print_help();
        return 0;
      case 'v':
        print_version();
        return 0;
      case '?':
        fprintf(stderr, "b3sum: unrecognized option '%s'\n", argv[optind - 1]);
        fprintf(stderr, "Try 'b3sum --help' for more information.\n");
        return -1;
      default:
        fprintf(stderr, "Invalid option\n");
        print_help();
        return -1;
    }
  }
  return optind;
}

int main(int argc, char **argv) {
  int check = 0;
  int optind = handle_options(argc, argv, &check);
  if (optind == -1) {
    return EXIT_FAILURE;
  } else if (optind == 0) {
    return EXIT_SUCCESS;
  }

  int file_count = argc - optind;
  if (file_count == 0) {
    process_stdin(check);
  } else {
    process_files(file_count, argv + optind, check);
  }

  return EXIT_SUCCESS;
}
