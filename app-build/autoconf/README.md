# GNU Autoconf — Commands & Usage 

Autoconf generates portable `configure` scripts from `configure.ac` so source trees adapt to many UNIX-like systems without requiring Autoconf on end users’ machines

## Commands included

- `autoconf`
- `autoheader`
- `autom4te`
- `autoreconf`
- `autoscan`
- `autoupdate`
- `ifnames`

> For full reference, see the GNU Autoconf manual and man pages

---

## Common warning controls

Many tools accept `-W, --warnings=CATEGORY` where CATEGORY is one or more of:

`cross`, `gnu`, `obsolete`, `override`, `portability`, `portability-recursive`, `extra-portability`, `syntax`, `unsupported`, plus meta values `all`, `none`, `no-<CATEGORY>`, `error`

Most tools also accept `-B, --prepend-include=DIR` and `-I, --include=DIR` to adjust macro search paths

---

## `autoconf`

**Synopsis**

```

autoconf [OPTION]... [TEMPLATE-FILE]

```

**What it does**

- Generates a `configure` script from the given template, or from `configure.ac` if present, else `configure.in`
- Writes to stdout if a template file is provided, otherwise to `./configure`

**Useful options**

- `-o, --output=FILE` save output to FILE
- `-v, --verbose` verbose processing
- `-f, --force` consider all files obsolete
- `-W, --warnings=CATEGORY` control warnings
- `-t, --trace=MACRO[:FORMAT]` list calls to a macro
- `-i, --initialization` include Autoconf initialization in traces

> Manual reference: Autoconf overview and invocation

---

## `autoheader`

**Synopsis**

```

autoheader [OPTION]... [TEMPLATE-FILE]

```

**What it does**

- Scans `configure.ac` (or template) and produces/updates `config.h.in`, a template header of `#define` results used by `configure`

**Useful options**

- Same core flags as `autoconf` including `-v`, `-f`, `-W`, `-B`, `-I`

> Manual reference: Autoheader overview 

---

## `autom4te`

**Synopsis**

```

autom4te [OPTION]... [FILES]

```

**What it does**

- Wrapper around GNU M4 used by the Autoconf suite
- Runs M4 on input files, supports tracing and frozen state files, and can target “languages” like Autoconf, Autotest, M4sh, M4sugar

**Useful options**

- `-l, --language=LANG` choose macro set (Autoconf, Autotest, M4sh, M4sugar)
- `-C, --cache=DIR` cache results, `--no-cache` disables cache
- `-F, --freeze` produce an M4 frozen state file
- `-t, --trace=MACRO[:FORMAT]` report macro invocations
- Honors env vars `M4` and `WARNINGS`
- Default trace `FORMAT` is `'$f:$l:$n:$%'`

> Manual reference: Using/Invoking autom4te and tracing details
---

## `autoreconf`

**Synopsis**

```

autoreconf [OPTION]... [DIRECTORY]...

```

**What it does**

- Re-runs `autoconf`, `autoheader`, and when needed `aclocal`, `automake`, `libtoolize`, `autopoint`, etc, to refresh build system files recursively

**Useful options**

- `-i, --install` copy missing auxiliary files
- `-s, --symlink` with `-i`, install symlinks instead of copies
- `-m, --make` when applicable, re-run `./configure && make`
- `-f, --force` remake all generated/standard files
- Honors env vars `AUTOCONF`, `ACLOCAL`, `AUTOHEADER`, `AUTOM4TE`, `AUTOMAKE`, `AUTOPOINT`, `GTKDOCIZE`, `INTLTOOLIZE`, `LIBTOOLIZE`, `M4`, `MAKE`, `WARNINGS`

> Manual reference: autoreconf invocation and behavior 

---

## `autoscan`

**Synopsis**

```

autoscan [OPTION]... [SRCDIR]

```

**What it does**

- Scans sources for portability issues and produces `configure.scan`, a starter `configure.ac` for your package

> Manual reference: autoscan invocation and output 

---

## `autoupdate`

**Synopsis**

```

autoupdate [OPTION]... [TEMPLATE-FILE]...

```

**What it does**

- Updates `configure.ac`/`configure.in` to current macro names and backs up originals

> Manual reference: autoupdate invocation and purpose 

---

## `ifnames`

**Synopsis**

```

ifnames [OPTION]... [FILE]...

````

**What it does**

- Prints identifiers used in `#if`, `#elif`, `#ifdef`, `#ifndef` across C sources to help decide what to test in `configure.ac`

> See also the Autoconf manual’s cross-references and local man pages

---

## Quick start workflow

```sh
# in a project with configure.ac
autoreconf -fi        # install missing aux files and regenerate

./configure           # probe the build environment and generate outputs
make                  # build the project
````

```m4
dnl minimal configure.ac
AC_INIT([mypkg], [1.0], [bugs@example.com])    dnl package metadata
AC_CONFIG_SRCDIR([src/main.c])                 dnl verify we're in the right tree
AC_PROG_CC                                     dnl find a C compiler
AC_CONFIG_HEADERS([config.h])                  dnl enable config header generation
AC_OUTPUT([Makefile])                          dnl files to produce
```

tips

* use `-Werror` via `-W error` to treat enabled warnings as errors when iterating on `configure.ac`
* use `autom4te -t AC_DEFUN` or similar to trace macro calls during debugging
* pass `-B`/`-I` to point at extra macro directories when experimenting with custom `.m4` files

---

## Further reading

* GNU Autoconf manual (web and `info`) ([GNU][1])
* Local man pages such as `man autoconf`, `man autoreconf`, etc ([Arch Linux Manual Pages][2])

