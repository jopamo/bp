# GNU Automake — Usage & Quick Reference

Automake generates portable `Makefile.in` templates from `Makefile.am` so projects follow GNU makefile conventions with less boilerplate

## What this package provides

- Binaries: `automake`, `aclocal` (also versioned wrappers like `automake-1.xx`, `aclocal-1.xx`)
- Macro dirs: `/usr/share/aclocal`, plus a versioned symlink like `/usr/share/aclocal-1.xx -> aclocal`
- Automake `.am` snippets under `/usr/share/automake/am/` used to build standard targets
- Helper and fallback scripts typically copied into your tree when missing: `compile`, `depcomp`, `install-sh`, `missing`, `py-compile`, `ar-lib`, `ylwrap`, `test-driver`, `tap-driver.sh`, `config.guess`, `config.sub`
- Manuals: `automake.info*`, `automake-history.info*`
- Man pages: `automake(1)`, `aclocal(1)`

---

## Typical workflow

```sh
# one-time bootstrap on a fresh clone
autoreconf -fi         # runs aclocal, automake, autoconf, etc and adds missing aux files

# configure, build, test
./configure
make
make check
make distcheck         # verify a release tarball builds & tests cleanly
````

tips

* run `autoreconf -I m4` if you vendor custom macros under `m4`
* when using libtool, run `libtoolize` before `autoreconf -fi` if needed

---

## `Makefile.am` essentials

```make
# declare programs or libraries to build
bin_PROGRAMS = hello
hello_SOURCES = src/hello.c src/util.c

# per-target flags
hello_CPPFLAGS = -DPROJECT_NAME=\"hello\"
hello_CFLAGS   = -O2
hello_LDADD    = libmylib.a

# install headers
include_HEADERS = include/hello.h

# recurse into subdirs in this order
SUBDIRS = lib src tests

# optional: make object files live next to their sources
AUTOMAKE_OPTIONS = subdir-objects
```

notes

* primaries like `bin_PROGRAMS`, `lib_LTLIBRARIES`, `noinst_HEADERS`, `check_PROGRAMS` drive rule generation
* `*_SOURCES`, `*_LDADD`, `*_LDFLAGS`, `AM_CPPFLAGS`, `AM_CFLAGS` fine-tune builds
* `SUBDIRS` controls recursive build order

---

## `aclocal` and macro paths

```m4
dnl in configure.ac, advertise where your local macros live
AC_CONFIG_MACRO_DIRS([m4])
AM_INIT_AUTOMAKE([foreign subdir-objects])  dnl pick options for tarball layout & object placement
```

```sh
# when regenerating, include your macro dir
autoreconf -fi -I m4
```

notes

* `aclocal` scans `configure.ac` and assembles `aclocal.m4` from system and local `.m4` macros
* prefer `AC_CONFIG_MACRO_DIRS([m4])` over legacy `ACLOCAL_AMFLAGS`

---

## Test suites with the parallel harness

The default `make check` uses Automake’s parallel test harness

```make
# simplest form: run these executables as tests
TESTS = t/unit_math t/unit_io

# build test binaries only for "make check"
check_PROGRAMS = t/unit_math t/unit_io
t_unit_math_SOURCES = tests/unit_math.c
t_unit_io_SOURCES   = tests/unit_io.c
```

Wrap tests or use custom drivers

```make
# run all tests through a wrapper
LOG_COMPILER = ./scripts/test-wrap.sh
AM_LOG_FLAGS = --color --jobs=$(CHECK_JOBS)

# use extension-specific drivers
TESTS = t/foo.t t/bar.t
TEST_EXTENSIONS = .t
t_LOG_COMPILER = /usr/bin/perl
```

Use TAP

```make
# include the TAP driver script in your tree if not already present
EXTRA_DIST = build-aux/tap-driver.sh

TESTS = t/basic.t t/cli.t
TEST_EXTENSIONS = .t
LOG_DRIVER = $(srcdir)/build-aux/tap-driver.sh
LOG_COMPILER = /usr/bin/perl
```

env

* `AM_TESTS_ENVIRONMENT` lets you export env vars or source a `tests-env.sh` before each test
* set `VERBOSE=1` to show failing logs inline

---

## Helper scripts you’ll see

* `install-sh` portable installer used when `mkdir -p` etc aren’t reliable on all targets
* `depcomp` dependency tracking helper for compilers lacking suitable flags
* `missing` wrapper that lets `make` continue when tools like `help2man` are absent during maintainer builds
* `test-driver` default test runner used by the parallel harness
* `tap-driver.sh` helper for TAP protocol tests
* `config.guess` / `config.sub` canonical system type detection used by `configure` scripts

These are copied into your source tree by `autoreconf -fi` or `automake --add-missing` so releases don’t require Automake at build time

---

## Minimal example

```m4
dnl configure.ac
AC_INIT([mypkg], [1.0], [bugs@example.com])
AM_INIT_AUTOMAKE([foreign subdir-objects])
AC_CONFIG_SRCDIR([src/main.c])
AC_CONFIG_HEADERS([config.h])
AC_PROG_CC
AC_OUTPUT([Makefile src/Makefile tests/Makefile])
```

```make
# Makefile.am at top-level
SUBDIRS = src tests
dist_doc_DATA = README.md LICENSE
```

```make
# src/Makefile.am
bin_PROGRAMS = mypkg
mypkg_SOURCES = main.c util.c
```

```make
# tests/Makefile.am
check_PROGRAMS = t_sample
t_sample_SOURCES = t_sample.c
TESTS = t_sample
```

```sh
autoreconf -fi
./configure
make
make check
```

---

## Common pitfalls

* “`aclocal-1.xx is missing`”: you’re regenerating with a different Automake major.minor than the project expects; install the matching Automake or rebootstrap to current and commit refreshed helper files
* “missing `INSTALL`, `test-driver`, `install-sh`”: regenerate with `autoreconf -fi` or `automake --add-missing`
* vendor macros you rely on so CI and contributors don’t need extra packages on the host

