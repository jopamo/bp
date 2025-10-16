# GNU Binutils — Usage & Quick Reference

Binutils is a collection of tools for inspecting, modifying, and linking object files, archives, and executables on UNIX-like systems

## What this package provides

binaries

- `addr2line` map addresses to file:line using debug info  
- `ar` create and modify static archives `.a`  
- `as` the GNU assembler  
- `c++filt` demangle C++ symbol names  
- `elfedit` inspect or edit ELF headers and note sections  
- `gprof` profile data reporting for code instrumented with `-pg`  
- `ld` the GNU linker (symlinked to `ld.bfd` here)  
- `nm` list symbols in object files  
- `objcopy` copy and transform object files and sections  
- `objdump` disassemble and dump object file details  
- `ranlib` generate symbol index for an archive  
- `readelf` display ELF-specific information  
- `size` report text/data/bss sizes by section  
- `strings` print printable strings in binaries  
- `strip` remove symbols or debug info

target-prefixed symlinks

- `x86_64-pc-linux-gnu-*` helpers point to the same tools and are convenient when cross-building

headers and libraries for tool authors

- headers under `/usr/include` such as `bfd.h`, `dis-asm.h`, `plugin-api.h`  
- libraries such as `libbfd`, `libopcodes`, `libctf`, `libsframe`  
- BFD plugins directory at `/usr/lib/bfd-plugins`

linker scripts

- platform scripts under `/usr/x86_64-pc-linux-gnu/lib/ldscripts` for common ELF targets

manuals

- info pages for binutils, bfd, ld, gprof, CTF, SFrame

---

## Everyday tasks

### inspect an ELF quickly

```sh
readelf -hW a.out            # ELF header summary
readelf -lW a.out            # program headers
readelf -SW a.out            # section headers
readelf -sW a.out | less     # symbol table
````

### disassemble and mix with source

```sh
objdump -d -Mintel -S a.out  # disassemble with interleaved source using Intel syntax
objdump -t a.out             # symbol table via objdump
```

### find what function an address belongs to

```sh
addr2line -e a.out 0x40123a  # outputs file:line if debug info is present
```

### list printable strings for quick triage

```sh
strings -n 4 a.out | less    # minimum length 4
```

### see section sizes and total footprint

```sh
size a.out                   # text, data, bss sizes and totals
```

### demangle C++ symbols

```sh
echo _ZN3Foo3barEv | c++filt    # prints Foo::bar()
```

### manage static archives

```sh
ar rcs libmylib.a file1.o file2.o  # create or replace objects and write index
ranlib libmylib.a                  # regenerate archive index if needed
```

### strip or split debug info

```sh
# remove all symbols and debug info to reduce size
strip a.out

# split debug info for separate packages
objcopy --only-keep-debug a.out a.out.debug
strip --strip-debug a.out
objcopy --add-gnu-debuglink=a.out.debug a.out
```

### copy or remove sections

```sh
objcopy -O binary -j .text a.out text.bin  # extract only the .text section
objcopy --remove-section=.comment a.out    # drop an unwanted section
```

### peek relocations and dynamic linking state

```sh
readelf -rW a.out              # relocations
readelf -dW a.out              # .dynamic entries
readelf -nW a.out              # notes
```

---

## Linker and scripts

`ld` combines objects and archives, applies relocations, and resolves symbols. Most builds drive it via the compiler driver `cc` or `c++`

```sh
# link with an explicit script
ld -o app -T linker.ld foo.o bar.o -lc -dynamic-linker /lib64/ld-linux-x86-64.so.2
```

minimal linker script template

```ld
/* linker.ld */
ENTRY(_start)                 /* program entry symbol */
SECTIONS
{
  . = 0x400000;               /* load address */
  .text : { *(.text .text.*) } 
  .rodata : { *(.rodata .rodata.*) }
  .data : { *(.data .data.*) }
  .bss : { *(.bss .bss.* COMMON) }
}
```

tips

* prefer letting `cc` or `c++` invoke the linker so it supplies the right startup objects and libraries
* use a custom script only when you need explicit control over layout, memory regions, or section placement

---

## Reading SFrame and CTF metadata

* SFrame is a compact call frame format aimed at fast, low-overhead stack unwinding
* CTF is a compact C type information format for tooling and debugging
* both have info manuals installed with binutils and can appear in modern toolchains

---

## `gprof` in one minute

```sh
# build with profiling instrumentation
cc -pg -O2 -o demo demo.c

# run the program to generate gmon.out
./demo

# create a report
gprof ./demo gmon.out > report.txt
```

---

## Quick cheat sheet by tool

```sh
nm -an a.o                     # all symbols with numeric sort
objdump -D a.out | less        # disassemble all sections
objdump -T a.out               # dynamic symbol table for shared objects
readelf -sW lib.so | c++filt   # demangle the dynamic symbol table
objcopy -R .comment a.out b    # remove a section during copy
strip --strip-unneeded lib.so  # remove unneeded symbols from a shared object
size -Ax a.out                 # section sizes in hex for each section
c++filt -n _Z3foov            # demangle without stripping leading underscores
elfedit --output-osabi linux a.out  # tweak an ELF header field
```

---

## Notes

* the target-prefixed variants (like `x86_64-pc-linux-gnu-objdump`) are the same tools bound to a specific target triple, useful for cross workflows
* for deep binary tooling, the `bfd` and `opcodes` libraries provide programmatic access to object formats and disassembly

# quick purposes

* `addr2line` — turn code addresses into file:line and function names
* `ar` — create/update/list/extract static libraries `.a`
* `as` — the GNU assembler for `.s`/`.S` to `.o`
* `ld` — the linker (usually invoked via `cc`/`c++`)
* `ranlib` — build the symbol index inside an archive `.a`
* `strings` — print printable strings from binaries
* `nm` — list symbols in object files, archives, and DSOs
* `objdump` — disassemble, dump headers, DWARF, relocs, etc
* `readelf` — ELF-specific headers, sections, symbols, relocs
* `objcopy` — copy/transform objects, strip/keep/rename sections
* `strip` — remove symbols/sections to shrink binaries
* `size` — show section sizes and totals
* `c++filt` — demangle C++/Rust/D mangled names
* `elfedit` — edit ELF header fields and x86 features flags

---

## high-signal options by tool

### addr2line

* `-e FILE` choose executable/DSO
* `-f` show function names
* `-C` demangle
* `-i` unwind inlines
* `-j .SECTION` treat addrs as section-relative

**examples**

```bash
addr2line -e ./app -fC 0x55a8c2d6a9bf
addr2line -e ./app -fC -j .text 0x1234
```

### ar / ranlib

* create/replace: `ar rcs libfoo.a foo.o bar.o`
* list verbose: `ar tv libfoo.a`
* extract: `ar x libfoo.a file.o`
* thin archives: `ar rc --thin libfoo.a a.o b.o`
* update index: `ranlib libfoo.a`

### as

* DWARF5: `--gdwarf-5`
* 32/64-bit: `--32` `--64`
* ISA tuning: `-march=znver5` `-mtune=generic64`

**example**

```bash
as --64 --gdwarf-5 -o foo.o foo.S
```

### ld

use your compiler when possible, but for raw `ld`:

* dead-code elimination: `--gc-sections`
* map file: `-Map out.map`
* PIE/RELRO/NOW: `-pie -z relro -z now`
* rpaths: `-rpath $ORIGIN/lib -rpath-link ./lib`
* script: `-T link.ld`
* version script: `--version-script versions.map`

**example**

```bash
ld -o app crt1.o a.o b.o -L./lib -lfoo \
   --gc-sections -Map app.map -pie -z relro -z now
```

### strings

* min length: `-n 6` (or `--bytes=6`)
* print file names: `-f`
* offset radix: `-t x`
* encoding: `-e l` for UTF-16LE scanning

**example**

```bash
strings -f -n 6 -t x ./libfoo.so | less
```

### nm

* demangle and sizes: `-C -S`
* sort by size: `--size-sort`
* defined/undefined only: `-U` / `-u`
* dynamic symbols: `-D`
* line numbers if DWARF: `-l`

**examples**

```bash
nm -AnCS --size-sort libfoo.a | c++filt
nm -D --defined-only ./libfoo.so
```

### objdump

* disassemble with symbols: `-d -r -w -C`
* Intel syntax x86-64: `-M x86-64,intel`
* include source if DWARF: `-S`
* headers: `-x` or `-h -p`
* DWARF chooser: `-Wl` `-Wi` etc

**examples**

```bash
objdump -drwC -M x86-64,intel ./app | less
objdump -d -j .text -M intel ./obj.o
objdump -T ./libfoo.so      # dynamic symbols
objdump -R ./libfoo.so      # dynamic relocs
```

### readelf

* common overview: `-hSWl`
* dynamic info/relocs: `-d -r -V`
* symbols: `--syms` `--dyn-syms`
* notes: `-n`
* section contents: `-x .rodata` or `-p .rodata` for strings

**examples**

```bash
readelf -hSWl ./app
readelf --dyn-syms -r -d ./libfoo.so
readelf -n ./app             # .note.gnu.build-id etc
```

### objcopy

* keep only debug: `--only-keep-debug`
* add debuglink: `--add-gnu-debuglink=FILE`
* strip debug: `-g` or `--strip-debug`
* extract a section: `-O binary -j .text`
* binary ↔ object: `-I binary -O elf64-x86-64 -B i386:x86-64`

**recipes**

```bash
# split debug
objcopy --only-keep-debug app app.debug
strip --strip-unneeded app
objcopy --add-gnu-debuglink=app.debug app

# extract .text to raw
objcopy -O binary -j .text app text.bin

# embed raw firmware as object
objcopy -I binary -O elf64-x86-64 -B i386:x86-64 fw.bin fw.o
```

### strip

* everything: `-s`
* only debug: `-g` / `-S`
* keep selected: `-K sym` `--keep-section=.gnu_debugdata`
* output file: `-o out`

**example**

```bash
strip --strip-unneeded -o app.stripped app
```

### size

```bash
size -A -x ./app
size -t *.o                 # show totals Berkeley format
```

### c++filt

```bash
c++filt _ZN3foo3barEv
nm a.o | c++filt
```

### elfedit

```bash
elfedit --enable-x86-feature shstk app
elfedit --output-type dyn libfoo.so    # change e_type if you know what you’re doing
```

---

## common mini-cookbook

```bash
# symbolize a crash address from /proc/self/maps
addr2line -e ./app -fC 0x55a8c2d6a9bf

# see what pulled into your ELF and where it goes
readelf -d -r -V -A ./app

# list exported API from a DSO
objdump -T ./libfoo.so | c++filt | awk '$4 ~ /FUNC|OBJECT/'

# disassemble with Intel syntax and show relocs inline
objdump -drwC -M x86-64,intel ./app | less

# show only undefined symbols in an object or static lib
nm -u ./obj.o
nm -u libfoo.a

# verify execstack and RWX segments
readelf -lW ./app | grep -E 'GNU_STACK|R..W.X'

# get section sizes sorted
size -A ./app | sort -k2,2nr

# carve out a single section from an object
objcopy -O binary -j .rodata obj.o rodata.bin
```

---

## paste-friendly wrapper so outputs are clearly labeled

```bash
#!/usr/bin/env bash
set -euo pipefail

# print a bold header then indent command output for clean pastes
banner() {
  local msg="$1"
  printf '\n\033[1m=== %s ===\033[0m\n' "$msg"
}

show() {
  local cmd="$*"
  banner "$cmd"
  eval "$cmd" | sed 's/^/    /'
}

# examples
# show 'addr2line --help'
# show 'objdump -drwC -M x86-64,intel ./app'
# show 'readelf -hSWl ./app'

# run all --help like what you pasted
all_helps() {
  local tools=(addr2line ar as ld ranlib strings nm objdump readelf objcopy strip size c++filt elfedit)
  for t in "${tools[@]}"; do
    show "$t --help"
  done
}

# all_helps
```

* comments have no trailing periods per your style
* use `show 'tool --help'` so the paste shows a bold header like `=== objdump --help ===` and the output indented underneath

---

## handy aliases

```bash
alias dis='objdump -drwC -M x86-64,intel'      # x86-64 disassembly quick view
alias reh='readelf -hSWl'                       # ELF overview
alias dyn='readelf -d -r -V'                    # dynamic deps, relocs, vers
alias syms='nm -AnCS --size-sort | c++filt'     # sorted symbol sizes
```

