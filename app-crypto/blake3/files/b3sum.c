#define _POSIX_C_SOURCE 200809L

#include "blake3.h"
#include <ctype.h>
#include <errno.h>
#include <fcntl.h>
#include <getopt.h>
#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>
#include <sys/sysinfo.h>
#include <sys/types.h>
#include <unistd.h>

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
  printf(
      "  -c, --check           read checksums from the FILES and check them\n");
  printf(
      "      --tag             create or check a BSD-style checksum format\n");
  printf(
      "  -z, --zero            end each output line with NUL, not newline\n");
  printf("      --ignore-missing  don't fail or report status for missing "
         "files\n");
  printf("      --quiet           don't print OK for each successfully "
         "verified file\n");
  printf("      --status          don't output anything, status code shows "
         "success\n");
  printf("      --strict          exit non-zero for improperly formatted "
         "checksum lines\n");
  printf("  -w, --warn            warn about improperly formatted checksum "
         "lines\n");
  printf("      --help            display this help and exit\n");
  printf("      --version         output version information and exit\n");
}

static void print_version(void) { printf("b3sum version 1.0\n"); }

static void print_file_error(const char *filename) {
  fprintf(stderr, "b3sum: %s: %s\n", filename, strerror(errno));
}

static int is_directory(const char *path) {
  struct stat path_stat;
  if (stat(path, &path_stat) != 0) {
    return 0;
  }
  return S_ISDIR(path_stat.st_mode);
}

static int hash_file(const char *filename, uint8_t *output,
                     int ignore_missing) {
  if (is_directory(filename)) {
    errno = EISDIR;
    return -1;
  }
  int fd;
  if (strcmp(filename, "-") == 0) {
    fd = STDIN_FILENO;
  } else {
    fd = open(filename, O_RDONLY);
    if (fd < 0) {
      if (ignore_missing && errno == ENOENT) {
        return 1;
      }
      return -1;
    }
  }
  blake3_hasher hasher;
  blake3_hasher_init(&hasher);
  uint8_t buffer[CHUNK_SIZE];
  ssize_t bytes_read;
  while ((bytes_read = read(fd, buffer, CHUNK_SIZE)) > 0) {
    blake3_hasher_update(&hasher, buffer, bytes_read);
  }
  if (bytes_read < 0) {
    int saved_errno = errno;
    if (fd != STDIN_FILENO)
      close(fd);
    errno = saved_errno;
    return -1;
  }
  if (fd != STDIN_FILENO) {
    close(fd);
  }
  blake3_hasher_finalize(&hasher, output, BLAKE3_OUT_LEN);
  return 0;
}

static void print_hash(const uint8_t *hash, const char *filename, int tag,
                       int zero) {
  if (tag) {
    printf("BLAKE3 ");
  }
  for (size_t i = 0; i < BLAKE3_OUT_LEN; i++) {
    printf("%02x", hash[i]);
  }
  if (zero) {
    printf("\0", filename);
  } else {
    printf("  %s\n", strcmp(filename, "-") == 0 ? "-" : filename);
  }
}

static void *hash_file_thread(void *arg) {
  file_arg_t *file_arg = (file_arg_t *)arg;
  uint8_t output[BLAKE3_OUT_LEN];
  int ret = hash_file(file_arg->filename, output, file_arg->ignore_missing);
  pthread_mutex_lock(&output_mutex);
  if (ret == -1 && !file_arg->ignore_missing) {
    print_file_error(file_arg->filename);
  } else if (ret == 0 && !file_arg->check && !file_arg->status) {
    print_hash(output, file_arg->filename, file_arg->tag, file_arg->zero);
  }
  pthread_mutex_unlock(&output_mutex);
  return NULL;
}

static void process_files_concurrently(int file_count, char **files,
                                       file_arg_t *file_args) {
  int num_cpus = get_nprocs();
  if (num_cpus <= 0)
    num_cpus = 1;
  pthread_t *threads = malloc(sizeof(pthread_t) * num_cpus);
  if (threads == NULL) {
    perror("malloc");
    exit(EXIT_FAILURE);
  }
  int thread_count = 0;
  for (int i = 0; i < file_count; i++) {
    if (pthread_create(&threads[thread_count], NULL, hash_file_thread,
                       &file_args[i]) != 0) {
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

static int process_check_line(const char *line, int tag, int strict, int warn,
                              int ignore_missing, int quiet, int status,
                              int *any_failed, int *any_format_error) {
  char *end = (char *)line + strlen(line);
  while (end > line && (end[-1] == '\n' || end[-1] == '\r')) {
    end[-1] = '\0';
    end--;
  }
  const char *hash_start = line;
  if (tag) {
    const char prefix[] = "BLAKE3 ";
    size_t plen = sizeof(prefix) - 1;
    if (strncmp(line, prefix, plen) != 0) {
      if (warn)
        fprintf(stderr, "b3sum: warning: missing 'BLAKE3 ' prefix\n");
      if (strict)
        *any_format_error = 1;
      return 0;
    }
    hash_start = line + plen;
  }
  char *space = strstr(hash_start, "  ");
  if (!space) {
    if (warn)
      fprintf(
          stderr,
          "b3sum: warning: no double space found between hash and filename\n");
    if (strict)
      *any_format_error = 1;
    return 0;
  }
  size_t hash_len = space - hash_start;
  if (hash_len != BLAKE3_OUT_LEN * 2) {
    if (warn)
      fprintf(stderr, "b3sum: warning: hash length incorrect\n");
    if (strict)
      *any_format_error = 1;
    return 0;
  }
  for (size_t i = 0; i < hash_len; i++) {
    if (!isxdigit((unsigned char)hash_start[i])) {
      if (warn)
        fprintf(stderr, "b3sum: warning: non-hex character in hash\n");
      if (strict)
        *any_format_error = 1;
      return 0;
    }
  }
  const char *filename = space + 2;
  if (*filename == '\0') {
    if (warn)
      fprintf(stderr, "b3sum: warning: no filename specified\n");
    if (strict)
      *any_format_error = 1;
    return 0;
  }
  uint8_t expected_hash[BLAKE3_OUT_LEN];
  for (size_t i = 0; i < BLAKE3_OUT_LEN; i++) {
    char byte_str[3];
    byte_str[0] = hash_start[i * 2];
    byte_str[1] = hash_start[i * 2 + 1];
    byte_str[2] = '\0';
    expected_hash[i] = (uint8_t)strtol(byte_str, NULL, 16);
  }
  uint8_t computed[BLAKE3_OUT_LEN];
  int ret = hash_file(filename, computed, ignore_missing);
  if (ret == 1) {
    if (!ignore_missing) {
      *any_failed = 1;
      if (!status) {
        fprintf(stderr, "%s: FAILED open or read\n", filename);
      }
    }
    return 0;
  } else if (ret == -1) {
    *any_failed = 1;
    if (!status) {
      fprintf(stderr, "%s: FAILED open or read\n", filename);
    }
    return 0;
  }
  int match = (memcmp(expected_hash, computed, BLAKE3_OUT_LEN) == 0);
  if (!match) {
    *any_failed = 1;
    if (!status) {
      printf("%s: FAILED\n", filename);
    }
  } else {
    if (!quiet && !status) {
      printf("%s: OK\n", filename);
    }
  }
  return 0;
}

static int process_check_files(int file_count, char **files, int tag,
                               int strict, int warn, int ignore_missing,
                               int quiet, int status) {
  int any_failed = 0;
  int any_format_error = 0;
  if (file_count == 0) {
    char *line = NULL;
    size_t len = 0;
    ssize_t n;
    while ((n = getline(&line, &len, stdin)) != -1) {
      process_check_line(line, tag, strict, warn, ignore_missing, quiet, status,
                         &any_failed, &any_format_error);
    }
    free(line);
  } else {
    for (int i = 0; i < file_count; i++) {
      FILE *f = strcmp(files[i], "-") == 0 ? stdin : fopen(files[i], "r");
      if (!f) {
        fprintf(stderr, "b3sum: %s: %s\n", files[i], strerror(errno));
        any_failed = 1;
        continue;
      }
      char *line = NULL;
      size_t len = 0;
      ssize_t n;
      while ((n = getline(&line, &len, f)) != -1) {
        process_check_line(line, tag, strict, warn, ignore_missing, quiet,
                           status, &any_failed, &any_format_error);
      }
      free(line);
      if (f != stdin)
        fclose(f);
    }
  }
  if (any_failed)
    return 1;
  if (any_format_error && strict)
    return 1;
  return 0;
}

static void process_files(int file_count, char **files, int check, int tag,
                          int zero, int ignore_missing, int quiet, int status,
                          int strict, int warn) {
  if (!check) {
    file_arg_t *file_args = malloc(sizeof(file_arg_t) * file_count);
    if (file_args == NULL) {
      perror("malloc");
      exit(EXIT_FAILURE);
    }
    for (int i = 0; i < file_count; i++) {
      file_args[i].filename = files[i];
      file_args[i].check = check;
      file_args[i].tag = tag;
      file_args[i].zero = zero;
      file_args[i].ignore_missing = ignore_missing;
      file_args[i].quiet = quiet;
      file_args[i].status = status;
      file_args[i].strict = strict;
      file_args[i].warn = warn;
    }
    process_files_concurrently(file_count, files, file_args);
    free(file_args);
  } else {
    int ret = process_check_files(file_count, files, tag, strict, warn,
                                  ignore_missing, quiet, status);
    exit(ret == 0 ? EXIT_SUCCESS : EXIT_FAILURE);
  }
}

static void process_stdin(int check, int tag, int zero, int ignore_missing,
                          int quiet, int status, int strict, int warn) {
  if (!check) {
    file_arg_t file_arg;
    file_arg.filename = "-";
    file_arg.check = check;
    file_arg.tag = tag;
    file_arg.zero = zero;
    file_arg.ignore_missing = ignore_missing;
    file_arg.quiet = quiet;
    file_arg.status = status;
    file_arg.strict = strict;
    file_arg.warn = warn;
    file_arg_t *file_args = &file_arg;
    process_files_concurrently(1, (char **)&file_arg.filename, file_args);
  } else {
    int ret = process_check_files(0, NULL, tag, strict, warn, ignore_missing,
                                  quiet, status);
    exit(ret == 0 ? EXIT_SUCCESS : EXIT_FAILURE);
  }
}

static int handle_options(int argc, char **argv, int *check, int *tag,
                          int *zero, int *ignore_missing, int *quiet,
                          int *status, int *strict, int *warn) {
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
      {0, 0, 0, 0}};
  while ((opt = getopt_long(argc, argv, "ctzwiqSswhv", long_options, NULL)) !=
         -1) {
    switch (opt) {
    case 'c':
      *check = 1;
      break;
    case 't':
      *tag = 1;
      break;
    case 'z':
      *zero = 1;
      break;
    case 'i':
      *ignore_missing = 1;
      break;
    case 'q':
      *quiet = 1;
      break;
    case 's':
      *status = 1;
      break;
    case 'S':
      *strict = 1;
      break;
    case 'w':
      *warn = 1;
      break;
    case 'h':
      print_help();
      return 0;
    case 'v':
      print_version();
      return 0;
    case '?':
    default:
      fprintf(stderr, "Try 'b3sum --help' for more information.\n");
      return -1;
    }
  }
  return optind;
}

int main(int argc, char **argv) {
  int check = 0, tag = 0, zero = 0;
  int ignore_missing = 0, quiet = 0, status = 0, strict = 0, warn = 0;
  int new_optind =
      handle_options(argc, argv, &check, &tag, &zero, &ignore_missing, &quiet,
                     &status, &strict, &warn);
  if (new_optind == -1) {
    return EXIT_FAILURE;
  } else if (new_optind == 0) {
    return EXIT_SUCCESS;
  }
  int file_count = argc - new_optind;
  if (file_count == 0) {
    process_stdin(check, tag, zero, ignore_missing, quiet, status, strict,
                  warn);
  } else {
    process_files(file_count, argv + new_optind, check, tag, zero,
                  ignore_missing, quiet, status, strict, warn);
  }
  return EXIT_SUCCESS;
}
