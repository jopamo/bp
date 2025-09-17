#include "ucm_local.h"

#include <errno.h>
#include <fcntl.h>
#include <pthread.h>
#include <signal.h>
#include <stdarg.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include <dirent.h>
#include <limits.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>

#ifdef __linux__
#include <sys/syscall.h>
#endif

#if defined(__NetBSD__) || defined(__OpenBSD__) || defined(__FreeBSD__) || defined(__DragonFly__)
#include <signal.h>
#if defined(__DragonFly__)
#define environ NULL /* XXX */
#else
extern char **environ;
#endif
#else
extern char **environ;
#endif

static pthread_mutex_t fork_lock = PTHREAD_MUTEX_INITIALIZER;

/* best-effort close-range using the raw syscall if present, else ENOSYS */
static int close_range_compat(unsigned int first, unsigned int last, unsigned int flags)
{
#ifdef __linux__
#  ifdef __NR_close_range
	long ret = syscall(__NR_close_range, first, last, flags);
	if (ret == -1) return -1;
	return 0;
#  else
	errno = ENOSYS;
	return -1;
#  endif
#else
	errno = ENOSYS;
	return -1;
#endif
}

/* fallback close-from using /proc/self/fd when available, else linear loop */
static void closefrom_fallback(int lowfd, int maxfd)
{
	DIR *d = opendir("/proc/self/fd");
	if (d) {
		struct dirent *de;
		while ((de = readdir(d))) {
			char *end = NULL;
			long fd = strtol(de->d_name, &end, 10);
			if (end == de->d_name || *end != '\0')
				continue;
			if (fd >= lowfd && fd < maxfd)
				close((int)fd);
		}
		closedir(d);
	} else {
		for (int f = lowfd; f < maxfd; f++)
			close(f);
	}
}

/* search PATH for executable */
static int find_exec(const char *name, char *out, size_t len)
{
	int ret = 0;
	char bin[PATH_MAX];
	char *path, *tmp, *tmp2 = NULL;
	DIR *dir;
	struct dirent *de;
	struct stat st;

	if (name[0] == '/') {
		if (lstat(name, &st))
			return 0;
		if (!S_ISREG(st.st_mode) || access(name, X_OK) != 0)
			return 0;
		snd_strlcpy(out, name, len);
		return 1;
	}
	if (!(tmp = getenv("PATH")))
		return 0;

	path = alloca(strlen(tmp) + 1);
	if (!path)
		return 0;
	strcpy(path, tmp);

	tmp = strtok_r(path, ":", &tmp2);
	while (tmp && !ret) {
		if ((dir = opendir(tmp))) {
			while ((de = readdir(dir))) {
				if (strstr(de->d_name, name) != de->d_name)
					continue;
				snprintf(bin, sizeof(bin), "%s/%s", tmp, de->d_name);
				if (lstat(bin, &st))
					continue;
				if (!S_ISREG(st.st_mode) || access(bin, X_OK) != 0)
					continue;
				snd_strlcpy(out, bin, len);
				closedir(dir);
				return 1;
			}
			closedir(dir);
		}
		tmp = strtok_r(NULL, ":", &tmp2);
	}
	return ret;
}

static void free_args(char **argv)
{
	char **a;
	for (a = argv; *a; a++)
		free(*a);
	free(argv);
}

static int parse_args(char ***argv, int argc, const char *cmd)
{
	char *s, *f;
	int i = 0, l, eow;

	if (!argv || !cmd)
		return -1;

	s = alloca(strlen(cmd) + 1);
	if (!s)
		return -1;
	strcpy(s, cmd);
	*argv = calloc(argc, sizeof(char *));
	if (!*argv)
		return -ENOMEM;

	while (*s && i < argc - 1) {
		while (*s == ' ')
			s++;
		f = s;
		eow = 0;
		while (*s) {
			if (*s == '\\') {
				l = *(s + 1);
				if (l == 'b')
					l = '\b';
				else if (l == 'f')
					l = '\f';
				else if (l == 'n')
					l = '\n';
				else if (l == 'r')
					l = '\r';
				else if (l == 't')
					l = '\t';
				else
					l = 0;
				if (l) {
					*s++ = l;
					memmove(s, s + 1, strlen(s));
				} else {
					memmove(s, s + 1, strlen(s));
					if (*s)
						s++;
				}
			} else if (eow) {
				if (*s == eow) {
					memmove(s, s + 1, strlen(s));
					eow = 0;
				} else {
					s++;
				}
			} else if (*s == '\'' || *s == '"') {
				eow = *s;
				memmove(s, s + 1, strlen(s));
			} else if (*s == ' ') {
				break;
			} else {
				s++;
			}
		}
		if (f != s) {
			if (*s) {
				*(char *)s = '\0';
				s++;
			}
			(*argv)[i] = strdup(f);
			if ((*argv)[i] == NULL) {
				free_args(*argv);
				return -ENOMEM;
			}
			i++;
		}
	}
	(*argv)[i] = NULL;
	return 0;
}

/* execute a binary file */
int uc_mgr_exec(const char *prog)
{
	pid_t p, f;
	long maxfd;
	int err = 0, status;
	char bin[PATH_MAX];
	struct sigaction sa;
	struct sigaction intr, quit;
	sigset_t omask;
	char **argv;

	if (parse_args(&argv, 32, prog))
		return -EINVAL;

	prog = argv[0];
	if (prog == NULL) {
		err = -EINVAL;
		goto __error;
	}
	if (prog[0] != '/' && prog[0] != '.') {
		if (!find_exec(argv[0], bin, sizeof(bin))) {
			err = -ENOEXEC;
			goto __error;
		}
		prog = bin;
	}

	maxfd = sysconf(_SC_OPEN_MAX);
	if (maxfd < 0)
		maxfd = 1024; /* conservative fallback */

	memset(&sa, 0, sizeof(sa));
	sa.sa_handler = SIG_IGN;
	sigemptyset(&sa.sa_mask);
	sigaddset(&sa.sa_mask, SIGCHLD);

	pthread_mutex_lock(&fork_lock);

	sigprocmask(SIG_BLOCK, &sa.sa_mask, &omask);

	sigaction(SIGINT, &sa, &intr);
	sigaction(SIGQUIT, &sa, &quit);

	p = fork();

	if (p == -1) {
		err = -errno;
		pthread_mutex_unlock(&fork_lock);
		uc_error("Unable to fork() for \"%s\" -- %s", prog, strerror(errno));
		goto __error;
	}

	if (p == 0) {
		int devnull = open("/dev/null", O_RDWR);
		if (devnull == -1) {
			uc_error("pid %d cannot open /dev/null for redirect %s -- %s",
			         getpid(), prog, strerror(errno));
			_exit(1);
		}

		close(0);
		close(1);
		close(2);

		dup2(devnull, 0);
		dup2(devnull, 1);
		dup2(devnull, 2);
		close(devnull);

		/* try kernel close_range, otherwise fall back */
		if (close_range_compat(3u, (unsigned int)maxfd, 0u) == -1)
			closefrom_fallback(3, (int)maxfd);

		/* install default handlers for the forked process */
		signal(SIGINT, SIG_DFL);
		signal(SIGQUIT, SIG_DFL);

		execve(prog, argv, environ);
		_exit(1);
	}

	/* parent path */
	sigaction(SIGINT, &intr, NULL);
	sigaction(SIGQUIT, &quit, NULL);
	sigprocmask(SIG_SETMASK, &omask, NULL);

	pthread_mutex_unlock(&fork_lock);

	/* make the spawned process a session leader so killing the process group
	   recursively kills any child process that might have been spawned */
	setpgid(p, p);

	while (1) {
		f = waitpid(p, &status, 0);
		if (f == -1) {
			if (errno == EAGAIN)
				continue;
			err = -errno;
			goto __error;
		}
		if (WIFSIGNALED(status)) {
			err = -EINTR;
			break;
		}
		if (WIFEXITED(status)) {
			err = WEXITSTATUS(status);
			break;
		}
	}

__error:
	free_args(argv);
	return err;
}
