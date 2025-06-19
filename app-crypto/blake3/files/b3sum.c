/*
b3sum:
Usage: b3sum [OPTION]... [FILE]...
Print or check BLAKE3 (256-bit) checksums.

With no FILE, or when FILE is -, read standard input.
  -c, --check           read checksums from the FILEs and check them
      --tag             create a BSD-style checksum
  -z, --zero            end each output line with NUL, not newline,
                          and disable file name escaping

The following five options are useful only when verifying checksums:
      --ignore-missing  don't fail or report status for missing files
      --quiet           don't print OK for each successfully verified file
      --status          don't output anything, status code shows success
      --strict          exit non-zero for improperly formatted checksum lines
  -w, --warn            warn about improperly formatted checksum lines

      --help        display this help and exit
      --version     output version information and exit


BLAKE3 API
#define BLAKE3_VERSION_STRING "1.8.2"
#define sBLAKE3_KEY_LEN 32
#define BLAKE3_OUT_LEN 32
#define BLAKE3_BLOCK_LEN 64
#define BLAKE3_CHUNK_LEN 1024
#define BLAKE3_MAX_DEPTH 54

// This struct is a private implementation detail. It has to be here because
// it's part of blake3_hasher below.
typedef struct {
  uint32_t cv[8];
  uint64_t chunk_counter;
  uint8_t buf[BLAKE3_BLOCK_LEN];
  uint8_t buf_len;
  uint8_t blocks_compressed;
  uint8_t flags;
} blake3_chunk_state;

typedef struct {
  uint32_t key[8];
  blake3_chunk_state chunk;
  uint8_t cv_stack_len;
  // The stack size is MAX_DEPTH + 1 because we do lazy merging. For example,
  // with 7 chunks, we have 3 entries in the stack. Adding an 8th chunk
  // requires a 4th entry, rather than merging everything down to 1, because we
  // don't know whether more input is coming. This is different from how the
  // reference implementation does things.
  uint8_t cv_stack[(BLAKE3_MAX_DEPTH + 1) * BLAKE3_OUT_LEN];
} blake3_hasher;

BLAKE3_API const char *blake3_version(void);
BLAKE3_API void blake3_hasher_init(blake3_hasher *self);
BLAKE3_API void blake3_hasher_init_keyed(blake3_hasher *self,
                                         const uint8_t key[BLAKE3_KEY_LEN]);
BLAKE3_API void blake3_hasher_init_derive_key(blake3_hasher *self, const char *context);
BLAKE3_API void blake3_hasher_init_derive_key_raw(blake3_hasher *self, const void *context,
                                                  size_t context_len);
BLAKE3_API void blake3_hasher_update(blake3_hasher *self, const void *input,
                                     size_t input_len);
#if defined(BLAKE3_USE_TBB)
BLAKE3_API void blake3_hasher_update_tbb(blake3_hasher *self, const void *input,
                                         size_t input_len);
#endif // BLAKE3_USE_TBB
BLAKE3_API void blake3_hasher_finalize(const blake3_hasher *self, uint8_t *out,
                                       size_t out_len);
BLAKE3_API void blake3_hasher_finalize_seek(const blake3_hasher *self, uint64_t seek,
                                            uint8_t *out, size_t out_len);
BLAKE3_API void blake3_hasher_reset(blake3_hasher *self);
*/

#define _POSIX_C_SOURCE 200809L

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

#include "blake3.h"

/* We read data in chunks of 32 KiB (BLAKE3_OUT_LEN * 1024 = 32 * 1024). */
#define CHUNK_SIZE (BLAKE3_OUT_LEN * 1024)

/* Program options structure. */
typedef struct {
  int check;          /* Whether to run in "check" mode. */
  int tag;            /* Whether to use BSD-style "BLAKE3" tag format. */
  int zero;           /* End output lines with NUL instead of newline. */
  int ignore_missing; /* Ignore files that do not exist. */
  int quiet;          /* Omit "OK" lines in check mode. */
  int status;         /* Only set exit code, produce no output. */
  int strict;         /* In check mode, fail on malformed lines. */
  int warn;           /* In check mode, warn on malformed lines. */
} program_opts;

/* Task for each file in queue. */
typedef struct file_task {
  const char *filename;
  struct file_task *next;
  /* For check-mode tasks, we store the expected hash. */
  int is_check_mode;
  uint8_t expected_hash[BLAKE3_OUT_LEN];
} file_task;

/*-------------------------------------*/
/* Global state for the worker threads */
/*-------------------------------------*/
static pthread_mutex_t queue_mutex = PTHREAD_MUTEX_INITIALIZER;
static pthread_cond_t queue_cond = PTHREAD_COND_INITIALIZER;
static pthread_mutex_t output_mutex = PTHREAD_MUTEX_INITIALIZER;

/* Task queue head/tail and state signals. */
static file_task *task_queue_head = NULL;
static file_task *task_queue_tail = NULL;
static int tasks_remaining = 0;
static int done_submitting_tasks = 0; /* No more tasks will be added. */

/* Global flags for error conditions. */
static int any_failure_global = 0;      /* I/O or mismatch failures. */
static int any_format_error_global = 0; /* Malformed lines in check mode. */

/*------------------*/
/* Helper Functions */
/*------------------*/

/* Print usage (help) message. */
static void print_help(void) {
  puts(
      "Usage: b3sum [OPTION]... [FILE]...\n"
      "Print or check BLAKE3 (256-bit) checksums.\n\n"
      "With no FILE, or when FILE is -, read standard input.\n"
      "  -c, --check           read checksums from FILEs and check them\n"
      "      --tag             create or check a BSD-style checksum format\n"
      "  -z, --zero            end each output line with NUL, not newline\n"
      "      --ignore-missing  don't fail or report status for missing files\n"
      "      --quiet           don't print OK for each successfully verified file\n"
      "      --status          don't output anything, status code shows success\n"
      "      --strict          exit non-zero for improperly formatted checksum lines\n"
      "  -w, --warn            warn about improperly formatted checksum lines\n"
      "      --help            display this help and exit\n"
      "      --version         output version information and exit");
}

/* Print version message. */
static void print_version(void) { puts("b3sum version 1.1"); }

/* Parse command-line options. Returns new optind or 0/negative on help/error. */
static int handle_options(int argc, char **argv, program_opts *opts) {
  memset(opts, 0, sizeof(*opts));

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
      {0, 0, 0, 0},
  };

  int opt;
  // Remove duplicate short options
  while ((opt = getopt_long(argc, argv, "ctzwiqSwhv", long_options, NULL)) != -1) {
    switch (opt) {
      case 'c': opts->check = 1; break;
      case 't': opts->tag = 1; break;
      case 'z': opts->zero = 1; break;
      case 'i': opts->ignore_missing = 1; break;
      case 'q': opts->quiet = 1; break;
      case 's': opts->status = 1; break;
      case 'S': opts->strict = 1; break;
      case 'w': opts->warn = 1; break;
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

/* Return 1 if path is a directory, or 0 otherwise (also 0 if stat fails). */
static int is_directory(const char *path) {
  struct stat path_stat;
  if (stat(path, &path_stat) != 0) {
    return 0;
  }
  return S_ISDIR(path_stat.st_mode);
}

/*
 * Hash the contents of `filename` into `output` (32 bytes).
 * Returns:
 *    0 on success,
 *    1 if file is missing and ignore_missing is set,
 *   -1 on error (with errno set).
 */
static int hash_file(const char *filename, uint8_t *output, int ignore_missing) {
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
        return 1; /* Specifically means "file missing but ignored." */
      }
      return -1; /* Other error. */
    }
  }

  blake3_hasher hasher;
  blake3_hasher_init(&hasher);

  uint8_t buffer[CHUNK_SIZE];
  ssize_t bytes_read;
  while ((bytes_read = read(fd, buffer, CHUNK_SIZE)) > 0) {
    blake3_hasher_update(&hasher, buffer, (size_t)bytes_read);
  }

  if (bytes_read < 0) {
    int saved_errno = errno;
    if (fd != STDIN_FILENO) {
      close(fd);
    }
    errno = saved_errno;
    return -1;
  }

  if (fd != STDIN_FILENO) {
    close(fd);
  }

  blake3_hasher_finalize(&hasher, output, BLAKE3_OUT_LEN);
  return 0;
}

static char *unescape_filename(const char *in) {
  size_t len = strlen(in);
  char *out = malloc(len + 1);
  if (!out) return NULL;
  size_t j = 0;
  for (size_t i = 0; i < len;) {
    if (in[i] == '\\') {
      if (in[i+1] == 'n') {
        out[j++] = '\n';
        i += 2;
      } else if (in[i+1] == '\\') {
        out[j++] = '\\';
        i += 2;
      } else {
        // Lone backslash: copy as is
        out[j++] = in[i++];
      }
    } else {
      out[j++] = in[i++];
    }
  }
  out[j] = '\0';
  return out;
}

/*
 * Print the hash (64 hex chars for 32 bytes), plus filename.
 * If `tag` is set, prepend "BLAKE3 ".
 * If `zero` is set, terminate with NUL instead of newline.
 */
static void print_hash(const uint8_t *hash, const char *filename, int tag, int zero) {
  int needs_escape = 0;
  const char *p;

  if (!zero) {
    for (p = filename; *p; ++p) {
      if (*p == '\n' || *p == '\\') {
        needs_escape = 1;
        break;
      }
    }
  }

  if (tag) {
    fputs("BLAKE3 ", stdout);
  }

  for (size_t i = 0; i < BLAKE3_OUT_LEN; i++) {
    printf("%02x", hash[i]);
  }

  if (zero) {
    // No escaping, raw
    printf("  %s%c", (strcmp(filename, "-") == 0 ? "-" : filename), '\0');
  } else {
    if (needs_escape) {
      putchar('\\'); // signal escaped filename
    }
    printf("  "); // Always two spaces after hash

    // Print filename, escaping \ and \n
    for (p = filename; *p; ++p) {
      if (*p == '\\') {
        fputs("\\\\", stdout);
      } else if (*p == '\n') {
        fputs("\\n", stdout);
      } else {
        putchar(*p);
      }
    }
    putchar('\n');
  }
}

/*----------------------*/
/* Check-Mode Utilities */
/*----------------------*/

/*
 * Convert a 64-hex-digit string into 32 bytes. Return 0 on success, else -1.
 */
static int parse_hex_hash(const char *hex, uint8_t *out) {
  for (size_t i = 0; i < BLAKE3_OUT_LEN; i++) {
    char byte_str[3] = {hex[i * 2], hex[i * 2 + 1], '\0'};
    if (!isxdigit((unsigned char)byte_str[0]) || !isxdigit((unsigned char)byte_str[1])) {
      return -1;
    }
    errno = 0;
    unsigned long val = strtoul(byte_str, NULL, 16);
    if (val > 0xFF || errno == ERANGE) {
      return -1;
    }
    out[i] = (uint8_t)val;
  }
  return 0;
}

static int parse_check_line(const char *line_in, const program_opts *opts, char **filename_out, uint8_t *hash_out) {
  char *line = strdup(line_in);
  if (!line) {
    return -1;
  }

  // Strip trailing newlines.
  char *end = line + strlen(line);
  while (end > line && (end[-1] == '\n' || end[-1] == '\r')) {
    end[-1] = '\0';
    end--;
  }

  const char *hash_start = line;
  if (opts->tag) {
    const char prefix[] = "BLAKE3 ";
    size_t plen = strlen(prefix);
    if (strncmp(line, prefix, plen) != 0) {
      free(line);
      return -1; // Missing "BLAKE3 ".
    }
    hash_start = line + plen;
  }

  int needs_unescape = 0;
  // GNU-style: if line starts with \ (after optional tag), treat as escaped
  if (!opts->zero && hash_start[0] == '\\') {
    needs_unescape = 1;
    hash_start++; // skip leading
  }

  // Accept both "  " and " *" as marker (coreutils compatible)
  char *space = strstr(hash_start, "  ");
  char *star  = strstr(hash_start, " *");
  char *marker = NULL;
  if (space && (!star || space < star)) {
    marker = space;
  } else if (star) {
    marker = star;
  } else {
    free(line);
    return -1; // No valid marker found
  }

  size_t hash_len = (size_t)(marker - hash_start);
  if (hash_len != (BLAKE3_OUT_LEN * 2)) {
    free(line);
    return -1; // Incorrect hash length.
  }

  if (parse_hex_hash(hash_start, hash_out) != 0) {
    free(line);
    return -1; // Invalid hex.
  }

  const char *fname = marker + 2; // skip marker
  if (*fname == '\0') {
    free(line);
    return -1; // Missing filename.
  }

  if (needs_unescape) {
    *filename_out = unescape_filename(fname);
  } else {
    *filename_out = strdup(fname);
  }

  free(line);
  if (!(*filename_out)) {
    return -1;
  }
  return 0;
}

/*
 * Build a check-mode task for each line. The worker thread will do the hashing.
 */
static int enqueue_check_line(const char *line, const program_opts *opts) {
  char *filename = NULL;
  uint8_t expected_hash[BLAKE3_OUT_LEN];

  if (parse_check_line(line, opts, &filename, expected_hash) != 0) {
    return -1; /* Format error. */
  }

  file_task *task = calloc(1, sizeof(*task));
  if (!task) {
    free(filename);
    return -1;
  }
  task->filename = filename; /* Freed by worker when done. */
  task->is_check_mode = 1;
  memcpy(task->expected_hash, expected_hash, BLAKE3_OUT_LEN);

  /* Enqueue. */
  pthread_mutex_lock(&queue_mutex);
  if (!task_queue_head) {
    task_queue_head = task;
    task_queue_tail = task;
  } else {
    task_queue_tail->next = task;
    task_queue_tail = task;
  }
  tasks_remaining++;
  pthread_cond_signal(&queue_cond);
  pthread_mutex_unlock(&queue_mutex);

  return 0;
}

/*----------------------*/
/* Task Queue Utilities */
/*----------------------*/

/* Enqueue a single hash-mode task. */
static void enqueue_task_hash_mode(const char *filename) {
  file_task *task = calloc(1, sizeof(*task));
  if (!task) {
    perror("calloc");
    exit(EXIT_FAILURE);
  }
  task->filename = filename; /* Freed if needed in worker. */
  task->is_check_mode = 0;

  pthread_mutex_lock(&queue_mutex);
  if (!task_queue_head) {
    task_queue_head = task;
    task_queue_tail = task;
  } else {
    task_queue_tail->next = task;
    task_queue_tail = task;
  }
  tasks_remaining++;
  pthread_cond_signal(&queue_cond);
  pthread_mutex_unlock(&queue_mutex);
}

/* Dequeue a task. Block if none is available, unless done_submitting_tasks. */
static file_task *dequeue_task(void) {
  pthread_mutex_lock(&queue_mutex);
  while (!task_queue_head && !done_submitting_tasks) {
    pthread_cond_wait(&queue_cond, &queue_mutex);
  }
  if (!task_queue_head) {
    /* Nothing left. */
    pthread_mutex_unlock(&queue_mutex);
    return NULL;
  }
  file_task *task = task_queue_head;
  task_queue_head = task->next;
  if (!task_queue_head) {
    task_queue_tail = NULL;
  }
  tasks_remaining--;
  pthread_mutex_unlock(&queue_mutex);
  return task;
}

/*---------------------------------------------------*/
/* Worker Thread Function: handles both check + hash */
/*---------------------------------------------------*/
static void *worker_thread_func(void *arg) {
  const program_opts *opts = (const program_opts *)arg;
  uint8_t output[BLAKE3_OUT_LEN] = {0};

  for (;;) {
    file_task *task = dequeue_task();
    if (!task) {
      break; /* No more tasks. */
    }

    if (task->is_check_mode) {
      /* Check-mode task. We have the expected hash already. */
      int ret = hash_file(task->filename, output, opts->ignore_missing);

      pthread_mutex_lock(&output_mutex);
      if (ret == 1) {
        /* Missing file but ignoring. */
        if (!opts->ignore_missing) {
          any_failure_global = 1;
          if (!opts->status) {
            fprintf(stderr, "%s: FAILED open or read\n", task->filename);
          }
        }
      } else if (ret == -1) {
        any_failure_global = 1;
        if (!opts->status) {
          fprintf(stderr, "%s: FAILED open or read\n", task->filename);
        }
      } else {
        /* Compare computed with expected. */
        if (memcmp(task->expected_hash, output, BLAKE3_OUT_LEN) != 0) {
          any_failure_global = 1;
          if (!opts->status) {
            printf("%s: FAILED\n", task->filename);
          }
        } else {
          if (!opts->quiet && !opts->status) {
            printf("%s: OK\n", task->filename);
          }
        }
      }
      pthread_mutex_unlock(&output_mutex);

      /* filename was strdup'ed, so free it now. */
      free((char *)task->filename);

    } else {
      /* Hash-mode task. Just compute and print. */
      int ret = hash_file(task->filename, output, opts->ignore_missing);

      pthread_mutex_lock(&output_mutex);
      if (ret == -1 && !opts->ignore_missing) {
        any_failure_global = 1;
        fprintf(stderr, "b3sum: %s: %s\n", task->filename, strerror(errno));
      } else if (ret == 0 && !opts->check && !opts->status) {
        print_hash(output, task->filename, opts->tag, opts->zero);
      }
      pthread_mutex_unlock(&output_mutex);
      /* In hash mode, we did not strdup, so no free(task->filename). */
    }

    free(task);
  }
  return NULL;
}

/*
 * Start N threads, process tasks until complete, join them.
 */
static void launch_thread_pool_and_wait(const program_opts *opts) {
  int num_cpus = get_nprocs();
  if (num_cpus < 1) {
    num_cpus = 1;
  }

  pthread_t *threads = malloc(sizeof(pthread_t) * (size_t)num_cpus);
  if (!threads) {
    perror("malloc");
    exit(EXIT_FAILURE);
  }

  /* Start worker threads. */
  for (int i = 0; i < num_cpus; i++) {
    if (pthread_create(&threads[i], NULL, worker_thread_func, (void *)opts) != 0) {
      perror("pthread_create");
      exit(EXIT_FAILURE);
    }
  }

  /* Wait for all threads. */
  for (int i = 0; i < num_cpus; i++) {
    pthread_join(threads[i], NULL);
  }
  free(threads);
}

/*--------------------------------------------*/
/* Hash Mode: Enqueue tasks for all filenames */
/*--------------------------------------------*/
static void process_files_concurrently(int file_count, char **files, const program_opts *opts) {
  /* Enqueue tasks. */
  for (int i = 0; i < file_count; i++) {
    enqueue_task_hash_mode(files[i]);
  }

  /* Signal no more tasks. */
  pthread_mutex_lock(&queue_mutex);
  done_submitting_tasks = 1;
  pthread_cond_broadcast(&queue_cond);
  pthread_mutex_unlock(&queue_mutex);

  /* Start threads, wait, done. */
  launch_thread_pool_and_wait(opts);
}

/*------------------------------------------------*/
/* Check Mode: Enqueue tasks from lines in a file */
/*------------------------------------------------*/
static int process_check_files_multithread(int file_count, char **files, const program_opts *opts) {
  /* Read lines from each input, parse, then enqueue. */

  if (file_count == 0) {
    /* Stdin only. */
    char *line = NULL;
    size_t len = 0;
    ssize_t n;
    while ((n = getline(&line, &len, stdin)) != -1) {
      if (enqueue_check_line(line, opts) != 0) {
        /* Format error. */
        if (opts->warn) {
          fprintf(stderr, "b3sum: warning: invalid line in checksum input\n");
        }
        if (opts->strict) {
          any_format_error_global = 1;
        }
      }
    }
    free(line);
  } else {
    for (int i = 0; i < file_count; i++) {
      FILE *f = (strcmp(files[i], "-") == 0) ? stdin : fopen(files[i], "r");
      if (!f) {
        fprintf(stderr, "b3sum: %s: %s\n", files[i], strerror(errno));
        any_failure_global = 1;
        continue;
      }
      char *line = NULL;
      size_t len = 0;
      ssize_t n;
      while ((n = getline(&line, &len, f)) != -1) {
        if (enqueue_check_line(line, opts) != 0) {
          if (opts->warn) {
            fprintf(stderr, "b3sum: warning: invalid line in checksum input\n");
          }
          if (opts->strict) {
            any_format_error_global = 1;
          }
        }
      }
      free(line);
      if (f != stdin) {
        fclose(f);
      }
    }
  }

  /* Signal no more tasks. */
  pthread_mutex_lock(&queue_mutex);
  done_submitting_tasks = 1;
  pthread_cond_broadcast(&queue_cond);
  pthread_mutex_unlock(&queue_mutex);

  /* Launch threads. */
  launch_thread_pool_and_wait(opts);

  /* Return status. */
  if (any_failure_global) {
    return 1;
  }
  if (any_format_error_global && opts->strict) {
    return 1;
  }
  return 0;
}

/*------*/
/* Main */
/*------*/

int main(int argc, char **argv) {
  program_opts opts;
  int new_optind = handle_options(argc, argv, &opts);
  if (new_optind < 0) {
    return EXIT_FAILURE;
  } else if (new_optind == 0) {
    return EXIT_SUCCESS;
  }

  blake3_mt_pool_init(0);

  int ret = EXIT_SUCCESS;

  int file_count = argc - new_optind;
  char **files = &argv[new_optind];

  if (opts.check) {
    ret = process_check_files_multithread(file_count, files, &opts);
    if (ret != 0) ret = EXIT_FAILURE;
    else ret = EXIT_SUCCESS;
  } else {
    if (file_count == 0) {
      static char *fake_argv[] = {"-"};
      file_count = 1;
      files = fake_argv;
    }

    process_files_concurrently(file_count, files, &opts);
    if (any_failure_global)
      ret = EXIT_FAILURE;
  }

  blake3_mt_pool_destroy();

  return ret;
}
