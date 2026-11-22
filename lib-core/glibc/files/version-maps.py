# SPDX-License-Identifier: LGPL-2.1-or-later
# Based on glibc scripts/versions.awk and scripts/versionlist.awk.
# Copyright (C) 1998-2026 Free Software Foundation, Inc.
"""Generate glibc Versions.def or the linker maps and matching headers."""
import argparse
import filecmp
import itertools
import os
from pathlib import Path
import re
import subprocess
import tempfile


def version_sort(lines, unique=False):
    # Preserve the linker's input order, including numeric minor versions
    # and the blank before GLIBC_ which puts those versions first.
    args = ['sort', '-t.', '-k1,1', '-k2n,2n', '-k3']
    data = ''.join(line + '\n' for line in lines)
    return subprocess.run(args + (['-u'] if unique else []), input=data,
                          stdout=subprocess.PIPE, check=True, text=True,
                          env=dict(os.environ, LC_ALL='C')).stdout.splitlines()


def definitions(lines):
    libs, versions = set(), set()
    lib = version = None
    for line in lines:
        fields = line.split()
        if not fields:
            continue
        if len(fields) == 2 and fields[1] == '{':
            if lib is None:
                lib = fields[0]
                libs.add(lib)
            else:
                version = fields[0]
                versions.add(version)
        elif fields[0] == '}':
            if version is None:
                lib = None
            version = None
    ordered = []
    for glibc in (True, False):
        ordered.extend(version_sort(('  ' + v for v in versions
                                     if ('GLIBC_' in v) == glibc), unique=True))
    for lib in sorted(libs):
        print(lib, '{')
        for version in ordered:
            print(version)
        print('}')


def elf_hash(name):
    value = 0
    for byte in name.encode('ascii'):
        value = (value << 4) + byte
        value = (value ^ ((value & 0xf0000000) >> 24)) & 0xfffffff
    return value


def maps(lines, defs, dest):
    aliases = {}
    for line in defs:
        fields = line.split()
        if fields[1:] == ['{']:
            lib = fields[0]
            aliases[lib] = {}
        elif fields and fields[0] != '}':
            aliases[lib][fields[0]] = fields[-1]

    rows = []
    pre_versions = False
    for line in lines:
        if line.lstrip().startswith('#') or not line.strip():
            continue
        name = line.split()[0]
        if name == '!libc_pre_versions':
            pre_versions = True
        elif re.match(r'[a-zA-Z0-9_.]', line):
            lib = name
            if lib not in aliases:
                raise ValueError('no versions defined for ' + lib)
        elif re.match('  [A-Za-z_]', line):
            version = aliases[lib].get(name, name if name == 'GLIBC_PRIVATE' else None)
            if version is None:
                raise ValueError('version %s not defined for %s' % (name, lib))
        elif line.startswith('   '):
            rows.append(lib + ('  ' if version.startswith('GLIBC_') else ' ')
                        + version + ' ' + line.rstrip('\n'))

    first = ['#ifndef _FIRST_VERSIONS_H', '#define _FIRST_VERSIONS_H']
    ldbl = ['#ifndef _LDBL_COMPAT_CHOOSE_H', '#define _LDBL_COMPAT_CHOOSE_H',
            '#ifndef LONG_DOUBLE_COMPAT', '# error LONG_DOUBLE_COMPAT not defined', '#endif']
    seen, names = set(), []
    with tempfile.TemporaryDirectory(dir=dest) as tmp:
        stage = Path(tmp)
        tokens = (row.split() for row in version_sort(rows))
        for lib, library in itertools.groupby(tokens, key=lambda row: row[0]):
            name = lib + '.map'
            names.append(name)
            previous = ''
            with (stage / name).open('w') as out:
                if lib == 'libc' and pre_versions:
                    out.write('GLIBC_2.0 {\n};\nGLIBC_2.1 {\n} GLIBC_2.0;\n')
                    previous = 'GLIBC_2.1'
                for ver, group in itertools.groupby(library, key=lambda row: row[1]):
                    out.write(ver + ' {\n')
                    for index, row in enumerate(group):
                        if index == 0:
                            if row[2] == '__placeholder_only_for_empty_version_map;':
                                continue
                            out.write('  global:\n')
                        out.write('    ' + ' '.join(row[2:]) + '\n')
                        for symbol in row[2:]:
                            sym = symbol.replace(';', '', 1)
                            macro = 'FIRST_VERSION_' + lib + '_' + sym
                            if (macro in seen or not re.match('GLIBC_[0-9]', ver)
                                    or not re.fullmatch('[A-Za-z0-9_]*', sym)):
                                continue
                            seen.add(macro)
                            val = ver.replace('.', '_')
                            first.extend(['#define %s_STRING "%s"' % (macro, ver),
                                          '#define %s_HASH 0x%x' % (macro, elf_hash(ver)),
                                          '#define %s %s' % (macro, val)])
                            if lib in ('libc', 'libm'):
                                choose = 'LONG_DOUBLE_COMPAT_CHOOSE_' + lib + '_' + sym
                                ldbl.extend(['#if LONG_DOUBLE_COMPAT (%s, %s)' % (lib, val),
                                             '# define %s(a, b) a' % choose, '#else',
                                             '# define %s(a, b) b' % choose, '#endif'])
                    prefix = re.sub('[0-9.]+', '.+', previous, count=1)
                    parent = ' ' + previous if previous and re.search(prefix, ver) else ''
                    out.write('  local:\n    *;\n}' + parent + ';\n')
                    previous = ver
        for name, header in [('first-versions.h', first), ('ldbl-compat-choose.h', ldbl)]:
            header.append('#endif /* %s */' % name)
            (stage / name).write_text('\n'.join(header) + '\n')
        for source in stage.iterdir():
            target = dest / source.name
            if not target.exists() or not filecmp.cmp(source, target, shallow=False):
                os.replace(source, target)
    print('version-maps =', *names)


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--maps', nargs=2, metavar=('DEFS', 'BUILDDIR'))
    parser.add_argument('versions', type=argparse.FileType('r'))
    args = parser.parse_args()
    if args.maps:
        with open(args.maps[0]) as defs:
            maps(args.versions, defs, Path(args.maps[1]))
    else:
        definitions(args.versions)
