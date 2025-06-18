##
# Prologue
##
AC_PREREQ([2.69])
AC_INIT([scrub], [1.0], [your@email.here], [scrub])

AC_CONFIG_AUX_DIR([config])
AC_CONFIG_SRCDIR([NEWS])
AC_CANONICAL_SYSTEM
AC_CONFIG_MACRO_DIR([config])
# If X_AC_EXPAND_INSTALL_DIRS is a custom macro, make sure it's defined elsewhere.
# X_AC_EXPAND_INSTALL_DIRS

##
# Automake support
##
AM_INIT_AUTOMAKE([subdir-objects foreign])
AM_SILENT_RULES([yes])
AC_CONFIG_HEADERS([config/config.h])
AM_MAINTAINER_MODE

##
# Conditionally build libscrub
##
AC_ARG_ENABLE([libscrub],
  [AS_HELP_STRING([--enable-libscrub], [Build libscrub])],
  [case "${enableval}" in
    yes) libscrub=true ;;
    no) libscrub=false ;;
    *) AC_MSG_ERROR([bad value ${enableval} for --enable-libscrub]) ;;
  esac], [libscrub=false])
AM_CONDITIONAL([LIBSCRUB], [test x$libscrub = xtrue])

##
# Checks for programs
##
AC_PROG_CC
AM_PROG_CC_C_O

##
# Checks for header files.
##
AC_USE_SYSTEM_EXTENSIONS
AC_HEADER_STDC
AC_CHECK_HEADERS([ \
  getopt.h \
  stdbool.h \
  stdint.h \
  pthread.h \
  linux/fs.h \
  sys/devinfo.h \
  sys/disk.h \
  sys/dkio.h \
  sys/ioctl.h \
  sys/scsi.h \
  sys/mman.h \
])

AC_PROG_LIBTOOL
# AC_PKGCONFIG is not a standard macro; use PKG_PROG_PKG_CONFIG instead
PKG_PROG_PKG_CONFIG

##
# Checks for typedefs, structures, and compiler characteristics
##
AC_C_BIGENDIAN
AC_C_CONST

##
# Checks for libraries
##
AC_CHECK_LIB([prop], [prop_dictionary_recv_ioctl], [LIBPROP=-lprop])
AC_SUBST([LIBPROP])

AX_PTHREAD
AC_DEFINE([WITH_PTHREADS], [1], [Define if pthreads should be enabled])

##
# Checks for library functions
##
AC_CHECK_FUNCS([ \
  getopt_long \
  posix_memalign \
  memalign \
  posix_fadvise \
  rand_r \
  random_r \
])

##
# Crypto sanity check
##
AC_ARG_WITH([openssl],
  [AS_HELP_STRING([--with-openssl], [build with OpenSSL libcrypto])])
AC_ARG_WITH([libgcrypt],
  [AS_HELP_STRING([--with-libgcrypt], [build with libgcrypt (default: yes if OpenSSL not set)])])

AS_IF([test "x$with_openssl" = "xyes" && test "x$with_libgcrypt" = "xyes"], [
  AC_MSG_ERROR([You can use either --with-openssl or --with-libgcrypt, not both at once])
])

##
# OpenSSL libcrypto library
##
have_openssl=no
if test "x$with_openssl" = "xyes"; then
  AC_SEARCH_LIBS([RAND_bytes], [crypto],
    [AC_DEFINE([HAVE_OPENSSL], [1], [OpenSSL libcrypto available])
      have_openssl=yes
    ], [AC_MSG_ERROR([OpenSSL libcrypto required])]
  )
fi

##
# gcrypt library
##
have_libgcrypt=no
AS_IF([test "x$with_openssl" != "xyes"], [
  AS_IF([test "x$with_libgcrypt" != "xno"], [
    PKG_CHECK_MODULES([LIBGCRYPT], [libgcrypt >= 1.5.0],
      [AC_DEFINE([HAVE_LIBGCRYPT], [1], [libgcrypt API available])
        gcrypt_CFLAGS="$LIBGCRYPT_CFLAGS"
        gcrypt_LIBS="$LIBGCRYPT_LIBS"
        have_libgcrypt=yes
      ])
  ])
])
AM_CONDITIONAL([LIBGCRYPT], [test "$have_libgcrypt" = "yes"])
AC_SUBST([gcrypt_CFLAGS])
AC_SUBST([gcrypt_LIBS])

##
# Arrange for large file support
##
AC_SYS_LARGEFILE

##
# Epilogue
##
AC_CONFIG_FILES([ \
  Makefile \
  scrub.spec \
  src/Makefile \
  man/Makefile \
  man/scrub.1 \
  test/Makefile \
  libscrub/Makefile \
  libscrub/libscrub.pc \
])
AC_OUTPUT
