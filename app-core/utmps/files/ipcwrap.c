#define _GNU_SOURCE

#include <sys/socket.h>
#include <sys/types.h>
#include <sys/un.h>
#include <sys/wait.h>
#include <unistd.h>
#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <signal.h>
#include <string.h>
#include <stddef.h>

static int maxconn = 40;
static int localmaxconn = 40;

static volatile sig_atomic_t got_sigchld = 0;
static volatile sig_atomic_t got_sighup  = 0;
static volatile sig_atomic_t got_sigterm = 0;
static volatile sig_atomic_t got_sigquit = 0;
static volatile sig_atomic_t got_sigabrt = 0;

struct client {
    pid_t pid;
    uid_t uid;
    struct client *next;
};
static struct client *clients = NULL;
static int curconn = 0;

static void fatal(const char *msg) {
    perror(msg);
    _exit(111);
}

static void remove_client(pid_t pid) {
    // Remove client with given pid from the linked list
    struct client **pp = &clients;
    while (*pp) {
        if ((*pp)->pid == pid) {
            struct client *tmp = *pp;
            *pp = tmp->next;
            free(tmp);
            curconn--;
            return;
        }
        pp = &((*pp)->next);
    }
}

// Signal handlers – set flags for main loop to process
static void handle_chld(int sig) { (void)sig; got_sigchld = 1; }
static void handle_hup(int sig)  { (void)sig; got_sighup  = 1; }
static void handle_term(int sig) { (void)sig; got_sigterm = 1; }
static void handle_quit(int sig) { (void)sig; got_sigquit = 1; }
static void handle_abrt(int sig) { (void)sig; got_sigabrt = 1; }

int main(int argc, char *argv[]) {
    // Parse optional arguments for connection limits
    int argi = 1;
    while (argi < argc && argv[argi][0] == '-') {
        if (strcmp(argv[argi], "-c") == 0) {
            if (++argi >= argc) {
                fprintf(stderr, "usage: ipcwrap [-c maxconn] [-C localmaxconn] prog [args...]\n");
                return 100;
            }
            maxconn = atoi(argv[argi]);
            if (maxconn < 0) maxconn = 0;  // 0 can mean "no limit"
        }
        else if (strcmp(argv[argi], "-C") == 0) {
            if (++argi >= argc) {
                fprintf(stderr, "usage: ipcwrap [-c maxconn] [-C localmaxconn] prog [args...]\n");
                return 100;
            }
            localmaxconn = atoi(argv[argi]);
            if (localmaxconn < 0) localmaxconn = 0;  // 0 -> no limit per user
        }
        else if (strcmp(argv[argi], "-h") == 0 || strcmp(argv[argi], "--help") == 0) {
            fprintf(stderr, "usage: ipcwrap [-c maxconn] [-C localmaxconn] prog [args...]\n");
            return 100;
        } else {
            break;  // unrecognized option (assume end of options)
        }
        argi++;
    }
    if (argi >= argc) {
        fprintf(stderr, "usage: ipcwrap [-c maxconn] [-C localmaxconn] prog [args...]\n");
        return 100;
    }
    // Ensure localmaxconn does not exceed global maxconn if both set
    if (maxconn > 0 && localmaxconn > maxconn) {
        localmaxconn = maxconn;
    }

    // Listening socket (from systemd or other superserver) is on stdin
    int lsock = STDIN_FILENO;

    // Set up signal handlers for CHLD, HUP, TERM, QUIT, ABRT
    struct sigaction sa;
    memset(&sa, 0, sizeof(sa));
    sa.sa_flags = 0;
    sigemptyset(&sa.sa_mask);
    sa.sa_handler = handle_chld;
    sigaction(SIGCHLD, &sa, NULL);
    sa.sa_handler = handle_hup;
    sigaction(SIGHUP,  &sa, NULL);
    sa.sa_handler = handle_term;
    sigaction(SIGTERM, &sa, NULL);
    sa.sa_handler = handle_quit;
    sigaction(SIGQUIT, &sa, NULL);
    sa.sa_handler = handle_abrt;
    sigaction(SIGABRT, &sa, NULL);
    signal(SIGPIPE, SIG_IGN);  // ignore SIGPIPE to prevent crashes on broken pipes

    // (Optional) If needed, notify readiness here (similar to s6 -1 flag)

    // Main server loop
    for (;;) {
        // First, handle any pending signals in a controlled way
        if (got_sigchld) {
            // Reap all exited children
            int status;
            pid_t pid;
            while ((pid = waitpid(-1, &status, WNOHANG)) > 0) {
                remove_client(pid);
            }
            got_sigchld = 0;
        }
        if (got_sighup) {
            // Terminate all active children (graceful restart)
            for (struct client *c = clients; c != NULL; c = c->next) {
                kill(c->pid, SIGTERM);
                kill(c->pid, SIGCONT);  // in case any child was stopped
            }
            got_sighup = 0;
            // Continue running (do not exit)
        }
        if (got_sigquit) {
            // Graceful shutdown: terminate children, then exit
            for (struct client *c = clients; c != NULL; c = c->next) {
                kill(c->pid, SIGTERM);
                kill(c->pid, SIGCONT);
            }
            // No explicit wait; children will terminate (or be killed by systemd)
            return 0;
        }
        if (got_sigabrt) {
            // Immediate shutdown: kill children and exit
            for (struct client *c = clients; c != NULL; c = c->next) {
                kill(c->pid, SIGKILL);
            }
            return 0;
        }
        if (got_sigterm) {
            // Exit without touching children (they may continue independently)
            return 0;
        }

        // Accept the next client connection (blocking)
        int csock = accept(lsock, NULL, NULL);
        if (csock == -1) {
            if (errno == EINTR) {
                // accept was interrupted by a signal, restart loop to handle it
                continue;
            }
            fatal("accept");
        }

        // Retrieve client credentials (UID, GID) via SO_PEERCRED
        struct ucred cred;
        socklen_t cred_len = sizeof(cred);
        if (getsockopt(csock, SOL_SOCKET, SO_PEERCRED, &cred, &cred_len) == -1) {
            perror("getsockopt(SO_PEERCRED)");
            close(csock);
            continue;
        }

        // Enforce global connection limit if set
        if (maxconn > 0 && curconn >= maxconn) {
            close(csock);
            continue;
        }
        // Enforce per-user connection limit if set
        if (localmaxconn > 0) {
            int user_count = 0;
            for (struct client *c = clients; c != NULL; c = c->next) {
                if (c->uid == cred.uid) user_count++;
            }
            if (user_count >= localmaxconn) {
                close(csock);
                continue;
            }
        }

        // Prepare to fork: create a record for this new connection
        struct client *newcli = malloc(sizeof(struct client));
        if (!newcli) {
            fprintf(stderr, "ipcwrap: out of memory, dropping connection\n");
            close(csock);
            continue;
        }

        // Set up environment variables for the child process
        char buf[32];
        int user_count = 0;
        for (struct client *c = clients; c != NULL; c = c->next) {
            if (c->uid == cred.uid) user_count++;
        }
        snprintf(buf, sizeof(buf), "%d", user_count + 1);
        setenv("IPCCONNNUM", buf, 1);
        setenv("PROTO", "IPC", 1);
        snprintf(buf, sizeof(buf), "%u", cred.uid);
        setenv("IPCREMOTEEUID", buf, 1);
        snprintf(buf, sizeof(buf), "%u", cred.gid);
        setenv("IPCREMOTEEGID", buf, 1);

        // Determine peer socket path for IPCREMOTEPATH
        struct sockaddr_un peer_addr;
        socklen_t addr_len = sizeof(peer_addr);
        if (getpeername(csock, (struct sockaddr*)&peer_addr, &addr_len) == -1) {
            setenv("IPCREMOTEPATH", "", 1);
        } else if (addr_len <= offsetof(struct sockaddr_un, sun_path)) {
            // No address info (peer didn’t bind name)
            setenv("IPCREMOTEPATH", "", 1);
        } else if (peer_addr.sun_path[0] == '\0') {
            // Abstract namespace socket: represent leading null as '@'
            int pathlen = addr_len - offsetof(struct sockaddr_un, sun_path);
            if (pathlen > 0) {
                // Copy bytes after the leading null
                char pathbuf[108];  // typical max length for sun_path
                int copylen = pathlen - 1;  // exclude the leading null
                if (copylen > (int)sizeof(pathbuf) - 1)
                    copylen = sizeof(pathbuf) - 1;
                pathbuf[0] = '@';
                if (copylen > 0) {
                    memcpy(pathbuf + 1, peer_addr.sun_path + 1, copylen);
                }
                pathbuf[1 + copylen] = '\0';
                setenv("IPCREMOTEPATH", pathbuf, 1);
            } else {
                setenv("IPCREMOTEPATH", "", 1);
            }
        } else {
            // Filesystem-bound socket path (ensure null-terminated)
            peer_addr.sun_path[sizeof(peer_addr.sun_path) - 1] = '\0';
            setenv("IPCREMOTEPATH", peer_addr.sun_path, 1);
        }

        // Fork a child to handle this connection
        pid_t pid = fork();
        if (pid == -1) {
            fatal("fork");
        }
        if (pid == 0) {
            // Child process: set up socket as stdio and exec target program
            dup2(csock, STDIN_FILENO);
            dup2(csock, STDOUT_FILENO);
            if (csock > STDOUT_FILENO) close(csock);
            execvp(argv[argi], &argv[argi]);
            fatal("execvp");  // if execvp fails
        }

        // Parent process: close the connected socket and record the child
        close(csock);
        newcli->pid = pid;
        newcli->uid = cred.uid;
        newcli->next = clients;
        clients = newcli;
        curconn++;
    }
}
