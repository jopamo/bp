# flex quick reference

## what you have

* `flex`, `flex++` symlink, `lex` symlink
* headers: `/usr/include/FlexLexer.h` for C++
* pkg-config: `libfl.pc` for `-lfl`

## flags you’ll actually use

* output & naming: `-o file.c` `--header-file=file.h` `-P myyy`
* modes: `-I` interactive stdin, `-B` batch
* perf tables: `-f` or `-F` big fast tables, `-Cem` default compression
* scanner style: `--reentrant` `--bison-bridge` `--bison-locations`
* C++: `-+` or `--c++` with `FlexLexer.h`
* behavior: `-s` nodefault, `-l` lex-compat, `-X` posix-compat, `--yylineno`
* debug: `-d` `-b` `-p` `-v` `-T`

## %option equivalents inside .l

```lex
%option reentrant bison-bridge bison-locations
%option noyywrap nodefault nounput noinput
%option yylineno
%option 8bit
```

## reentrant API cheatsheet

* type: `yyscan_t scanner`
* init: `yylex_init(&scanner)` or `yylex_init_extra(void *extra, &scanner)`
* set input: `yyset_in(FILE *f, scanner)`
* run: `yylex(scanner)` or, with bison-bridge, bison will call `yylex(YYSTYPE*, YYLTYPE*, scanner)`
* destroy: `yylex_destroy(scanner)`
* extras: `yyget_text(scanner)` `yyget_leng(scanner)` `yyget_lineno(scanner)` `yyget_extra(scanner)`

---

# complete minimal C example: Flex + Bison, reentrant, with locations

## parser.y

```yacc
%{
#include <stdio.h>
#include <stdlib.h>
%}

/* reentrant, pure parser with locations */
%define api.pure full
%locations
%define parse.error verbose

/* expose tokens and YYSTYPE to the scanner */
%defines "parser.h"

/* pass the scanner handle into yyparse */
%parse-param { yyscan_t scanner }

%union {
  int ival;
}

%token <ival> NUM
%type  <ival> expr

%%

input:
    /* empty */
  | input expr '\n'        { printf("%d\n", $2); }
  ;

expr:
    NUM                    { $$ = $1; }
  | expr '+' expr          { $$ = $1 + $3; }
  | '(' expr ')'           { $$ = $2; }
  ;

%%

/* error hook */
void yyerror(YYLTYPE *loc, yyscan_t scanner, const char* msg) {
  fprintf(stderr, "parse error at %d.%d-%d.%d: %s\n",
          loc->first_line, loc->first_column, loc->last_line, loc->last_column, msg);
}
```

## lexer.l

```lex
%option reentrant bison-bridge bison-locations
%option noyywrap nodefault nounput noinput
%option yylineno 8bit

%{
#include <ctype.h>
#include <stdlib.h>
#include "parser.h"     /* tokens, YYSTYPE, YYLTYPE */

/* declare yylex signature explicitly to keep it obvious */
#define YY_DECL int yylex(YYSTYPE* yylval, YYLTYPE* yylloc, yyscan_t scanner)
%}

/* simple location tracking */
%%

[0-9]+      {
               yylval->ival = atoi(yytext);
               return NUM;
            }

"+"         { return '+'; }
"("         { return '('; }
")"         { return ')'; }

[ \t\r]+    { /* skip spaces */ }
\n          { return '\n'; }

/* unknown byte -> return it as a char token so parser can complain */
.           { return yytext[0]; }

%%
```

## main.c

```c
#include <stdio.h>
#include "parser.h"
#include "yy/lexer.h"   /* if you emit a header via --header-file, see build below */

/* declare the reentrant API since we used --reentrant */
int yylex(YYSTYPE* yylval, YYLTYPE* yylloc, yyscan_t scanner);
int yyparse(yyscan_t scanner);

int main(void) {
  yyscan_t scanner;
  yylex_init(&scanner);           /* allocate scanner state */
  yyset_in(stdin, scanner);       /* default input */
  int rc = yyparse(scanner);      /* run parser */
  yylex_destroy(scanner);         /* free scanner state */
  return rc ? 1 : 0;
}
```

## build it

### Meson

```meson
project('flex_bison_demo', 'c', default_options: ['c_std=c11','warning_level=2'])

bison = find_program('bison')
flex  = find_program('flex')

# bison → parser.c + parser.h
parser = custom_target(
  'parser',
  input: 'parser.y',
  output: ['parser.c', 'parser.h'],
  command: [bison, '-d', '-o', '@OUTPUT0@', '@INPUT@'],
  build_always_stale: true
)

# flex → lexer.c + header
lexer = custom_target(
  'lexer',
  input: 'lexer.l',
  output: ['lexer.c', 'lexer.h'],
  command: [flex, '--reentrant', '--bison-bridge', '--bison-locations',
            '--header-file=@OUTPUT1@', '-o', '@OUTPUT0@', '@INPUT@'],
  build_always_stale: true
)

exe = executable('calc', ['main.c', parser, lexer], link_with: [], link_args: ['-lfl'])
install_targets(exe)
```

### CMake

```cmake
cmake_minimum_required(VERSION 3.20)
project(flex_bison_demo C)

find_program(BISON_EXECUTABLE bison)
find_program(FLEX_EXECUTABLE flex)

add_custom_command(
  OUTPUT ${CMAKE_BINARY_DIR}/parser.c ${CMAKE_BINARY_DIR}/parser.h
  COMMAND ${BISON_EXECUTABLE} -d -o ${CMAKE_BINARY_DIR}/parser.c ${CMAKE_SOURCE_DIR}/parser.y
  DEPENDS ${CMAKE_SOURCE_DIR}/parser.y
  COMMENT "bison parser"
)

add_custom_command(
  OUTPUT ${CMAKE_BINARY_DIR}/lexer.c ${CMAKE_BINARY_DIR}/lexer.h
  COMMAND ${FLEX_EXECUTABLE}
          --reentrant --bison-bridge --bison-locations
          --header-file=${CMAKE_BINARY_DIR}/lexer.h
          -o ${CMAKE_BINARY_DIR}/lexer.c
          ${CMAKE_SOURCE_DIR}/lexer.l
  DEPENDS ${CMAKE_SOURCE_DIR}/lexer.l ${CMAKE_BINARY_DIR}/parser.h
  COMMENT "flex lexer"
)

add_executable(calc main.c ${CMAKE_BINARY_DIR}/parser.c ${CMAKE_BINARY_DIR}/lexer.c)
target_include_directories(calc PRIVATE ${CMAKE_BINARY_DIR})
target_link_libraries(calc PRIVATE fl)
```

test

```bash
printf '1+(2+3)\n' | ./calc
```

---

# handy Flex patterns

```lex
%x STR                         /* exclusive start condition */
%%
\"           BEGIN(STR)        /* enter string state */
<STR>\\\"    { /* escaped quote */ }
<STR>\"      { BEGIN(INITIAL); /* end string */ }
<STR>\n      { /* unterminated string error */ }
<STR>.|\n    { /* collect string bytes */ }

yyrestart(yyin, scanner)       /* reset to a new FILE* */
YY_FLUSH_BUFFER                 /* flush current buffer */
yy_scan_string(s, scanner)      /* scan from C string */
yy_delete_buffer(buf, scanner)  /* free buffer after scan */
```

tips

* use `%option nodefault` so unmatched input doesn’t ECHO
* add `%option nounput noinput` to shrink code when you never call `input()`/`unput()`
* flex is byte oriented; for UTF-8 tokens, match byte classes or hand off to a UTF-8 helper
* prefer reentrant scanners to avoid globals and make parsing thread-safe

---

# paste-friendly banner for your helps

```bash
#!/usr/bin/env bash
set -euo pipefail
banner(){ printf '\n\033[1m=== %s ===\033[0m\n' "$*"; }
show(){ banner "$*"; eval "$*" | sed 's/^/    /'; }

show 'flex --help'
show 'bison --help'
show 'yacc --help'
```
