# GNU Autoconf Archive — Usage & Quick Reference

Autoconf Archive is a large collection of reusable M4 macros you can call from `configure.ac` to add feature checks, compiler flag probing, code coverage helpers, threading setup, Boost detection, and more

## What this package installs

- Macro files under `/usr/share/aclocal/ax_*.m4`  
- Info manual under `/usr/share/info/autoconf-archive.info*`

These macros are consumed at *autoconf time* by `aclocal`/`autoreconf`, not by end users running `./configure`

---

## Ways to use the macros

### 1) Use them directly from the system

If your build host has `autoconf-archive` installed, simply invoke the macros in `configure.ac` and run `autoreconf`  
`aclocal` already searches `/usr/share/aclocal`

```sh
autoreconf -fi    # regenerate using macros from the system
````

### 2) Vendor specific macros into your tree

Recommended when you expect contributors or CI to run `autoreconf` without the package installed

```sh
mkdir -p m4
# copy only the macros you use into ./m4, commit them

# tell tools where your local macros live
# in configure.ac
AC_CONFIG_MACRO_DIRS([m4])

# regenerate
autoreconf -fi -I m4
```

---

## Discover what’s available

```sh
# list macro names provided by this package
grep -h '^AC_DEFUN(\\[AX_[A-Z0-9_]*\\]' /usr/share/aclocal/ax_*.m4 \
  | sed -E 's/.*\\[(AX_[A-Z0-9_]+)\\].*/\\1/' \
  | sort -u
```

The installed info manual also indexes all macros

```sh
info autoconf-archive     # browse macro docs
```

---

## Commonly used macros — drop-in snippets

### Probe and append safe compiler flags

```m4
dnl add -Wall -Wextra if supported
AX_APPEND_COMPILE_FLAGS([-Wall -Wextra], [CFLAGS])

dnl require a flag for specific checks
AX_CHECK_COMPILE_FLAG([-fno-strict-aliasing],
  [CFLAGS="$CFLAGS -fno-strict-aliasing"])
```

tips

* `AX_APPEND_COMPILE_FLAGS` checks each flag works before appending
* `AX_CHECK_COMPILE_FLAG` lets you run success or failure actions

### Select a C++ standard reliably

```m4
dnl pick a C++ standard in a portable way
dnl use one of these helpers or the generic macro depending on preference

AX_CXX_COMPILE_STDCXX([17], [noext], [mandatory])  dnl require C++17
dnl or the convenience aliases:
dnl AX_CXX_COMPILE_STDCXX_11()
dnl AX_CXX_COMPILE_STDCXX_14()
```

notes

* `mandatory` enforces failure if the requested standard is unsupported
* `noext` asks for a strictly conforming mode when available

### POSIX threads the portable way

```m4
AX_PTHREAD
CFLAGS="$CFLAGS $PTHREAD_CFLAGS"
CXXFLAGS="$CXXFLAGS $PTHREAD_CFLAGS"
LIBS="$PTHREAD_LIBS $LIBS"
```

tips

* `AX_PTHREAD` figures out flags and libraries across platforms
* prefer using the variables it sets rather than hard-coding `-pthread` or `-lpthread`

### Code coverage helpers for Autotools projects

```m4
dnl enable with: ./configure --enable-code-coverage
AX_CODE_COVERAGE
```

```make
# in Makefile.am, add the variables it defines to relevant targets
prog_CPPFLAGS += $(CODE_COVERAGE_CPPFLAGS)
prog_CFLAGS   += $(CODE_COVERAGE_CFLAGS)
prog_LDFLAGS  += $(CODE_COVERAGE_LDFLAGS)
prog_LIBS     += $(CODE_COVERAGE_LIBS)
```

### Boost detection examples

```m4
AX_BOOST_BASE([1.70], [], [AC_MSG_ERROR([Boost >= 1.70 not found])])
AX_BOOST_SYSTEM
```

---

## Workflow example

```m4
dnl configure.ac
AC_INIT([mypkg], [1.0], [bugs@example.com])
AC_CONFIG_SRCDIR([src/main.c])
AC_CONFIG_MACRO_DIRS([m4])                     dnl if vendoring macros
AC_PROG_CC
AX_APPEND_COMPILE_FLAGS([-Wall -Wextra], [CFLAGS])
AX_CXX_COMPILE_STDCXX([17], [noext], [mandatory])
AX_PTHREAD
AC_CONFIG_HEADERS([config.h])
AC_OUTPUT([Makefile src/Makefile])
```

```sh
autoreconf -fi -I m4   # include your vendored macro dir when regenerating
./configure
make
```

---

## Notes and gotchas

* macros are evaluated by `autoreconf` and friends, not by the generated `configure` script itself
* if a macro is “unknown”, either vendor it or ensure the host providing `autoreconf` has `autoconf-archive` installed and on `aclocal`’s path
* prefer `AC_CONFIG_MACRO_DIRS([m4])` over legacy `ACLOCAL_AMFLAGS`, and pass `-I m4` to `aclocal`/`autoreconf` when regenerating
* the macros carry a special GPL exception allowing generated `configure` scripts to be used under any license
