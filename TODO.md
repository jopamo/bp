# Package QA Issues

Generated from pkgcheck results, excluding Checksum errors and some global noise.

## app-build/autoconf-archive
- DoubleEmptyLine: version 2024.10.16: ebuild has unneeded empty line on line: 9

## app-build/gnulib
- MissingRemoteId: missing <remote-id type="savannah">gnulib</remote-id> (inferred from URI 'https://savannah.gnu.org/projects/gnulib')

## app-build/bison
- MissingInherits: version 3.8.2: flag-o-matic: missing inherit usage: 'append-ldflags -static', line 27
- MissingTestRestrict: version 3.8.2: missing RESTRICT="!test? ( test )" with IUSE=test

## app-compression/cpio
- MissingRemoteId: missing <remote-id type="github">1g4-mirror/cpio</remote-id> (inferred from URI 'https://github.com/1g4-mirror/cpio/archive/ef694f7bcc60d2b92e5737e31790791ff4de20f3.tar.gz')
- VariableScope: version 20250529: variable 'EROOT' used in 'src_configure' on line: 48
- VariableScope: version 20250529: variable 'EROOT' used in 'src_prepare' on line: 28

## app-build/texinfo
- DuplicateFunctionDefinition: version 7.2: multiple definitions of function 'src_configure' were found, on lines: 19, 26

## app-compression/bzip2
- MissingRemoteId: missing <remote-id type="github">1g4-mirror/bzip2</remote-id> (inferred from URI 'https://github.com/1g4-mirror/bzip2/archive/af79253677ad98d6dfe11ea315ee9947d86586d3.tar.gz')

## app-build/patch
- MissingRemoteId: missing <remote-id type="github">1g4-mirror/patch</remote-id> (inferred from URI 'https://github.com/1g4-mirror/patch/archive/d161c9a9dbd24bb7e0356e4e07983345777d85aa.tar.gz')
- MissingTestRestrict: version 20250501: missing RESTRICT="!test? ( test )" with IUSE=test
- VariableScope: version 20250501: variable 'EROOT' used in 'src_prepare' on line: 35

## app-compression/lz4
- MissingRemoteId: missing <remote-id type="github">lz4/lz4</remote-id> (inferred from URI 'https://github.com/lz4/lz4')
- MissingTestRestrict: version 20251201: missing RESTRICT="!test? ( test )" with IUSE=test

## app-build/automake
- WhitespaceFound: version 1.18: ebuild has leading whitespace on lines: 37, 38, 39, 40

## app-build/gcc-lib
- MissingRemoteId: missing <remote-id type="github">gcc-mirror/gcc</remote-id> (inferred from URI 'https://github.com/gcc-mirror/gcc/archive/fa27ae247e190b84935151e3fa471a560efd7fdf.tar.gz')
- BadDescription: version 15.2.20251125: over 80 chars in length
- UnknownUseFlags: version 15.2.20251125: unknown USE flags: 'dlang', 'go-bootstrap', 'isl', 'libgomp', 'sanitize'
- WhitespaceFound: version 15.2.20251125: ebuild has leading whitespace on line: 37

## app-compression/unrar
- VariableOrderWrong: version 7.1.5: variable S should occur before KEYWORDS

## app-build/gnuconfig
- MissingRemoteId: missing <remote-id type="github">1g4-mirror/config</remote-id> (inferred from URI 'https://github.com/1g4-mirror/config/archive/a2287c3041a3f2a204eb942e09c015eab00dc7dd.tar.gz')
- MissingRemoteId: missing <remote-id type="savannah">config</remote-id> (inferred from URI 'https://savannah.gnu.org/projects/config')

## app-build/gcc
- MissingRemoteId: missing <remote-id type="github">gcc-mirror/gcc</remote-id> (inferred from URI 'https://github.com/gcc-mirror/gcc/archive/fa27ae247e190b84935151e3fa471a560efd7fdf.tar.gz')
- BadDescription: version 15.2.20251125: over 80 chars in length
- UnknownUseFlags: version 15.2.20251125: unknown USE flags: 'dlang', 'fortran', 'go-bootstrap', 'isl', 'libgomp', 'sanitize'

## app-build/libtool
- UnusedInherits: version 20250918: unused eclass: autotools
- VariableScope: version 20250918: variable 'EROOT' used in 'src_prepare' on line: 39
- VisibleVcsPkg: version 20250918: VCS version visible for KEYWORDS="amd64", profile core/amd64/glibc (16 total)
- WhitespaceFound: version 20250918: ebuild has leading whitespace on line: 19

## app-build/flex
- MissingRemoteId: missing <remote-id type="github">westes/flex</remote-id> (inferred from URI 'https://github.com/westes/flex')
- MissingTestRestrict: version 20200906-r9: missing RESTRICT="!test? ( test )" with IUSE=test
- MissingTestRestrict: version 20250526: missing RESTRICT="!test? ( test )" with IUSE=test

## app-compression/zstd
- MissingRemoteId: missing <remote-id type="github">facebook/zstd</remote-id> (inferred from URI 'https://github.com/facebook/zstd/archive/448cd340879adc0ffe36ed1e26823ee2dcb3217b.tar.gz')

## app-core/attr
- MissingRemoteId: missing <remote-id type="github">1g4-mirror/attr</remote-id> (inferred from URI 'https://github.com/1g4-mirror/attr/archive/4d4a562d7b73dcea8bd4b2d40b8c030d5065111b.tar.gz')
- MissingRemoteId: missing <remote-id type="savannah-nongnu">attr</remote-id> (inferred from URI 'https://savannah.nongnu.org/projects/attr')
- VariableScope: version 20250606: variable 'EROOT' used in 'src_prepare' on line: 31

## app-compression/brotli
- MissingRemoteId: missing <remote-id type="github">google/brotli</remote-id> (inferred from URI 'https://github.com/google/brotli')
- DistutilsNonPEP517Build: version 20251124: uses deprecated non-PEP517 build mode, please switch to DISTUTILS_USE_PEP517=...
- NonexistentDeps: version 20251124: DEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 20251124: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 20251124: nonsolvable depset(depend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 20251124: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 20251124: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 20251124: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## app-compression/7zip
- MissingRemoteId: missing <remote-id type="github">ip7z/7zip</remote-id> (inferred from URI 'https://github.com/ip7z/7zip/archive/5e96a8279489832924056b1fa82f29d5837c9469.tar.gz')
- MissingRemoteId: missing <remote-id type="sourceforge">sevenzip</remote-id> (inferred from URI 'https://sourceforge.net/projects/sevenzip/')
- DoubleEmptyLine: version 20250803: ebuild has unneeded empty line on line: 61
- NonsolvableDepsInStable: version 20250803: nonsolvable depset(bdepend) keyword(arm64) stable profile (core/arm64/glibc) (8 total): solutions: [ app-lang/uasm ]
- UnquotedVariable: version 20250803: unquoted variable S on line: 43
- WhitespaceFound: version 20250803: ebuild has leading whitespace on lines: 19, 20, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 35, 36, 38, 39, 45, 46, 47, 48, 50, 51, 52, 53, 54, 55, 56, 58, 63, 64, 65, 66, 68, 69, 70, 71, 72, 73, 75, 76, 77, 78, 80, 81, 82, 86, 88, 89, 91, 93, 95, 96

## app-core/apparmor-profiles
- MissingRemoteId: missing <remote-id type="gitlab">apparmor/apparmor/wikis/home</remote-id> (inferred from URI 'https://gitlab.com/apparmor/apparmor/wikis/home')
- RedundantUriRename: version 20251202: redundant rename: https://gitlab.com/apparmor/apparmor/-/archive/a7b4b3c726514f4e8bc21536d73c1fd2dcd44313/apparmor-a7b4b3c726514f4e8bc21536d73c1fd2dcd44313.tar.bz2 -> apparmor-a7b4b3c726514f4e8bc21536d73c1fd2dcd44313.tar.bz2

## app-compression/libarchive
- MissingRemoteId: missing <remote-id type="github">libarchive/libarchive</remote-id> (inferred from URI 'https://github.com/libarchive/libarchive/archive/728b43c0c18df60c3e9239fb03c69bd2b1b85ebc.tar.gz')
- UnknownUseFlags: version 20251201: unknown USE flags: 'bsdtar', 'expat', 'nettle'

## app-core/acl
- MissingRemoteId: missing <remote-id type="github">1g4-mirror/acl</remote-id> (inferred from URI 'https://github.com/1g4-mirror/acl/archive/9053e722421454b115e699743a9b0a66808ab756.tar.gz')
- MissingRemoteId: missing <remote-id type="savannah-nongnu">acl</remote-id> (inferred from URI 'https://savannah.nongnu.org/projects/acl')
- VariableScope: version 20250512: variable 'EROOT' used in 'src_prepare' on line: 34

## app-build/binutils
- MissingRemoteId: missing <remote-id type="github">1g4-mirror/binutils-gdb</remote-id> (inferred from URI 'https://github.com/1g4-mirror/binutils-gdb/archive/f58151627fb61483e6e065d8ce1b334280abdf82.tar.gz')
- UnknownUseFlags: version 2.43.20250522: unknown USE flags: 'gprof', 'gprofng'
- UnknownUseFlags: version 2.44.20251031: unknown USE flags: 'gprof', 'gprofng'

## app-compression/libzip
- MissingRemoteId: missing <remote-id type="github">nih-at/libzip</remote-id> (inferred from URI 'https://github.com/nih-at/libzip/archive/a1364389320754b437234c30989e37e1881b4fef.tar.gz')
- UnknownUseFlags: version 20251201: unknown USE flags: 'gnutls', 'mbedtls', 'tools'

## app-core/blktrace
- ExcessiveLineLength: version 20250320: excessive line length (over 120 characters) on line: 24

## app-compression/zip
- MissingRemoteId: missing <remote-id type="sourceforge">infozip</remote-id> (inferred from URI 'https://downloads.sourceforge.net/infozip/zip30.zip')
- MissingUnpackerDep: version 3.0: missing BDEPEND="app-arch/unzip" for SRC_URI archive: [ zip30.zip ]
- NonexistentDeps: version 3.0: DEPEND: nonexistent packages: app-arch/bzip2, dev-libs/libnatspec
- NonexistentDeps: version 3.0: RDEPEND: nonexistent packages: app-arch/bzip2, dev-libs/libnatspec
- NonsolvableDepsInStable: version 3.0: nonsolvable depset(depend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-arch/bzip2, dev-libs/libnatspec ]
- NonsolvableDepsInStable: version 3.0: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-arch/bzip2, dev-libs/libnatspec ]
- UnknownKeywords: version 3.0: unknown KEYWORDS: 'arm', 'ppc', 'ppc64', 'x86', '~alpha', '~amd64-linux', '~hppa', '~loong', '~m68k', '~mips', '~riscv', '~s390', '~sparc', '~x86-linux'
- UnknownUseFlags: version 3.0: unknown USE flag: 'natspec'

## app-core/apparmor
- MissingRemoteId: missing <remote-id type="gitlab">apparmor/apparmor/wikis/home</remote-id> (inferred from URI 'https://gitlab.com/apparmor/apparmor/wikis/home')
- RedundantUriRename: version 20251202: redundant rename: https://gitlab.com/apparmor/apparmor/-/archive/a7b4b3c726514f4e8bc21536d73c1fd2dcd44313/apparmor-a7b4b3c726514f4e8bc21536d73c1fd2dcd44313.tar.bz2 -> apparmor-a7b4b3c726514f4e8bc21536d73c1fd2dcd44313.tar.bz2

## app-core/debianutils
- RedundantUriRename: version 20250727: redundant rename: https://salsa.debian.org/debian/debianutils/-/archive/b999bb0969471d302f1db85e58f17dcb64f274c2/debianutils-b999bb0969471d302f1db85e58f17dcb64f274c2.tar.bz2 -> debianutils-b999bb0969471d302f1db85e58f17dcb64f274c2.tar.bz2
- UnknownUseFlags: version 20250727: unknown USE flags: 'installkernel', 'savelog', 'tempfile'

## app-build/gettext
- MissingRemoteId: missing <remote-id type="github">1g4-mirror/gettext</remote-id> (inferred from URI 'https://github.com/1g4-mirror/gettext/archive/637b208fbe13f1c306f19d4f31c21fec7e9986d2.tar.gz')
- DoubleEmptyLine: version 0.25: ebuild has unneeded empty line on lines: 87, 88
- TrailingEmptyLine: version 0.25: ebuild has trailing blank line(s)
- UnknownUseFlags: version 0.25: unknown USE flag: 'keep-la'
- WhitespaceFound: version 0.25: ebuild has leading whitespace on lines: 62, 64, 65, 67, 68, 69, 72, 73, 74, 75, 76, 79
- DoubleEmptyLine: version 20251111: ebuild has unneeded empty line on lines: 104, 105
- TrailingEmptyLine: version 20251111: ebuild has trailing blank line(s)
- UnknownUseFlags: version 20251111: unknown USE flag: 'keep-la'
- WhitespaceFound: version 20251111: ebuild has leading whitespace on lines: 79, 81, 82, 84, 85, 86, 89, 90, 91, 92, 93, 96
- WhitespaceFound: version 20251111: ebuild has trailing whitespace on line: 36

## app-build/gdb
- MissingRemoteId: missing <remote-id type="github">1g4-mirror/binutils-gdb</remote-id> (inferred from URI 'https://github.com/1g4-mirror/binutils-gdb/archive/025ff2ac593a82520952bbe539edfe5b0931e961.tar.gz')
- MissingTestRestrict: version 17.20251121: missing RESTRICT="!test? ( test )" with IUSE=test
- NonexistentBlocker: version 17.20251121: nonexistent blocker DEPEND="!app-dev/gdbserver": no matches in repo history
- NonexistentBlocker: version 17.20251121: nonexistent blocker RDEPEND="!app-dev/gdbserver": no matches in repo history
- NonexistentDeps: version 17.20251121: DEPEND: nonexistent packages: app-dev/dejagnu, app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 17.20251121: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 17.20251121: nonsolvable depset(depend) keyword(amd64) stable profile (core/amd64/glibc) (8 total): solutions: [ app-dev/dejagnu, app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 17.20251121: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (8 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 17.20251121: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 17.20251121: unknown USE flags: 'client', 'multitarget', 'python_single_target_python3_11', 'python_single_target_python3_12', 'python_single_target_python3_13', 'python_single_target_python3_14', 'server'

## app-core/hwdata
- MissingRemoteId: missing <remote-id type="github">vcrhonek/hwdata</remote-id> (inferred from URI 'https://github.com/vcrhonek/hwdata')

## app-core/bash
- MissingRemoteId: missing <remote-id type="github">1g4-mirror/bash</remote-id> (inferred from URI 'https://github.com/1g4-mirror/bash/archive/a8a1c2fac029404d3f42cd39f5a20f24b6e4fe4b.tar.gz')
- UnquotedVariable: version 20250729: unquoted variable EPREFIX on lines: 49, 50, 51, 52
- UnusedInherits: version 20250729: unused eclass: toolchain-funcs

## app-core/gentoo-functions
- MissingRemoteId: missing <remote-id type="github">gentoo/gentoo-functions</remote-id> (inferred from URI 'https://github.com/gentoo/gentoo-functions/archive/ff1c7dffd8d121d54f903babd1c8afc41b0e78df.tar.gz')
- BadHomepage: version 20251014: unspecific HOMEPAGE: https://www.gentoo.org

## app-core/findutils
- MissingRemoteId: missing <remote-id type="github">1g4-mirror/findutils</remote-id> (inferred from URI 'https://github.com/1g4-mirror/findutils/archive/580be65e2566a90c6029e994dce4b22ddd42806c.tar.gz')
- MissingTestRestrict: version 20251118: missing RESTRICT="!test? ( test )" with IUSE=test
- NonexistentDeps: version 20251118: DEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- PythonMissingDeps: version 20251118: missing DEPEND="${PYTHON_DEPS}"
- UnusedInherits: version 20251118: unused eclass: toolchain-funcs
- VariableScope: version 20251118: variable 'EROOT' used in 'src_prepare' on line: 37

## app-core/lsof
- MissingRemoteId: missing <remote-id type="github">lsof-org/lsof</remote-id> (inferred from URI 'https://github.com/lsof-org/lsof/archive/e018502b23e342cd6094c1c38dd88800d1476c18.tar.gz')
- UnusedInherits: version 20251104: unused eclass: toolchain-funcs

## app-core/hosts
- MissingRemoteId: missing <remote-id type="github">StevenBlack/hosts</remote-id> (inferred from URI 'https://github.com/StevenBlack/hosts')
- UnknownUseFlags: version 20251202: unknown USE flag: 'block'

## app-core/scrub
- MissingRemoteId: missing <remote-id type="github">chaos/scrub</remote-id> (inferred from URI 'https://github.com/chaos/scrub')

## app-core/pambase
- DeprecatedInsinto: version 1.6: deprecated insinto usage (use dopamd or newpamd from pam.eclass instead), line 24: insinto /etc/pam.d
- VariableOrderWrong: version 1.6: variable S should occur before KEYWORDS

## app-core/irqbalance
- MissingRemoteId: missing <remote-id type="github">Irqbalance/irqbalance</remote-id> (inferred from URI 'https://github.com/Irqbalance/irqbalance')
- DoubleEmptyLine: version 20251120: ebuild has unneeded empty line on line: 13
- UnknownKeywords: version 20251120: unknown KEYWORDS: 'arm', 'ppc', 'ppc64', 'x86', '~loong', '~riscv'
- UnknownUseFlags: version 20251120: unknown USE flags: 'numa', 'thermal', 'tui'

## app-core/sandbox
- MissingRemoteId: missing <remote-id type="github">gentoo/sandbox</remote-id> (inferred from URI 'https://github.com/gentoo/sandbox/archive/5ac4b15175ae8cc096b6a3d861b54b6e2a882367.tar.gz')
- DoubleEmptyLine: version 20250609: ebuild has unneeded empty line on line: 14
- UnknownUseFlags: version 20250609: unknown USE flag: 'nnp'

## app-core/groff
- MissingRemoteId: missing <remote-id type="github">1g4-mirror/groff</remote-id> (inferred from URI 'https://github.com/1g4-mirror/groff/archive/f42d6c6d2f586ec5c66f4a1dbc5b989e0a7dfc84.tar.gz')
- UnusedInherits: version 1.23.0: unused eclass: toolchain-funcs
- UnusedInherits: version 20251122: unused eclass: toolchain-funcs
- VariableScope: version 20251122: variable 'EROOT' used in 'src_prepare' on line: 31

## app-core/pciutils
- MissingRemoteId: missing <remote-id type="github">pciutils/pciutils</remote-id> (inferred from URI 'https://github.com/pciutils/pciutils/archive/3ec74c71c01878f92e751f15bb8febe720c3ab40.tar.gz')
- UnknownUseFlags: version 20250707: unknown USE flags: 'dns', 'kmod'

## app-core/dbus
- MissingRemoteId: missing <remote-id type="freedesktop-gitlab">dbus/dbus</remote-id> (inferred from URI 'https://gitlab.freedesktop.org/dbus/dbus/-/archive/1bcf396c7872f317778f3ff5645af1630738d43f/dbus-1bcf396c7872f317778f3ff5645af1630738d43f.tar.bz2')
- MissingTestRestrict: version 20250826: missing RESTRICT="!test? ( test )" with IUSE=test
- UnknownUseFlags: version 20250826: unknown USE flags: 'apparmor', 'inotify', 'tools', 'user-session', 'valgrind'
- UnusedInherits: version 20250826: unused eclass: flag-o-matic

## app-core/sudo
- MissingRemoteId: missing <remote-id type="github">sudo-project/sudo</remote-id> (inferred from URI 'https://github.com/sudo-project/sudo/archive/8e0b9a9d475a46d35b78bc6718d44a56a278553e.tar.gz')
- UnusedInherits: version 20251201: unused eclass: doins
- WhitespaceFound: version 20251201: ebuild has leading whitespace on lines: 37, 38, 39, 40, 41, 60

## app-core/toybox
- MissingRemoteId: missing <remote-id type="github">landley/toybox</remote-id> (inferred from URI 'https://github.com/landley/toybox/archive/b72880d6dcf77c7733b6117475bfc10d15e89605.tar.gz')
- BadDescription: version 20251203: over 80 chars in length
- WhitespaceFound: version 20251203: ebuild has leading whitespace on lines: 22, 24, 25, 26, 27, 29, 31, 32, 33, 35, 36, 37, 38, 39, 40, 41

## app-core/ed
- NonexistentDeps: version 1.21.1: DEPEND: nonexistent packages: app-compression/pdlzip, app-compression/plzip
- UnquotedVariable: version 1.21.1: unquoted variable S on line: 27
- WhitespaceFound: version 1.21.1: ebuild has leading whitespace on lines: 21, 22, 23

## app-core/tmux
- MissingRemoteId: missing <remote-id type="github">tmux/tmux</remote-id> (inferred from URI 'https://github.com/tmux/tmux/archive/1bcd360dfe8428a3d8d27777136669efd2a9a667.tar.gz')

## app-crypto/argon2
- MissingRemoteId: missing <remote-id type="github">P-H-C/phc-winner-argon2</remote-id> (inferred from URI 'https://github.com/P-H-C/phc-winner-argon2')
- ExcessiveLineLength: version 20210625: excessive line length (over 120 characters) on line: 24
- VariableOrderWrong: version 20210625: variable S should occur before IUSE

## app-crypto/hashcat-utils
- MissingRemoteId: missing <remote-id type="github">hashcat/hashcat-utils</remote-id> (inferred from URI 'https://github.com/hashcat/hashcat-utils')

## app-crypto/hcxdumptool
- MissingRemoteId: missing <remote-id type="github">ZerBea/hcxdumptool</remote-id> (inferred from URI 'https://github.com/ZerBea/hcxdumptool')

## app-crypto/clevis
- MissingRemoteId: missing <remote-id type="github">latchset/clevis</remote-id> (inferred from URI 'https://github.com/latchset/clevis')

## app-crypto/hcxtools
- MissingRemoteId: missing <remote-id type="github">ZerBea/hcxtools</remote-id> (inferred from URI 'https://github.com/ZerBea/hcxtools')

## app-crypto/hashcat
- MissingRemoteId: missing <remote-id type="github">hashcat/hashcat</remote-id> (inferred from URI 'https://github.com/hashcat/hashcat')
- UnknownUseFlags: version 20251120: unknown USE flags: 'custom-cflags', 'nvidia'

## app-crypto/ccid
- MissingRemoteId: missing <remote-id type="github">LudovicRousseau/CCID</remote-id> (inferred from URI 'https://github.com/LudovicRousseau/CCID')
- NonexistentDeps: version 20251129: BDEPEND: nonexistent package: virtual/pkgconfig
- NonsolvableDepsInStable: version 20251129: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ virtual/pkgconfig ]
- UnknownUseFlags: version 20251129: unknown USE flag: 'twinserial'

## app-crypto/chntpw
- MissingUseDepDefault: version 9999: DEPEND="virtual/ssl[static-libs]": USE flag 'static-libs' missing from package: [ virtual/ssl-0 ]
- NonsolvableDepsInStable: version 9999: nonsolvable depset(depend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ virtual/ssl[static-libs] ]
- VisibleVcsPkg: version 9999: VCS version visible for KEYWORDS="amd64", profile core/amd64/glibc (16 total)

## app-crypto/jitterentropy
- MissingRemoteId: missing <remote-id type="github">smuellerDD/jitterentropy-library</remote-id> (inferred from URI 'https://github.com/smuellerDD/jitterentropy-library')
- IndirectInherits: version 20250630: toolchain-funcs: indirect inherit usage: 'tc-getAR', line 34

## app-core/apparmor-utils
- MissingRemoteId: missing <remote-id type="gitlab">apparmor/apparmor/wikis/home</remote-id> (inferred from URI 'https://gitlab.com/apparmor/apparmor/wikis/home')
- NonexistentDeps: version 20251202: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 20251202: DEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 20251202: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 20251202: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 20251202: nonsolvable depset(depend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 20251202: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 20251202: missing RDEPEND="${PYTHON_DEPS}"
- RedundantUriRename: version 20251202: redundant rename: https://gitlab.com/apparmor/apparmor/-/archive/a7b4b3c726514f4e8bc21536d73c1fd2dcd44313/apparmor-a7b4b3c726514f4e8bc21536d73c1fd2dcd44313.tar.bz2 -> apparmor-a7b4b3c726514f4e8bc21536d73c1fd2dcd44313.tar.bz2
- UnknownUseFlags: version 20251202: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## app-crypto/botan
- MissingRemoteId: missing <remote-id type="github">randombit/botan</remote-id> (inferred from URI 'https://github.com/randombit/botan/archive/df91b27d3e866caa414f11871e7170da2501e67a.tar.gz')
- MissingInherits: version 20251127: python-utils-r1: missing inherit usage: 'EPYTHON', line 55
- UnknownUseFlags: version 20251127: unknown USE flag: 'boost'

## app-crypto/keyutils
- UnusedInherits: version 1.6.3: unused eclass: toolchain-funcs
- VariableScope: version 1.6.3: variable 'ED' used in 'src_compile' on lines: 33, 34, 35, 36, 37, 38, 39

## app-crypto/johntheripper
- MissingRemoteId: missing <remote-id type="github">openwall/john</remote-id> (inferred from URI 'https://github.com/openwall/john/archive/7a0ec105fd4904e57cdd4c9e7eaead77c8dd264d.tar.gz')
- UnknownUseFlags: version 20251127: unknown USE flags: 'opencl', 'pcap', 'rexgen'
- UnusedInherits: version 20251127: unused eclass: toolchain-funcs

## app-crypto/pass
- DoubleEmptyLine: version 20250618: ebuild has unneeded empty line on lines: 16, 26
- UnknownUseFlags: version 20250618: unknown USE flag: 'importers'

## app-crypto/pinentry
- MissingRemoteId: missing <remote-id type="github">gpg/pinentry</remote-id> (inferred from URI 'https://github.com/gpg/pinentry/archive/954b3da04ac95ffb23ce9eac34ff99633cffdb47.tar.gz')

## app-crypto/tpm2-tss
- MissingRemoteId: missing <remote-id type="github">tpm2-software/tpm2-tss</remote-id> (inferred from URI 'https://github.com/tpm2-software/tpm2-tss')
- UnknownUseFlags: version 20251203: unknown USE flag: 'keep-la'
- UnusedInherits: version 20251203: unused eclass: user

## app-crypto/pcsc-lite
- MissingRemoteId: missing <remote-id type="github">LudovicRousseau/PCSC</remote-id> (inferred from URI 'https://github.com/LudovicRousseau/PCSC')
- PythonMissingDeps: version 2.3.0: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 2.3.0: unknown USE flags: 'embedded', 'libusb', 'python_single_target_python3_13', 'python_single_target_python3_14'

## app-crypto/mit-krb5
- MissingRemoteId: missing <remote-id type="github">krb5/krb5</remote-id> (inferred from URI 'https://github.com/krb5/krb5/archive/fb83387bb554258d747e8c29d4986849407c9058.tar.gz')
- DeprecatedInsinto: version 20251121: deprecated insinto usage (use systemd_dounit or systemd_newunit from systemd.eclass instead), line 73: insinto /usr/lib/systemd/system
- UnknownUseFlags: version 20251121: unknown USE flags: 'keyutils', 'lmdb', 'openldap', 'pkinit', 'xinetd'
- UnusedInherits: version 20251121: unused eclass: toolchain-funcs

## app-crypto/p11-kit
- MissingRemoteId: missing <remote-id type="github">p11-glue/p11-kit</remote-id> (inferred from URI 'https://github.com/p11-glue/p11-kit')

## app-dev/checkbashisms
- VariableOrderWrong: version 9999: variable S should occur before RESTRICT
- VisibleVcsPkg: version 9999: VCS version visible for KEYWORDS="amd64", profile core/amd64/glibc (16 total)

## app-core/1g4-tools
- NonsolvableDepsInStable: version 1.0: nonsolvable depset(rdepend) keyword(arm64) stable profile (core/arm64/glibc) (8 total): solutions: [ app-build/gdb ]
- UnknownLicense: version 1.0: unknown license: metapackage
- UnusedInherits: version 1.0: unused eclass: toolchain-funcs

## app-crypto/gnupg
- MissingRemoteId: missing <remote-id type="github">gpg/gnupg</remote-id> (inferred from URI 'https://github.com/gpg/gnupg/archive/ff30683418695f5d2cc9e6cf8c9418e09378ebe4.tar.gz')
- ExcessiveLineLength: version 2.4.20251110: excessive line length (over 120 characters) on lines: 51, 52
- UnknownUseFlags: version 2.4.20251110: unknown USE flags: 'gnutls', 'tools'
- WhitespaceFound: version 2.4.20251110: ebuild has leading whitespace on lines: 41, 42, 48

## app-crypto/tpm2-tools
- MissingRemoteId: missing <remote-id type="github">tpm2-software/tpm2-tools</remote-id> (inferred from URI 'https://github.com/tpm2-software/tpm2-tools')

## app-crypto/libsecret
- MissingRemoteId: missing <remote-id type="github">GNOME/libsecret</remote-id> (inferred from URI 'https://github.com/GNOME/libsecret')
- UnknownUseFlags: version 20251108: unknown USE flag: 'introspection'

## app-crypto/rng-tools
- MissingRemoteId: missing <remote-id type="github">nhorman/rng-tools</remote-id> (inferred from URI 'https://github.com/nhorman/rng-tools')
- DeprecatedInsinto: version 20250420: deprecated insinto usage (use systemd_dounit or systemd_newunit from systemd.eclass instead), line 55: insinto /usr/lib/systemd/system
- UnknownUseFlags: version 20250420: unknown USE flags: 'jitterentropy', 'nistbeacon'

## app-dev/debootstrap
- TrailingEmptyLine: version 9999: ebuild has trailing blank line(s)
- VisibleVcsPkg: version 9999: VCS version visible for KEYWORDS="amd64", profile core/amd64/glibc (16 total)

## app-core/pkgcore
- MissingRemoteId: missing <remote-id type="github">pkgcore/pkgcore</remote-id> (inferred from URI 'https://github.com/pkgcore/pkgcore')
- EPyTestPluginsSuggestion: version 20251130: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- NonexistentDeps: version 20251130: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 20251130: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 20251130: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 20251130: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 20251130: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 20251130: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'
- WhitespaceFound: version 20251130: ebuild has leading whitespace on lines: 43, 47, 48, 52, 54

## app-dev/dtc
- MissingRemoteId: missing <remote-id type="github">dgibson/dtc</remote-id> (inferred from URI 'https://github.com/dgibson/dtc/archive/7f3184a6c550bb8fb59e93c9901d75dced889dcf.tar.gz')

## app-dev/fmt
- MissingRemoteId: missing <remote-id type="github">fmtlib/fmt</remote-id> (inferred from URI 'https://github.com/fmtlib/fmt')

## app-dev/dwarves
- MissingRemoteId: missing <remote-id type="github">acmel/dwarves</remote-id> (inferred from URI 'https://github.com/acmel/dwarves/archive/8b536f4ea4706f6e06db0567c18ce3f1c41c3f67.tar.gz')
- PythonMissingDeps: version 20251113: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 20251113: unknown USE flags: 'python_single_target_python3_11', 'python_single_target_python3_12', 'python_single_target_python3_13', 'python_single_target_python3_14'

## app-dev/flashrom
- MissingRemoteId: missing <remote-id type="github">flashrom/flashrom</remote-id> (inferred from URI 'https://github.com/flashrom/flashrom/archive/6504b95668050525cb47914e4234e07070cfe08c.tar.gz')
- UnknownUseFlags: version 20251202: unknown USE flags: 'internal', 'internal-dmi', 'linux-mtd', 'linux-spi', 'tools'

## app-dev/gh
- MissingRemoteId: missing <remote-id type="github">cli/cli</remote-id> (inferred from URI 'https://github.com/cli/cli')
- VisibleVcsPkg: version 9999: VCS version visible for KEYWORDS="amd64", profile core/amd64/glibc (16 total)

## app-dev/git-lfs
- MissingRemoteId: missing <remote-id type="github">git-lfs/git-lfs</remote-id> (inferred from URI 'https://github.com/git-lfs/git-lfs/archive/194116686bb5559bdcfe5cde784ee53e86aa0b16.tar.gz')

## app-dev/glslang
- MissingRemoteId: missing <remote-id type="github">KhronosGroup/glslang</remote-id> (inferred from URI 'https://github.com/KhronosGroup/glslang')

## app-dev/intltool
- MissingRemoteId: missing <remote-id type="launchpad">intltool</remote-id> (inferred from URI 'https://launchpad.net/intltool/')

## app-dev/gtk-doc-am
- MissingRemoteId: missing <remote-id type="gnome-gitlab">GNOME/gtk-doc</remote-id> (inferred from URI 'https://gitlab.gnome.org/GNOME/gtk-doc/-/archive/82623a6c120e153be9bee8642693a00bc1aae77f/gtk-doc-82623a6c120e153be9bee8642693a00bc1aae77f.tar.bz2')
- MissingInherits: version 20251003: python-utils-r1: missing inherit usage: 'PYTHON', line 27
- RedundantUriRename: version 20251003: redundant rename: https://gitlab.gnome.org/GNOME/gtk-doc/-/archive/82623a6c120e153be9bee8642693a00bc1aae77f/gtk-doc-82623a6c120e153be9bee8642693a00bc1aae77f.tar.bz2 -> gtk-doc-82623a6c120e153be9bee8642693a00bc1aae77f.tar.bz2
- VisibleVcsPkg: version 20251003: VCS version visible for KEYWORDS="amd64", profile core/amd64/glibc (16 total)

## app-dev/jose
- MissingRemoteId: missing <remote-id type="github">potatosalad/erlang-jose</remote-id> (inferred from URI 'https://github.com/potatosalad/erlang-jose')
- NonexistentDeps: version 1.11.10: DEPEND: nonexistent package: >=dev-lang/erlang-19.0
- NonexistentDeps: version 1.11.10: RDEPEND: nonexistent package: >=dev-lang/erlang-19.0
- NonsolvableDepsInStable: version 1.11.10: nonsolvable depset(depend) keyword(amd64) stable profile (core/amd64/glibc) (8 total): solutions: [ >=dev-lang/erlang-19.0 ]
- NonsolvableDepsInStable: version 1.11.10: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (8 total): solutions: [ >=dev-lang/erlang-19.0 ]
- UnknownKeywords: version 1.11.10: unknown KEYWORDS: '~arm', '~sparc', '~x86'

## app-dev/cmake
- MissingRemoteId: missing <remote-id type="github">Kitware/CMake</remote-id> (inferred from URI 'https://github.com/Kitware/CMake/releases/download/v3.31.9/cmake-3.31.9.tar.gz')
- ExcessiveLineLength: version 3.31.9-r9: excessive line length (over 120 characters) on line: 31
- MisplacedEclassVar: version 3.31.9-r9: invalid pre-inherit placement, line 98: 'CMAKE_MAKEFILE_GENERATOR=emake'
- UnknownUseFlags: version 3.31.9-r9: unknown USE flag: 'vim'
- UnquotedVariable: version 3.31.9-r9: unquoted variable S on lines: 104, 105, 106
- WhitespaceFound: version 3.31.9-r9: ebuild has leading whitespace on lines: 18, 19, 20, 21, 22, 23, 27, 28, 29, 30, 31, 32, 33, 34, 35, 37, 38, 39, 40, 42, 44, 45, 46, 47, 48, 52, 53, 54, 55, 56, 58, 60, 61, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 76, 80, 81, 82, 84, 86, 87, 88, 89, 90, 92, 93, 94, 95, 97, 98, 99, 100, 101, 103, 104, 105, 106, 108, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 126, 130, 132, 134, 136, 137

## app-dev/gn
- NonexistentDeps: version 9999: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- PythonMissingDeps: version 9999: missing DEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 9999: unknown USE flag: 'vim-syntax'
- VisibleVcsPkg: version 9999: VCS version visible for KEYWORDS="amd64", profile core/amd64/glibc (16 total)

## app-dev/llama-cpp
- MissingRemoteId: missing <remote-id type="github">ggml-org/llama.cpp</remote-id> (inferred from URI 'https://github.com/ggml-org/llama.cpp')
- DeprecatedInsinto: version 20251204: deprecated insinto usage (use systemd_dounit or systemd_newunit from systemd.eclass instead), line 36: insinto /usr/lib/systemd/system
- UnusedInherits: version 20251204: unused eclass: flag-o-matic

## app-dev/opencl-headers
- MissingRemoteId: missing <remote-id type="github">KhronosGroup/OpenCL-Headers</remote-id> (inferred from URI 'https://github.com/KhronosGroup/OpenCL-Headers')

## app-core/systemd-tools
- MissingRemoteId: missing <remote-id type="github">systemd/systemd</remote-id> (inferred from URI 'https://github.com/systemd/systemd/archive/a707299ca77b1e8637a0946807e1bc2d5627eaa5.tar.gz')
- SizeViolation: 'files/patches/0012-do-not-disable-buffer-in-writing-files.patch' exceeds 20.0 KiB in size; 25.6 KiB total
- TotalSizeViolation: files/ directory exceeds 50.0 KiB in size; 107.6 KiB total
- NonexistentDeps: version 257.20251114: IDEPEND: nonexistent package: app-dev/desktop-file-utils
- NonsolvableDepsInStable: version 257.20251114: nonsolvable depset(idepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-dev/desktop-file-utils ]
- UnknownUseFlags: version 257.20251114: unknown USE flags: 'apparmor', 'binfmt', 'blkid', 'bootloader', 'bpf-framework', 'coredump', 'devmode', 'dhcp4', 'efi', 'elfutils', 'gcrypt', 'gshadow', 'hostnamed', 'hwdb', 'importd', 'kmod', 'ldconfig', 'localed', 'logind', 'machined', 'networkd', 'oomd', 'pstore', 'resolve', 'rfkill', 'systemd-update', 'timedated', 'userdb', 'vconsole', 'xkb'
- UnusedInherits: version 257.20251114: unused eclasses: doins, toolchain-funcs
- WhitespaceFound: version 257.20251114: ebuild has leading whitespace on lines: 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 56, 57, 61, 62, 63, 64, 65, 66, 67, 69, 70, 71, 73, 75, 76, 77, 78, 79, 80, 81, 83, 84, 88, 90, 92, 93, 94, 96, 97, 99, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126, 127, 128, 129, 130, 131, 132, 133, 134, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 145, 146, 147, 148, 149, 150, 151, 152, 153, 154, 155, 156, 157, 158, 159, 160, 161, 162, 163, 164, 165, 166, 167, 168, 169, 170, 171, 172, 173, 174, 175, 176, 177, 178, 179, 180, 181, 182, 183, 184, 185, 186, 187, 188, 189, 190, 191, 192, 201

## app-dev/android-studio
- UnknownLicense: version 2024.3.2.15: unknown licenses: CDDL-1.1, CPL-0.5, EPL-1.0, JDOM, NPL-1.1, android

## app-dev/beautysh
- MissingRemoteId: missing <remote-id type="github">lovesegfault/beautysh</remote-id> (inferred from URI 'https://github.com/lovesegfault/beautysh')
- NonexistentDeps: version 20251201: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 20251201: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 20251201: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 20251201: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 20251201: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 20251201: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## app-dev/jq
- MissingRemoteId: missing <remote-id type="github">jqlang/jq</remote-id> (inferred from URI 'https://github.com/jqlang/jq/archive/0eb3da11ed489189963045a3d4eb21ba343736cb.tar.gz')

## app-dev/re2c
- MissingRemoteId: missing <remote-id type="github">skvadrik/re2c</remote-id> (inferred from URI 'https://github.com/skvadrik/re2c/archive/600717ad6a45759b68f31030bfc6e6ad566b3863.tar.gz')

## app-dev/gperf
- MissingRemoteId: missing <remote-id type="github">1g4-mirror/gperf</remote-id> (inferred from URI 'https://github.com/1g4-mirror/gperf/archive/19926e7bd830aa11d7f45e6151fad66152d3c5d3.tar.gz')
- DoubleEmptyLine: version 20250912: ebuild has unneeded empty line on line: 31
- TrailingEmptyLine: version 20250912: ebuild has trailing blank line(s)
- VariableScope: version 20250912: variable 'EROOT' used in 'src_prepare' on line: 20

## app-dev/pkgconf
- MissingRemoteId: missing <remote-id type="github">pkgconf/pkgconf</remote-id> (inferred from URI 'https://github.com/pkgconf/pkgconf/archive/90f9186e100ce5b87b2a417045aff42f1513b279.tar.gz')
- BadDescription: version 20251202: over 80 chars in length

## app-dev/samurai
- MissingRemoteId: missing <remote-id type="github">michaelforney/samurai</remote-id> (inferred from URI 'https://github.com/michaelforney/samurai')

## app-dev/gtk-doc
- MissingRemoteId: missing <remote-id type="gnome-gitlab">GNOME/gtk-doc</remote-id> (inferred from URI 'https://gitlab.gnome.org/GNOME/gtk-doc/-/archive/82623a6c120e153be9bee8642693a00bc1aae77f/gtk-doc-82623a6c120e153be9bee8642693a00bc1aae77f.tar.bz2')
- DoubleEmptyLine: version 20251003: ebuild has unneeded empty line on line: 5
- PythonMissingDeps: version 20251003: missing RDEPEND="${PYTHON_DEPS}"
- PythonMissingRequiredUse: version 20251003: missing REQUIRED_USE="${PYTHON_REQUIRED_USE}"
- RedundantUriRename: version 20251003: redundant rename: https://gitlab.gnome.org/GNOME/gtk-doc/-/archive/82623a6c120e153be9bee8642693a00bc1aae77f/gtk-doc-82623a6c120e153be9bee8642693a00bc1aae77f.tar.bz2 -> gtk-doc-82623a6c120e153be9bee8642693a00bc1aae77f.tar.bz2
- UnknownUseFlags: version 20251003: unknown USE flags: 'python_single_target_python3_11', 'python_single_target_python3_12', 'python_single_target_python3_13', 'python_single_target_python3_14'

## app-dev/spirv-headers
- MissingRemoteId: missing <remote-id type="github">KhronosGroup/SPIRV-Headers</remote-id> (inferred from URI 'https://github.com/KhronosGroup/SPIRV-Headers')

## app-dev/simdutf
- MissingRemoteId: missing <remote-id type="github">simdutf/simdutf</remote-id> (inferred from URI 'https://github.com/simdutf/simdutf')
- BadDescription: version 20251129: over 80 chars in length

## app-dev/ninja
- MissingRemoteId: missing <remote-id type="github">ninja-build/ninja</remote-id> (inferred from URI 'https://github.com/ninja-build/ninja/archive/v1.13.1.tar.gz')
- DeprecatedInsinto: version 1.13.1: deprecated insinto usage (use dozshcomp or newzshcomp from shell-completion.eclass instead), line 90: insinto /usr/share/zsh/site-functions
- NonexistentDeps: version 1.13.1: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- PythonMissingDeps: version 1.13.1: missing DEPEND="${PYTHON_DEPS}"
- UnknownKeywords: version 1.13.1: unknown KEYWORDS: 'arm', 'ppc', 'ppc64', 'x86', '~alpha', '~amd64-linux', '~arm64-macos', '~hppa', '~loong', '~m68k', '~mips', '~ppc-macos', '~riscv', '~s390', '~sparc', '~x64-macos', '~x64-solaris', '~x86-linux'

## app-dev/unity
- MissingRemoteId: missing <remote-id type="github">ThrowTheSwitch/Unity</remote-id> (inferred from URI 'https://github.com/ThrowTheSwitch/Unity')

## app-dev/rebar
- MissingRemoteId: missing <remote-id type="github">erlang/rebar3</remote-id> (inferred from URI 'https://github.com/erlang/rebar3')
- DeprecatedInsinto: version 3.24.0: deprecated insinto usage (use dozshcomp or newzshcomp from shell-completion.eclass instead), line 59: insinto /usr/share/zsh/site-functions

## app-crypto/m2crypto
- MissingRemoteId: missing <remote-id type="gitlab">m2crypto/m2crypto</remote-id> (inferred from URI 'https://gitlab.com/m2crypto/m2crypto/')
- MissingRemoteId: missing <remote-id type="pypi">M2Crypto</remote-id> (inferred from URI 'https://files.pythonhosted.org/packages/source/M/M2Crypto/m2crypto-0.42.0.tar.gz')
- NonexistentDeps: version 0.42.0: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 0.42.0: DEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 0.42.0: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 0.42.0: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 0.42.0: nonsolvable depset(depend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 0.42.0: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 0.42.0: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 0.42.0: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'
- NonexistentDeps: version 20251202: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 20251202: DEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 20251202: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 20251202: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 20251202: nonsolvable depset(depend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 20251202: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 20251202: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 20251202: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## app-dev/spirv-tools
- MissingRemoteId: missing <remote-id type="github">KhronosGroup/SPIRV-Tools</remote-id> (inferred from URI 'https://github.com/KhronosGroup/SPIRV-Tools')

## app-dev/strace
- MissingRemoteId: missing <remote-id type="github">1g4-mirror/strace</remote-id> (inferred from URI 'https://github.com/1g4-mirror/strace/archive/35d1efeac1b9ae48299bc3bf8fcf68df014089bb.tar.gz')
- MissingRemoteId: missing <remote-id type="sourceforge">strace</remote-id> (inferred from URI 'https://sourceforge.net/projects/strace/')
- NonexistentDeps: version 20251122: DEPEND: nonexistent package: lib-util/libunwind
- NonsolvableDepsInStable: version 20251122: nonsolvable depset(depend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ lib-util/libunwind ]
- UnknownUseFlags: version 20251122: unknown USE flag: 'libunwind'

## app-dev/unifdef
- UnknownKeywords: version 2.12-r2: unknown KEYWORDS: 'arm', 'ppc', 'ppc64', 'x86', '~alpha', '~amd64-linux', '~hppa', '~loong', '~m68k', '~mips', '~riscv', '~s390', '~sparc', '~x86-linux'

## app-dev/repo
- MissingRemoteId: missing <remote-id type="github">GerritCodeReview/git-repo</remote-id> (inferred from URI 'https://github.com/GerritCodeReview/git-repo/archive/1e4b2887a760e84f3b453c9caadcae67b701eac9.tar.gz')
- NonexistentDeps: version 20251203: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 20251203: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 20251203: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 20251203: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## app-dev/yaml-cpp
- MissingRemoteId: missing <remote-id type="github">jbeder/yaml-cpp</remote-id> (inferred from URI 'https://github.com/jbeder/yaml-cpp')
- UnusedInherits: version 20251201: unused eclass: flag-o-matic

## app-dev/vulkan-headers
- MissingRemoteId: missing <remote-id type="github">KhronosGroup/Vulkan-Headers</remote-id> (inferred from URI 'https://github.com/KhronosGroup/Vulkan-Headers')

## app-dev/valgrind
- MissingRemoteId: missing <remote-id type="github">1g4-mirror/valgrind</remote-id> (inferred from URI 'https://github.com/1g4-mirror/valgrind/archive/bef37208b428c1d31f42faf62991e6331dc4dd28.tar.gz')

## app-dev/maturin
- MissingRemoteId: missing <remote-id type="github">PyO3/maturin</remote-id> (inferred from URI 'https://github.com/PyO3/maturin/archive/d6d23cf97d19c327b10e51a1f7b6b87f662464b6.tar.gz')
- NonexistentDeps: version 20251203: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 20251203: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 20251203: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 20251203: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 20251203: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 20251203: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'
- UnusedInherits: version 20251203: unused eclasses: flag-o-matic, toolchain-funcs

## app-emu/binwalk
- MissingRemoteId: missing <remote-id type="github">ReFirmLabs/binwalk</remote-id> (inferred from URI 'https://github.com/ReFirmLabs/binwalk')
- VisibleVcsPkg: version 9999: VCS version visible for KEYWORDS="amd64", profile core/amd64/glibc (16 total)

## app-emu/acpica
- MissingRemoteId: missing <remote-id type="github">acpica/acpica</remote-id> (inferred from URI 'https://github.com/acpica/acpica/archive/8ac226fa7f0bb5b1d8579cfaf1ae2eb4c935c0af.tar.gz')
- UnknownKeywords: version 20251120: unknown KEYWORDS: 'arm', 'ppc', 'ppc64', 'x86', '~alpha', '~loong', '~mips'
- UnusedInherits: version 20251120: unused eclass: toolchain-funcs

## app-emu/payload-dumper-go
- MissingRemoteId: missing <remote-id type="github">ssut/payload-dumper-go</remote-id> (inferred from URI 'https://github.com/ssut/payload-dumper-go')

## app-emu/sleuthkit
- MissingRemoteId: missing <remote-id type="github">sleuthkit/sleuthkit</remote-id> (inferred from URI 'https://github.com/sleuthkit/sleuthkit/archive/818da9a9206e67eb76f763b900e5bef1430d22a0.tar.gz')

## app-emu/radare2
- VisibleVcsPkg: version 9999: VCS version visible for KEYWORDS="amd64", profile core/amd64/glibc (16 total)

## app-fs/dosfstools
- MissingRemoteId: missing <remote-id type="github">dosfstools/dosfstools</remote-id> (inferred from URI 'https://github.com/dosfstools/dosfstools')

## app-dev/vulkan-tools
- MissingRemoteId: missing <remote-id type="github">KhronosGroup/Vulkan-Tools</remote-id> (inferred from URI 'https://github.com/KhronosGroup/Vulkan-Tools')
- NonexistentDeps: version 20251201: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- PythonMissingDeps: version 20251201: missing DEPEND="${PYTHON_DEPS}"
- RequiredUseDefaults: version 20251201: profile: 'core/amd64/glibc' (8 total) failed REQUIRED_USE: ( X || wayland )
- UnknownUseFlags: version 20251201: unknown USE flag: 'cube'

## app-fs/efivar
- MissingRemoteId: missing <remote-id type="github">rhboot/efivar</remote-id> (inferred from URI 'https://github.com/rhboot/efivar')

## app-fs/efibootmgr
- MissingRemoteId: missing <remote-id type="github">rhinstaller/efibootmgr</remote-id> (inferred from URI 'https://github.com/rhinstaller/efibootmgr')
- DoubleEmptyLine: version 20221005-r9: ebuild has unneeded empty line on line: 22
- VariableScope: version 20221005-r9: variable 'ED' used in 'src_compile' on line: 30

## app-fs/exfat
- MissingRemoteId: missing <remote-id type="github">relan/exfat</remote-id> (inferred from URI 'https://github.com/relan/exfat')

## app-fs/fuse
- MissingRemoteId: missing <remote-id type="github">libfuse/libfuse</remote-id> (inferred from URI 'https://github.com/libfuse/libfuse')
- UnusedInherits: version 20251203: unused eclass: flag-o-matic

## app-emu/qemu-user-static
- MissingRemoteId: missing <remote-id type="github">qemu/qemu</remote-id> (inferred from URI 'https://github.com/qemu/qemu/archive/e098f79eb26b5c4e4c04cc33321d188dcb20719f.tar.gz')
- VariableOrderWrong: version 10.0.20251020: variable IUSE should occur before RESTRICT
- WhitespaceFound: version 10.0.20251020: ebuild has leading whitespace on lines: 24, 25, 26, 27, 28

## app-fs/f2fs-tools
- RedundantUriRename: version 20251016: redundant rename: https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs-tools.git/snapshot/f2fs-tools-fa02bbaa8909f185dc036247adbee70cf4452a3d.tar.gz -> f2fs-tools-fa02bbaa8909f185dc036247adbee70cf4452a3d.tar.gz

## app-dev/ropgadget
- MissingRemoteId: missing <remote-id type="github">JonathanSalwan/ROPgadget</remote-id> (inferred from URI 'https://github.com/JonathanSalwan/ROPgadget/archive/4d3e29740f28288acfaff9677fec089056a0f9e9.tar.gz')
- NonexistentDeps: version 20251122: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 20251122: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 20251122: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 20251122: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 20251122: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 20251122: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## app-fs/gdisk
- MissingRemoteId: missing <remote-id type="github">caldwell/gdisk</remote-id> (inferred from URI 'https://github.com/caldwell/gdisk')
- IndirectInherits: version 20241223: toolchain-funcs: indirect inherit usage: 'tc-export CXX PKG_CONFIG', line 26

## app-fs/lsscsi
- MissingRemoteId: missing <remote-id type="github">hreinecke/lsscsi</remote-id> (inferred from URI 'https://github.com/hreinecke/lsscsi/archive/8d34e7ddbabc69e04ae5b28dc14aa3a448cc3201.tar.gz')

## app-emu/keystone
- MissingRemoteId: missing <remote-id type="github">keystone-engine/keystone</remote-id> (inferred from URI 'https://github.com/keystone-engine/keystone')
- DistutilsNonPEP517Build: version 20230519: uses deprecated non-PEP517 build mode, please switch to DISTUTILS_USE_PEP517=...
- NonexistentDeps: version 20230519: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 20230519: DEPEND: nonexistent package: dev-python/pefile
- NonexistentDeps: version 20230519: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 20230519: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 20230519: nonsolvable depset(depend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ dev-python/pefile ]
- NonsolvableDepsInStable: version 20230519: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 20230519: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 20230519: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## app-fs/e2fsprogs
- MissingRemoteId: missing <remote-id type="github">tytso/e2fsprogs</remote-id> (inferred from URI 'https://github.com/tytso/e2fsprogs/archive/0b2752ce6276b383a5254cd766204f81f41b6631.tar.gz')
- UnknownUseFlags: version 20251111: unknown USE flag: 'fuse'
- UnusedInherits: version 20251111: unused eclass: autotools

## app-emu/capstone
- MissingRemoteId: missing <remote-id type="github">capstone-engine/capstone</remote-id> (inferred from URI 'https://github.com/capstone-engine/capstone/archive/cd6dd7b75d126a855be1f9f76570ee5a850c6061.tar.gz')
- DistutilsNonPEP517Build: version 5.20250922: uses deprecated non-PEP517 build mode, please switch to DISTUTILS_USE_PEP517=...
- MisplacedEclassVar: version 5.20250922: invalid pre-inherit placement, line 7: 'DISTUTILS_EXT=1'
- NonexistentDeps: version 5.20250922: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 5.20250922: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 5.20250922: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 5.20250922: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 5.20250922: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 5.20250922: unknown USE flags: 'diet', 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## app-fs/gnu-efi
- MissingRemoteId: missing <remote-id type="github">ncroxon/gnu-efi</remote-id> (inferred from URI 'https://github.com/ncroxon/gnu-efi/archive/dccdf84a2312512e3cd99b648992bc56c384faca.tar.gz')
- MissingRemoteId: missing <remote-id type="sourceforge">gnu-efi</remote-id> (inferred from URI 'https://sourceforge.net/projects/gnu-efi/')
- UnknownUseFlags: version 20251202: unknown USE flag: 'custom-cflags'

## app-emu/qemu
- MissingRemoteId: missing <remote-id type="github">qemu/qemu</remote-id> (inferred from URI 'https://github.com/qemu/qemu/archive/e098f79eb26b5c4e4c04cc33321d188dcb20719f.tar.gz')
- NonexistentDeps: version 10.0.20251020: IDEPEND: nonexistent package: app-dev/desktop-file-utils
- NonsolvableDepsInStable: version 10.0.20251020: nonsolvable depset(idepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-dev/desktop-file-utils ]
- UnknownUseFlags: version 10.0.20251020: unknown USE flags: 'bpf', 'capstone', 'numa', 'slirp', 'vnc', 'xdp'
- VariableOrderWrong: version 10.0.20251020: variable IUSE should occur before RESTRICT
- WhitespaceFound: version 10.0.20251020: ebuild has leading whitespace on lines: 39, 41, 42, 46, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 84, 85, 89, 90, 94, 95, 97

## app-core/systemd
- MissingRemoteId: missing <remote-id type="github">systemd/systemd</remote-id> (inferred from URI 'https://github.com/systemd/systemd/archive/940e26c19c84c8b4fb01edb3439196cc53234b2b.tar.gz')
- SizeViolation: 'files/patches/0012-do-not-disable-buffer-in-writing-files.patch' exceeds 20.0 KiB in size; 25.6 KiB total
- TotalSizeViolation: files/ directory exceeds 50.0 KiB in size; 107.6 KiB total
- NonexistentDeps: version 257.20251114: IDEPEND: nonexistent package: app-dev/desktop-file-utils
- NonsolvableDepsInStable: version 257.20251114: nonsolvable depset(idepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-dev/desktop-file-utils ]
- UnknownUseFlags: version 257.20251114: unknown USE flags: 'apparmor', 'binfmt', 'blkid', 'bootloader', 'bpf-framework', 'coredump', 'devmode', 'dhcp4', 'efi', 'elfutils', 'gcrypt', 'gshadow', 'hostnamed', 'hwdb', 'importd', 'kmod', 'ldconfig', 'localed', 'logind', 'machined', 'networkd', 'oomd', 'pstore', 'resolve', 'rfkill', 'systemd-update', 'timedated', 'userdb', 'vconsole', 'xkb'
- UnnecessarySlashStrip: version 257.20251114: ${EROOT%/} unnecessary slash strip on line: 292
- UnusedInherits: version 257.20251114: unused eclass: toolchain-funcs
- WhitespaceFound: version 257.20251114: ebuild has leading whitespace on lines: 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 56, 57, 61, 62, 63, 64, 65, 66, 67, 69, 70, 71, 73, 75, 76, 77, 78, 79, 80, 81, 83, 84, 88, 90, 92, 93, 94, 96, 97, 99, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126, 127, 128, 129, 130, 131, 132, 133, 134, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 145, 146, 147, 148, 149, 150, 151, 152, 153, 154, 155, 156, 157, 158, 159, 160, 161, 162, 163, 164, 165, 166, 167, 168, 169, 170, 171, 172, 173, 174, 175, 176, 177, 178, 179, 180, 181, 182, 183, 184, 185, 186, 187, 188, 189, 190, 191, 192, 284, 288, 290, 292, 293, 295, 296, 298
- NonexistentDeps: version 258.20251203: IDEPEND: nonexistent package: app-dev/desktop-file-utils
- UnknownUseFlags: version 258.20251203: unknown USE flags: 'apparmor', 'binfmt', 'blkid', 'bootloader', 'bpf-framework', 'coredump', 'devmode', 'dhcp4', 'efi', 'elfutils', 'gcrypt', 'gshadow', 'hostnamed', 'hwdb', 'importd', 'kmod', 'ldconfig', 'localed', 'logind', 'machined', 'networkd', 'oomd', 'pstore', 'resolve', 'rfkill', 'systemd-update', 'timedated', 'userdb', 'vconsole', 'xkb'
- UnnecessarySlashStrip: version 258.20251203: ${EROOT%/} unnecessary slash strip on line: 292
- UnusedInherits: version 258.20251203: unused eclass: toolchain-funcs
- WhitespaceFound: version 258.20251203: ebuild has leading whitespace on lines: 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 56, 57, 61, 62, 63, 64, 65, 66, 67, 69, 70, 71, 73, 75, 76, 77, 78, 79, 80, 81, 83, 84, 88, 90, 92, 93, 94, 96, 97, 99, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126, 127, 128, 129, 130, 131, 132, 133, 134, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 145, 146, 147, 148, 149, 150, 151, 152, 153, 154, 155, 156, 157, 158, 159, 160, 161, 162, 163, 164, 165, 166, 167, 168, 169, 170, 171, 172, 173, 174, 175, 176, 177, 178, 179, 180, 181, 182, 183, 184, 185, 186, 187, 188, 189, 190, 191, 192, 284, 288, 290, 292, 293, 295, 296, 298

## app-dev/meson
- MissingRemoteId: missing <remote-id type="github">mesonbuild/meson</remote-id> (inferred from URI 'https://github.com/mesonbuild/meson/archive/d11b8f26f372c844fcd24a82fa745244bb13c6e0.tar.gz')
- DeprecatedInsinto: version 1.9.20251202: deprecated insinto usage (use dozshcomp or newzshcomp from shell-completion.eclass instead), line 41: insinto /usr/share/zsh/site-functions
- NonexistentDeps: version 1.9.20251202: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 1.9.20251202: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 1.9.20251202: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 1.9.20251202: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 1.9.20251202: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 1.9.20251202: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14', 'vim', 'zsh'

## app-fs/mdadm
- MissingRemoteId: missing <remote-id type="github">md-raid-utilities/mdadm</remote-id> (inferred from URI 'https://github.com/md-raid-utilities/mdadm')
- NonexistentDeps: version 20251124: BDEPEND: nonexistent package: virtual/pkgconfig
- NonsolvableDepsInStable: version 20251124: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ virtual/pkgconfig ]
- WhitespaceFound: version 20251124: ebuild has leading whitespace on lines: 21, 22, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 44, 45, 47, 48, 49, 50, 52, 53, 57, 58, 62, 63, 64

## app-fs/btrfs-progs
- MissingRemoteId: missing <remote-id type="github">kdave/btrfs-progs</remote-id> (inferred from URI 'https://github.com/kdave/btrfs-progs/archive/82451bec91e5213665f3c3429e5c2ccb3de4d919.tar.gz')

## app-emu/qiling
- MissingRemoteId: missing <remote-id type="github">qilingframework/qiling</remote-id> (inferred from URI 'https://github.com/qilingframework/qiling')
- DistutilsNonPEP517Build: version 20250307: uses deprecated non-PEP517 build mode, please switch to DISTUTILS_USE_PEP517=...
- NonexistentDeps: version 20250307: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 20250307: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 20250307: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 20250307: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 20250307: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 20250307: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## app-fs/lvm2
- MissingRemoteId: missing <remote-id type="github">1g4-mirror/lvm2</remote-id> (inferred from URI 'https://github.com/1g4-mirror/lvm2/archive/5d50733efecd0b48bf21da0fa581fa5ae8d42e17.tar.gz')
- UnknownUseFlags: version 20251121: unknown USE flag: 'dm-only'
- WhitespaceFound: version 20251121: ebuild has leading whitespace on lines: 35, 36, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51

## app-fs/sysfsutils
- MissingRemoteId: missing <remote-id type="github">linux-ras/sysfsutils</remote-id> (inferred from URI 'https://github.com/linux-ras/sysfsutils/archive/085bba6bab1ccaa89041639a7e070390fdea440a.tar.gz')

## app-fs/udftools
- MissingRemoteId: missing <remote-id type="github">pali/udftools</remote-id> (inferred from URI 'https://github.com/pali/udftools/')
- MissingRemoteId: missing <remote-id type="sourceforge">linux-udf</remote-id> (inferred from URI 'https://sourceforge.net/projects/linux-udf/')

## app-kernel/intel-ucode
- MissingRemoteId: missing <remote-id type="github">intel/Intel-Linux-Processor-Microcode-Data-Files</remote-id> (inferred from URI 'https://github.com/intel/Intel-Linux-Processor-Microcode-Data-Files')
- UnknownLicense: version 20251110: unknown license: INTEL

## app-fs/ntfs3g
- MissingRemoteId: missing <remote-id type="github">tuxera/ntfs-3g</remote-id> (inferred from URI 'https://github.com/tuxera/ntfs-3g/archive/d3ace19838ce37cfde55294e76841e6d2f393f9e.tar.gz')
- UnknownUseFlags: version 20251011: unknown USE flags: 'ntfsdecrypt', 'ntfsprogs', 'suid'

## app-emu/unicorn
- MissingRemoteId: missing <remote-id type="github">unicorn-engine/unicorn</remote-id> (inferred from URI 'https://github.com/unicorn-engine/unicorn')
- NonexistentDeps: version 20250911: DEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 20250911: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 20250911: nonsolvable depset(depend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 20250911: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 20250911: missing RDEPEND="${PYTHON_DEPS}"
- PythonMissingSCMDependency: version 20250911: defines SETUPTOOLS_SCM_PRETEND_VERSION but is missing BDEPEND on setuptools-scm or alike
- UnknownUseFlags: version 20250911: unknown USE flags: 'logging', 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'
- UnusedInherits: version 20250911: unused eclass: flag-o-matic

## app-fs/wimlib
- MissingRemoteId: missing <remote-id type="github">ebiggers/wimlib</remote-id> (inferred from URI 'https://github.com/ebiggers/wimlib/archive/e59d1de0f439d91065df7c47f647f546728e6a24.tar.gz')
- UnknownKeywords: version 20250511: unknown KEYWORDS: 'x86'
- UnknownUseFlags: version 20250511: unknown USE flags: 'fuse', 'iso', 'ntfs', 'yasm'

## app-crypto/yubikey-manager
- MissingRemoteId: missing <remote-id type="github">Yubico/yubikey-manager</remote-id> (inferred from URI 'https://github.com/Yubico/yubikey-manager/archive/d0651ca4d17e7a27248a3468cf92da105394b1cf.tar.gz')
- EPyTestPluginsSuggestion: version 20251203: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- NonexistentDeps: version 20251203: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 20251203: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 20251203: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 20251203: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 20251203: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 20251203: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## app-fs/grub
- MissingRemoteId: missing <remote-id type="github">1g4-mirror/grub</remote-id> (inferred from URI 'https://github.com/1g4-mirror/grub/archive/6b5c671d35b1b84468da1fef2b9bd8e05682f7e6.tar.gz')
- UnknownUseFlags: version 20251011-r9: unknown USE flags: 'device-mapper', 'efi', 'grub_platforms_efi-64', 'grub_platforms_pc', 'mount'
- UnusedInherits: version 20251011-r9: unused eclasses: autotools, flag-o-matic
- VariableScope: version 20251011-r9: variable 'EROOT' used in 'src_prepare' on line: 93

## app-fs/parted
- MissingRemoteId: missing <remote-id type="github">1g4-mirror/parted</remote-id> (inferred from URI 'https://github.com/1g4-mirror/parted/archive/f124ddb0a2cd950d4a94fd99af1313dd6c283d75.tar.gz')
- UnknownUseFlags: version 20251024: unknown USE flag: 'device-mapper'
- UnusedInherits: version 20251024: unused eclass: autotools
- VariableScope: version 20251024: variable 'EROOT' used in 'src_prepare' on line: 46

## app-crypto/acme
- MissingRemoteId: missing <remote-id type="github">certbot/certbot</remote-id> (inferred from URI 'https://github.com/certbot/certbot/archive/8c4e3080ddd72123420f8882c8b96921c8d33304.tar.gz')
- EPyTestPluginsSuggestion: version 20251203: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- NonexistentDeps: version 20251203: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12, dev-python/sphinx-rtd-theme
- NonexistentDeps: version 20251203: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 20251203: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14, dev-python/sphinx-rtd-theme[python_targets_python3_11(-)], dev-python/sphinx-rtd-theme[python_targets_python3_12(-)], dev-python/sphinx-rtd-theme[python_targets_python3_13(-)], dev-python/sphinx-rtd-theme[python_targets_python3_14(-)] ]
- NonsolvableDepsInStable: version 20251203: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 20251203: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 20251203: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'
- VariableShadowed: version 20251203: variable 'SRC_URI' may be shadowed, on lines: 14, 16

## app-fs/cryptsetup
- MissingRemoteId: missing <remote-id type="gitlab">cryptsetup/cryptsetup/blob/master/README.md</remote-id> (inferred from URI 'https://gitlab.com/cryptsetup/cryptsetup/blob/master/README.md')
- UnknownUseFlags: version 20251128: unknown USE flags: 'argon2', 'urandom'
- UnusedInherits: version 20251128: unused eclass: doins

## app-fs/sshfs
- MissingRemoteId: missing <remote-id type="github">libfuse/sshfs</remote-id> (inferred from URI 'https://github.com/libfuse/sshfs')
- VariableOrderWrong: version 20251111: variable SLOT should occur before KEYWORDS

## app-crypto/cryptography
- MissingRemoteId: missing <remote-id type="github">pyca/cryptography</remote-id> (inferred from URI 'https://github.com/pyca/cryptography/')
- MissingRemoteId: missing <remote-id type="pypi">cryptography</remote-id> (inferred from URI 'https://files.pythonhosted.org/packages/source/c/cryptography/cryptography-45.0.7.tar.gz')
- EPyTestPluginsSuggestion: version 45.0.7: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- NonexistentDeps: version 45.0.7: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12, dev-python/iso8601, dev-python/pyasn1-modules, dev-python/pytest-subtests
- NonexistentDeps: version 45.0.7: DEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 45.0.7: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 45.0.7: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14, dev-python/iso8601[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], dev-python/pyasn1-modules[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], dev-python/pytest-subtests[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)] ]
- NonsolvableDepsInStable: version 45.0.7: nonsolvable depset(depend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 45.0.7: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 45.0.7: missing RDEPEND="${PYTHON_DEPS}"
- UnknownLicense: version 45.0.7: unknown licenses: Apache-2.0-with-LLVM-exceptions, Unicode-DFS-2016
- UnknownUseFlags: version 45.0.7: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## app-kernel/stable-sources
- MissingRemoteId: missing <remote-id type="gitlab">linux-kernel/stable</remote-id> (inferred from URI 'https://gitlab.com/linux-kernel/stable/-/archive/5439375ca6987ed27eba246a3b9e036357fd6ba2/stable-5439375ca6987ed27eba246a3b9e036357fd6ba2.tar.bz2')
- TrailingEmptyLine: version 6.17.20251206: ebuild has trailing blank line(s)
- UnknownUseFlags: version 6.17.20251206: unknown USE flag: 'symlink'

## app-fs/xfsprogs
- UnknownUseFlags: version 6.5.0: unknown USE flag: 'libedit'

## app-kernel/perf
- MissingRemoteId: missing <remote-id type="gitlab">linux-kernel/stable</remote-id> (inferred from URI 'https://gitlab.com/linux-kernel/stable/-/archive/5439375ca6987ed27eba246a3b9e036357fd6ba2/stable-5439375ca6987ed27eba246a3b9e036357fd6ba2.tar.bz2')
- UnknownUseFlags: version 6.17.20251206: unknown USE flag: 'bpf'
- UnusedInherits: version 6.17.20251206: unused eclass: toolchain-funcs

## app-kernel/linux-headers
- MissingRemoteId: missing <remote-id type="gitlab">linux-kernel/stable</remote-id> (inferred from URI 'https://gitlab.com/linux-kernel/stable/-/archive/5439375ca6987ed27eba246a3b9e036357fd6ba2/stable-5439375ca6987ed27eba246a3b9e036357fd6ba2.tar.bz2')
- BadDescription: version 6.17.20251206: empty/unset
- UnknownUseFlags: version 6.17.20251206: unknown USE flag: 'symlink'
- VariableOrderWrong: version 6.17.20251206: variable SLOT should occur before KEYWORDS

## app-fs/smartmontools
- MissingRemoteId: missing <remote-id type="github">smartmontools/smartmontools</remote-id> (inferred from URI 'https://github.com/smartmontools/smartmontools/archive/ded39d1ebe819292f145423cfff013f43072f447.tar.gz')
- DeprecatedInsinto: version 20251203: deprecated insinto usage (use systemd_dounit or systemd_newunit from systemd.eclass instead), line 66: insinto /usr/lib/systemd/system
- NonexistentDeps: version 20251203: RDEPEND: nonexistent packages: app-core/subversion, app-var/lynx
- UnknownUseFlags: version 20251203: unknown USE flags: 'daemon', 'update_drivedb'
- UnnecessarySlashStrip: version 20251203: ${ED%/} unnecessary slash strip on line: 96

## app-lang/lua
- MissingRemoteId: missing <remote-id type="github">lua/lua</remote-id> (inferred from URI 'https://github.com/lua/lua/archive/934fdd481ced3a9d4a7aaace4479ce889ab23582.tar.gz')

## app-lang/luajit
- MissingRemoteId: missing <remote-id type="github">LuaJIT/LuaJIT</remote-id> (inferred from URI 'https://github.com/LuaJIT/LuaJIT/archive/6f21cb8ace60b297cd144c3b6925865b043095d2.tar.gz')

## app-lang/nasm
- MissingRemoteId: missing <remote-id type="github">netwide-assembler/nasm</remote-id> (inferred from URI 'https://github.com/netwide-assembler/nasm/archive/e2ccd5de268fc4bda5aa4313a79859827c3adc82.tar.gz')
- UnusedInherits: version 2.16.20250813: unused eclass: autotools
- WhitespaceFound: version 2.16.20250813: ebuild has leading whitespace on lines: 22, 23, 24, 25, 26, 27

## app-dev/openai
- MissingRemoteId: missing <remote-id type="github">openai/openai-python</remote-id> (inferred from URI 'https://github.com/openai/openai-python')
- NonexistentDeps: version 20251117: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 20251117: DEPEND: nonexistent packages: >=dev-python/pandas-1.2.3, >=dev-python/pandas-stubs-1.1.0.11
- NonexistentDeps: version 20251117: RDEPEND: nonexistent packages: >=dev-python/pandas-1.2.3, >=dev-python/pandas-stubs-1.1.0.11, app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 20251117: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 20251117: nonsolvable depset(depend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ dev-py/numpy[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], >=dev-python/pandas-1.2.3[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], >=dev-python/pandas-stubs-1.1.0.11[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)] ]
- NonsolvableDepsInStable: version 20251117: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14, dev-py/numpy[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], >=dev-python/pandas-1.2.3[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], >=dev-python/pandas-stubs-1.1.0.11[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)] ]
- PythonMissingDeps: version 20251117: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 20251117: unknown USE flags: 'datalib', 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## app-lang/erlang
- MissingRemoteId: missing <remote-id type="github">erlang/otp</remote-id> (inferred from URI 'https://github.com/erlang/otp')
- UnknownUseFlags: version 20251203: unknown USE flags: 'java', 'kpoll', 'odbc', 'sctp', 'tk', 'wxwidgets'

## app-lang/sassc
- MissingRemoteId: missing <remote-id type="github">sass/sassc</remote-id> (inferred from URI 'https://github.com/sass/sassc')
- UnknownKeywords: version 3.6.2: unknown KEYWORDS: 'x86', '~amd64-linux', '~arm', '~ia64', '~loong', '~ppc', '~ppc64', '~riscv'

## app-lang/ruby
- UnknownUseFlags: version 3.4.3: unknown USE flags: 'jemalloc', 'socks5'

## app-lang/python-exec
- MissingRemoteId: missing <remote-id type="github">mgorny/python-exec</remote-id> (inferred from URI 'https://github.com/mgorny/python-exec/')
- InternalEclassUsage: version 20230320: python-utils-r1: internal usage: '_PYTHON_ALL_IMPLS', line 18
- InternalEclassUsage: version 20230320: python-utils-r1: internal usage: '_PYTHON_ALL_IMPLS', line 29
- InternalEclassUsage: version 20230320: python-utils-r1: internal usage: '_python_export "${i}" EPYTHON', line 31
- UnknownUseFlags: version 20230320: unknown USE flags: 'native-symlinks', 'python_targets_pypy3_11', 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_13t', 'python_targets_python3_14', 'python_targets_python3_14t'

## app-kernel/r8125
- MissingRemoteId: missing <remote-id type="github">Karlson2k/r8125</remote-id> (inferred from URI 'https://github.com/Karlson2k/r8125/releases/download/9.016.01/r8125-9.016.01.tar.bz2')
- IndirectInherits: version 9.016.01: linux-info: indirect inherit usage: 'KV_DIR', line 34
- UnknownUseFlags: version 9.016.01: unknown USE flags: 'initramfs', 'modules-compress', 'modules-sign', 'multi-tx-q', 'ptp', 'rss', 'strip', 'use-firmware'

## app-lang/uasm
- MissingRemoteId: missing <remote-id type="github">Terraspace/UASM</remote-id> (inferred from URI 'https://github.com/Terraspace/UASM/archive/1b95cb75aa118f5af1b379e1d9f0eb152b0d7e0c.tar.gz')

## app-lang/yasm
- MissingRemoteId: missing <remote-id type="github">yasm/yasm</remote-id> (inferred from URI 'https://github.com/yasm/yasm/archive/121ab150b3577b666c79a79f4a511798d7ad2432.tar.gz')
- UnusedInherits: version 20240624: unused eclass: flag-o-matic

## app-kernel/kernel-hardening-checker
- MissingRemoteId: missing <remote-id type="github">a13xp0p0v/kernel-hardening-checker</remote-id> (inferred from URI 'https://github.com/a13xp0p0v/kernel-hardening-checker')
- MisplacedEclassVar: version 20251124: invalid pre-inherit placement, line 7: 'DISTUTILS_USE_PEP517=setuptools'
- NonexistentDeps: version 20251124: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 20251124: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 20251124: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 20251124: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 20251124: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 20251124: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## app-lang/swig
- MissingRemoteId: missing <remote-id type="github">swig/swig</remote-id> (inferred from URI 'https://github.com/swig/swig/archive/f8611c6288dfc38f838e9eab61aa802c46b21189.tar.gz')
- UnknownUseFlags: version 4.3.20250414: unknown USE flag: 'ccache'

## app-lang/tcl
- MissingRemoteId: missing <remote-id type="github">tcltk/tcl</remote-id> (inferred from URI 'https://github.com/tcltk/tcl/archive/edf7bfbf3fb009c47cf0f542c6eea69658af32d3.tar.gz')
- WhitespaceFound: version 8.6.20251125: ebuild has leading whitespace on lines: 47, 48, 49, 50, 52

## app-net/cyrus-sasl
- MissingRemoteId: missing <remote-id type="github">cyrusimap/cyrus-sasl</remote-id> (inferred from URI 'https://github.com/cyrusimap/cyrus-sasl/archive/ac0c278817a082c625c496ec812318c019e0b96f.tar.gz')

## app-build/llvm
- MissingRemoteId: missing <remote-id type="github">llvm/llvm-project</remote-id> (inferred from URI 'https://github.com/llvm/llvm-project/archive/f68f64eb81305724d7649814f61103936c903ca6.tar.gz')
- BadDefaultUseFlags: version 14.20220622: bad default USE flag: '-sysclang'
- DoubleEmptyLine: version 14.20220622: ebuild has unneeded empty line on line: 173
- IndirectInherits: version 14.20220622: toolchain-funcs: indirect inherit usage: 'tc-get-c-rtlib', line 53
- UnknownUseFlags: version 14.20220622: unknown USE flags: 'amdgpu', 'arm', 'assertions', 'bootstrap', 'bpf', 'libcxx', 'libcxxabi', 'libfuzzer', 'nvptx', 'orc', 'sanitizers', 'static_analyzer', 'sysclang', 'syslibcxxabi', 'wasm', 'xcore'
- WhitespaceFound: version 14.20220622: ebuild has leading whitespace on lines: 23, 24, 25, 33, 37, 38, 42, 44, 45, 46, 47, 48, 51, 52, 53, 55, 56, 57, 58, 59, 60, 61, 62, 63, 65, 66, 68, 69, 71, 72, 74, 75, 76, 77, 78, 80, 81, 82, 83, 84, 85, 87, 90, 163, 165, 171, 181, 183, 191, 193, 194, 195, 196, 203, 205, 206, 207, 208, 209, 210, 211, 212, 213, 218, 219, 221, 222, 223, 224, 225, 226, 227, 229, 230, 231, 232, 233, 234, 235, 236, 238, 239, 243, 244, 248, 250, 265, 267, 274
- BadDefaultUseFlags: version 17.20231128: bad default USE flag: '-sysclang'
- DoubleEmptyLine: version 17.20231128: ebuild has unneeded empty line on line: 173
- IndirectInherits: version 17.20231128: toolchain-funcs: indirect inherit usage: 'tc-get-c-rtlib', line 53
- UnknownUseFlags: version 17.20231128: unknown USE flags: 'amdgpu', 'arm', 'assertions', 'bootstrap', 'bpf', 'cuda', 'libcxx', 'libcxxabi', 'libfuzzer', 'nvptx', 'orc', 'sanitizers', 'static_analyzer', 'sysclang', 'syslibcxxabi', 'wasm', 'xcore'
- WhitespaceFound: version 17.20231128: ebuild has leading whitespace on lines: 23, 24, 25, 33, 37, 38, 42, 44, 45, 46, 47, 48, 51, 52, 53, 55, 56, 57, 58, 59, 60, 61, 62, 63, 65, 66, 68, 69, 71, 72, 74, 75, 76, 77, 78, 80, 81, 82, 83, 84, 85, 87, 90, 163, 165, 171, 181, 183, 191, 193, 194, 195, 196, 203, 205, 206, 207, 208, 209, 210, 211, 212, 213, 218, 219, 221, 222, 223, 224, 225, 226, 227, 229, 230, 231, 232, 233, 234, 235, 236, 238, 239, 243, 244, 248, 250, 265, 267, 274
- BadDefaultUseFlags: version 18.20240615: bad default USE flag: '-sysclang'
- DoubleEmptyLine: version 18.20240615: ebuild has unneeded empty line on line: 173
- IndirectInherits: version 18.20240615: toolchain-funcs: indirect inherit usage: 'tc-get-c-rtlib', line 53
- UnknownUseFlags: version 18.20240615: unknown USE flags: 'amdgpu', 'arm', 'assertions', 'bootstrap', 'bpf', 'cuda', 'libcxx', 'libcxxabi', 'libfuzzer', 'nvptx', 'orc', 'sanitizers', 'static_analyzer', 'sysclang', 'syslibcxxabi', 'wasm', 'xcore'
- WhitespaceFound: version 18.20240615: ebuild has leading whitespace on lines: 23, 24, 25, 33, 37, 38, 42, 44, 45, 46, 47, 48, 51, 52, 53, 55, 56, 57, 58, 59, 60, 61, 62, 63, 65, 66, 68, 69, 71, 72, 74, 75, 76, 77, 78, 80, 81, 82, 83, 84, 85, 87, 90, 163, 165, 171, 181, 183, 191, 193, 194, 195, 196, 203, 205, 206, 207, 208, 209, 210, 211, 212, 213, 218, 219, 221, 222, 223, 224, 225, 226, 227, 229, 230, 231, 232, 233, 234, 235, 236, 238, 239, 243, 244, 248, 250, 265, 267, 274
- BadDefaultUseFlags: version 19.20250114: bad default USE flag: '-sysclang'
- DoubleEmptyLine: version 19.20250114: ebuild has unneeded empty line on line: 179
- IndirectInherits: version 19.20250114: toolchain-funcs: indirect inherit usage: 'tc-get-c-rtlib', line 54
- UnknownUseFlags: version 19.20250114: unknown USE flags: 'amdgpu', 'arm', 'assertions', 'bootstrap', 'bpf', 'clang-tools-extra', 'cuda', 'libcxx', 'libcxxabi', 'libfuzzer', 'nvptx', 'orc', 'sanitizers', 'static_analyzer', 'sysclang', 'syslibcxxabi', 'wasm', 'xcore'
- WhitespaceFound: version 19.20250114: ebuild has leading whitespace on lines: 24, 25, 26, 34, 38, 39, 43, 45, 46, 47, 48, 49, 52, 53, 54, 56, 57, 58, 59, 60, 61, 62, 63, 64, 66, 67, 69, 70, 72, 73, 75, 76, 77, 78, 79, 81, 82, 83, 84, 85, 86, 88, 89, 91, 95, 169, 171, 177, 187, 189, 197, 199, 200, 201, 202, 209, 211, 212, 213, 214, 215, 216, 217, 218, 219, 224, 225, 227, 228, 229, 230, 231, 232, 233, 235, 236, 237, 238, 239, 240, 241, 242, 244, 245, 249, 250, 254, 256, 271, 273, 280
- BadDefaultUseFlags: version 20.20250708: bad default USE flag: '-sysclang'
- DoubleEmptyLine: version 20.20250708: ebuild has unneeded empty line on line: 178
- IndirectInherits: version 20.20250708: toolchain-funcs: indirect inherit usage: 'tc-get-c-rtlib', line 53
- UnknownUseFlags: version 20.20250708: unknown USE flags: 'amdgpu', 'arm', 'assertions', 'bootstrap', 'bpf', 'clang-tools-extra', 'cuda', 'libcxx', 'libcxxabi', 'libfuzzer', 'nvptx', 'orc', 'sanitizers', 'static_analyzer', 'sysclang', 'syslibcxxabi', 'wasm', 'xcore'
- WhitespaceFound: version 20.20250708: ebuild has leading whitespace on lines: 23, 24, 25, 33, 37, 38, 42, 44, 45, 46, 47, 48, 51, 52, 53, 55, 56, 57, 58, 59, 60, 61, 62, 63, 65, 66, 68, 69, 71, 72, 74, 75, 76, 77, 78, 80, 81, 82, 83, 84, 85, 87, 88, 90, 94, 168, 170, 176, 186, 188, 196, 198, 199, 200, 201, 208, 210, 211, 212, 213, 214, 215, 216, 217, 218, 223, 224, 226, 227, 228, 229, 230, 231, 232, 234, 235, 236, 237, 238, 239, 240, 241, 243, 244, 248, 249, 253, 255, 270, 272, 279
- BadDefaultUseFlags: version 21.20251202: bad default USE flag: '-sysclang'
- DoubleEmptyLine: version 21.20251202: ebuild has unneeded empty line on line: 195
- IndirectInherits: version 21.20251202: toolchain-funcs: indirect inherit usage: 'tc-get-c-rtlib', line 69
- UnknownUseFlags: version 21.20251202: unknown USE flags: 'amdgpu', 'arm', 'assertions', 'bootstrap', 'bpf', 'clang-tools-extra', 'cuda', 'libcxx', 'libcxxabi', 'libfuzzer', 'nvptx', 'orc', 'sanitizers', 'static_analyzer', 'sysclang', 'syslibcxxabi', 'wasm', 'xcore'
- WhitespaceFound: version 21.20251202: ebuild has leading whitespace on lines: 23, 24, 25, 33, 37, 38, 39, 41, 42, 43, 44, 46, 47, 48, 50, 52, 53, 54, 58, 60, 61, 62, 63, 64, 67, 68, 69, 71, 72, 73, 74, 75, 76, 77, 78, 79, 81, 82, 83, 85, 86, 88, 89, 91, 92, 93, 94, 95, 97, 98, 99, 100, 101, 102, 104, 105, 107, 111, 185, 187, 193, 203, 205, 213, 215, 216, 217, 218, 225, 227, 228, 229, 230, 231, 232, 233, 234, 235, 240, 241, 243, 244, 245, 246, 247, 248, 249, 251, 252, 253, 254, 255, 256, 257, 258, 260, 261, 265, 266, 270, 272, 287, 289, 296

## app-kernel/dracut
- MissingRemoteId: missing <remote-id type="github">dracut-ng/dracut-ng</remote-id> (inferred from URI 'https://github.com/dracut-ng/dracut-ng/archive/30d121b1bd4ad2fb26ea72e1b0d5581663179882.tar.gz')
- NonexistentBlocker: version 20251203: nonexistent blocker RDEPEND="!app-net/arping": no matches in repo history

## app-lang/perl
- MissingRemoteId: missing <remote-id type="github">Perl/perl5</remote-id> (inferred from URI 'https://github.com/Perl/perl5/archive/46977a16be5c4752a072588cf7e941f88f2b7e84.tar.gz')
- UnusedInherits: version 5.40.20250803: unused eclasses: flag-o-matic, multiprocessing, toolchain-funcs
- VariableScope: version 5.40.20250803: variable 'EROOT' used in 'src_compile' on lines: 114, 115

## app-net/bpftool
- MissingRemoteId: missing <remote-id type="github">libbpf/bpftool</remote-id> (inferred from URI 'https://github.com/libbpf/bpftool')
- NonexistentDeps: version 9999: BDEPEND: nonexistent package: dev-python/docutils
- NonsolvableDepsInStable: version 9999: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ dev-python/docutils ]
- UnknownUseFlags: version 9999: unknown USE flags: 'clang', 'llvm'
- VisibleVcsPkg: version 9999: VCS version visible for KEYWORDS="amd64", profile core/amd64/glibc (16 total)

## app-net/dhcpcd
- MissingRemoteId: missing <remote-id type="github">NetworkConfiguration/dhcpcd</remote-id> (inferred from URI 'https://github.com/NetworkConfiguration/dhcpcd/')
- DeprecatedInsinto: version 20251203: deprecated insinto usage (use systemd_dounit or systemd_newunit from systemd.eclass instead), line 43: insinto /usr/lib/systemd/system
- UnknownUseFlags: version 20251203: unknown USE flag: 'embedded'
- UnusedInherits: version 20251203: unused eclass: toolchain-funcs

## app-fs/testdisk
- MissingRemoteId: missing <remote-id type="github">cgsecurity/testdisk</remote-id> (inferred from URI 'https://github.com/cgsecurity/testdisk/archive/e408f3d2bc820bddfc20b868fc336ab8eb0875ec.tar.gz')
- BadDescription: version 20251004: over 80 chars in length
- MissingUseDepDefault: version 20251004: DEPEND="app-core/util-linux[static-libs]": USE flag 'static-libs' missing from package: [ app-core/util-linux-2.41.20251009 ]
- MissingUseDepDefault: version 20251004: RDEPEND="app-core/util-linux[static-libs]": USE flag 'static-libs' missing from package: [ app-core/util-linux-2.41.20251009 ]
- NonsolvableDepsInStable: version 20251004: nonsolvable depset(depend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-core/util-linux[static-libs] ]
- NonsolvableDepsInStable: version 20251004: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-core/util-linux[static-libs] ]
- UnknownUseFlags: version 20251004: unknown USE flag: 'ntfs'

## app-net/iperf
- MissingRemoteId: missing <remote-id type="github">esnet/iperf</remote-id> (inferred from URI 'https://github.com/esnet/iperf')

## app-lang/tk
- MissingRemoteId: missing <remote-id type="github">tcltk/tk</remote-id> (inferred from URI 'https://github.com/tcltk/tk/archive/f0d192fa456c6e5b4f83b340a99f880b71dd124c.tar.gz')
- WhitespaceFound: version 8.6.20251126: ebuild has leading whitespace on line: 33

## app-net/dropbear
- MissingRemoteId: missing <remote-id type="github">mkj/dropbear</remote-id> (inferred from URI 'https://github.com/mkj/dropbear/archive/7b8e47a74398efbef02429825c0e37d835cc9eef.tar.gz')
- DeprecatedInsinto: version 20251112: deprecated insinto usage (use systemd_dounit or systemd_newunit from systemd.eclass instead), line 41: insinto /usr/lib/systemd/system
- UnknownUseFlags: version 20251112: unknown USE flags: 'bsdpty', 'shadow', 'syslog'

## app-net/ethtool
- MissingRemoteId: missing <remote-id type="github">1g4-mirror/ethtool</remote-id> (inferred from URI 'https://github.com/1g4-mirror/ethtool/archive/3a14b8c15fce0fa3e673e913593e507a664ca75c.tar.gz')

## app-dev/gcovr
- MissingRemoteId: missing <remote-id type="github">gcovr/gcovr</remote-id> (inferred from URI 'https://github.com/gcovr/gcovr')
- EPyTestPluginsSuggestion: version 8.4: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- NonexistentDeps: version 8.4: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12, dev-python/yaxmldiff
- NonexistentDeps: version 8.4: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 8.4: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14, dev-python/yaxmldiff[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)] ]
- NonsolvableDepsInStable: version 8.4: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 8.4: missing RDEPEND="${PYTHON_DEPS}"
- PythonMissingSCMDependency: version 8.4: defines SETUPTOOLS_SCM_PRETEND_VERSION but is missing BDEPEND on setuptools-scm or alike
- UnknownUseFlags: version 8.4: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## app-net/hping
- MissingRemoteId: missing <remote-id type="github">jopamo/hping</remote-id> (inferred from URI 'https://github.com/jopamo/hping/archive/4a444edd6d883f62869f6afe977d36b427b51bc2.tar.gz')
- UnknownUseFlags: version 20250717: unknown USE flag: 'tcl'
- UnusedInherits: version 20250717: unused eclass: flag-o-matic

## app-net/ipset
- MissingRemoteId: missing <remote-id type="github">1g4-mirror/ipset</remote-id> (inferred from URI 'https://github.com/1g4-mirror/ipset/archive/b2556d84456810fe35f9a287d6f879f4611a6059.tar.gz')

## app-net/bind-tools
- MissingRemoteId: missing <remote-id type="github">isc-projects/bind9</remote-id> (inferred from URI 'https://github.com/isc-projects/bind9/archive/723439908acb4522274184b49428c86551bd2937.tar.gz')
- UnknownUseFlags: version 20250806: unknown USE flags: 'doh', 'fips', 'geoip'
- UnusedInherits: version 20250806: unused eclass: flag-o-matic
- WhitespaceFound: version 20250806: ebuild has leading whitespace on lines: 45, 58, 59

## app-net/aircrack-ng
- MissingRemoteId: missing <remote-id type="github">aircrack-ng/aircrack-ng</remote-id> (inferred from URI 'https://github.com/aircrack-ng/aircrack-ng/archive/f333a6a767dc83c7da352de59dbca402fe3bf70c.tar.gz')
- UnknownUseFlags: version 20250727: unknown USE flags: 'airdrop-ng', 'airgraph-ng', 'experimental', 'netlink'
- VariableScope: version 20250727: variable 'ED' used in 'pkg_setup' on line: 44

## app-lang/php
- MissingRemoteId: missing <remote-id type="github">php/php-src</remote-id> (inferred from URI 'https://github.com/php/php-src/archive/2521c348da685e97108443754b8165a3051b3474.tar.gz')
- SizeViolation: 'files/www.conf' exceeds 20.0 KiB in size; 20.4 KiB total
- DeprecatedInsinto: version 8.4.20251203: deprecated insinto usage (use systemd_dounit or systemd_newunit from systemd.eclass instead), line 127: insinto /usr/lib/systemd/system
- NonexistentDeps: version 8.4.20251203: DEPEND: nonexistent packages: lib-core/libpcre, lib-dev/oniguruma
- NonsolvableDepsInStable: version 8.4.20251203: nonsolvable depset(depend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ lib-core/libpcre, lib-dev/oniguruma ]
- UnknownUseFlags: version 8.4.20251203: unknown USE flags: 'fpm', 'tmpfilesd'
- VisibleVcsPkg: version 8.4.20251203: VCS version visible for KEYWORDS="amd64", profile core/amd64/glibc (16 total)

## app-net/iputils
- MissingRemoteId: missing <remote-id type="github">iputils/iputils</remote-id> (inferred from URI 'https://github.com/iputils/iputils/archive/d546847a8cca6834e3c9382b876488b1428209c4.tar.gz')
- UnknownUseFlags: version 20251125: unknown USE flags: 'arping', 'clockdiff', 'ping', 'tracepath'

## app-net/mailbase
- RedundantDodir: version 1.2: dodir called before insinto, line 27: dodir /etc/mail
- AbsoluteSymlink: version 1.2: dosym called with absolute path on line 36: dosym /var/spool/mail
- VariableOrderWrong: version 1.2: variable S should occur before IUSE

## app-net/curl
- MissingRemoteId: missing <remote-id type="github">curl/curl</remote-id> (inferred from URI 'https://github.com/curl/curl/archive/276a4af4741c7ac5f4e24b22458146ebab049dcd.tar.gz')
- MissingTestRestrict: version 20251203: missing RESTRICT="!test? ( test )" with IUSE=test
- MissingUseDepDefault: version 20251203: DEPEND="lib-net/libssh[static-libs?]": USE flag 'static-libs' missing from package: [ lib-net/libssh-20251125 ]
- NonexistentDeps: version 20251203: DEPEND: nonexistent packages: lib-net/mbedtls, lib-net/nghttp2
- NonsolvableDepsInStable: version 20251203: nonsolvable depset(depend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ lib-net/libssh[static-libs], lib-net/mbedtls, lib-net/nghttp2[static-libs] ]
- UnknownUseFlags: version 20251203: unknown USE flags: 'adns', 'brotli', 'libpsl', 'mbedtls', 'nghttp2', 'ssh'
- WhitespaceFound: version 20251203: ebuild has leading whitespace on lines: 77, 79, 84, 91, 93

## app-net/netcat
- MissingRemoteId: missing <remote-id type="github">jopamo/netcat</remote-id> (inferred from URI 'https://github.com/jopamo/netcat/archive/bd1ef015e011421f0494cbf28835ccdf5ec6765d.tar.gz')
- UnknownUseFlags: version 20250614: unknown USE flags: 'exec_hole', 'telnet', 'verbose_debug'

## app-net/openldap
- MissingRemoteId: missing <remote-id type="github">openldap/openldap</remote-id> (inferred from URI 'https://github.com/openldap/openldap/archive/e40c938151fd845b63b05ee29608029cc0a7770e.tar.gz')
- UnknownLicense: version 2.6.20251125: unknown licenses: License, Public
- UnusedInherits: version 2.6.20251125: unused eclass: autotools

## app-net/netsniff-ng
- MissingRemoteId: missing <remote-id type="github">netsniff-ng/netsniff-ng</remote-id> (inferred from URI 'https://github.com/netsniff-ng/netsniff-ng/archive/1af7ae33e3e8178ab5c649c3a52838d4375c4228.tar.gz')
- UnknownUseFlags: version 20250611: unknown USE flag: 'geoip'
- UnusedInherits: version 20250611: unused eclasses: autotools, flag-o-matic

## app-net/realmd-adcli
- MissingRemoteId: missing <remote-id type="freedesktop-gitlab">realmd/adcli</remote-id> (inferred from URI 'https://gitlab.freedesktop.org/realmd/adcli/-/archive/9177c1ada55030f82e6f36407538ee79e211bec0/adcli-9177c1ada55030f82e6f36407538ee79e211bec0.tar.bz2')
- MissingRemoteId: missing <remote-id type="github">freedesktop/realmd-adcli</remote-id> (inferred from URI 'https://github.com/freedesktop/realmd-adcli')

## app-net/seatd
- MissingRemoteId: missing <remote-id type="github">kennylevinsen/seatd</remote-id> (inferred from URI 'https://github.com/kennylevinsen/seatd/archive/99b8e39faf2b92068ce2572a54391c136c48d101.tar.gz')
- MissingRemoteId: missing <remote-id type="sourcehut">~kennylevinsen/seatd</remote-id> (inferred from URI 'https://sr.ht/~kennylevinsen/seatd')
- DeprecatedInsinto: version 20251129: deprecated insinto usage (use systemd_dounit or systemd_newunit from systemd.eclass instead), line 23: insinto /usr/lib/systemd/system

## app-net/knock
- MissingRemoteId: missing <remote-id type="github">jvinet/knock</remote-id> (inferred from URI 'https://github.com/jvinet/knock/archive/cb163f1509f57698c40a1bd8d1d6891af608a18b.tar.gz')
- UnknownUseFlags: version 20210428: unknown USE flag: 'knockd'

## app-net/iptables
- MissingRemoteId: missing <remote-id type="github">1g4-mirror/iptables</remote-id> (inferred from URI 'https://github.com/1g4-mirror/iptables/archive/c3d5053db05f99bd72219aebeefc7fb0195ac041.tar.gz')
- UnknownUseFlags: version 20250825: unknown USE flags: 'conntrack', 'netlink', 'nftables', 'pcap'

## app-net/s-nail
- VariableOrderWrong: version 14.9.24: variable DESCRIPTION should occur before HOMEPAGE
- VariableScope: version 14.9.24: variable 'EROOT' used in 'src_configure' on line: 15

## app-net/traceroute
- MissingRemoteId: missing <remote-id type="github">jopamo/traceroute</remote-id> (inferred from URI 'https://github.com/jopamo/traceroute/archive/9b6de003f20b8160991ec13bb8bf97f3ff94fec7.tar.gz')
- MissingRemoteId: missing <remote-id type="sourceforge">traceroute</remote-id> (inferred from URI 'https://traceroute.sourceforge.net/')
- NonexistentBlocker: version 20251028: nonexistent blocker RDEPEND="!net-misc/iputils[traceroute6(-)]": no matches in repo history

## app-net/proton-bridge
- MissingRemoteId: missing <remote-id type="github">ProtonMail/proton-bridge</remote-id> (inferred from URI 'https://github.com/ProtonMail/proton-bridge')

## app-net/tcpdump
- MissingRemoteId: missing <remote-id type="github">the-tcpdump-group/tcpdump</remote-id> (inferred from URI 'https://github.com/the-tcpdump-group/tcpdump')
- UnknownUseFlags: version 20251126: unknown USE flags: 'samba', 'smi', 'suid'

## app-net/socat
- DoubleEmptyLine: version 20250221: ebuild has unneeded empty line on line: 51
- WhitespaceFound: version 20250221: ebuild has leading whitespace on lines: 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49

## app-net/iw
- MissingRemoteId: missing <remote-id type="github">1g4-mirror/iw</remote-id> (inferred from URI 'https://github.com/1g4-mirror/iw/archive/b9f9dda5898bd03ae679922e424097f556351790.tar.gz')

## app-net/lynx
- MissingRemoteId: missing <remote-id type="github">ThomasDickey/lynx-snapshots</remote-id> (inferred from URI 'https://github.com/ThomasDickey/lynx-snapshots/archive/cdfcfe75387c3071f34656b315af839527fae6d5.tar.gz')
- UnknownUseFlags: version 20250917: unknown USE flags: 'brotli', 'cjk', 'gnutls', 'idn'

## app-net/nmap
- MissingRemoteId: missing <remote-id type="github">nmap/nmap</remote-id> (inferred from URI 'https://github.com/nmap/nmap/archive/472b5867679a5ddffd80f0513c97246257a6bbb9.tar.gz')
- ExcessiveLineLength: version 20251202: excessive line length (over 120 characters) on line: 66
- UnknownUseFlags: version 20251202: unknown USE flags: 'libssh2', 'ncat', 'nping', 'nselib', 'os-db', 'scripts'
- VariableScope: version 20251202: variable 'EROOT' used in 'src_configure' on lines: 55, 56, 57, 58, 59, 60

## app-port/genup
- MissingRemoteId: missing <remote-id type="github">jopamo/genup</remote-id> (inferred from URI 'https://github.com/jopamo/genup')
- ReferenceInMetadataVar: version 9999: HOMEPAGE includes variable: ${PN}
- VisibleVcsPkg: version 9999: VCS version visible for KEYWORDS="amd64", profile core/amd64/glibc (16 total)

## app-net/mailutils
- NonexistentDeps: version 3.16: DEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 3.16: nonsolvable depset(depend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 3.16: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 3.16: unknown USE flags: 'dotlock', 'frm', 'mailbox-imap', 'mailbox-maildir', 'mailbox-mh', 'mailbox-pop', 'messages', 'mh', 'mimeview', 'movemail', 'python_single_target_python3_11', 'python_single_target_python3_12', 'python_single_target_python3_13', 'python_single_target_python3_14', 'readmsg', 'sendmail', 'servers', 'sieve', 'smtp', 'virtual-domains'
- UnusedInherits: version 3.16: unused eclass: toolchain-funcs

## app-net/rsync
- MissingRemoteId: missing <remote-id type="github">RsyncProject/rsync</remote-id> (inferred from URI 'https://github.com/RsyncProject/rsync/archive/797e17fc4a6f15e3b1756538a9f812b63942686f.tar.gz')
- UnknownUseFlags: version 20250823: unknown USE flag: 'xxhash'
- VariableScope: version 20250823: variable 'EROOT' used in 'src_prepare' on line: 37

## app-port/elt-patches
- MissingRemoteId: missing <remote-id type="github">gentoo/elt-patches</remote-id> (inferred from URI 'https://github.com/gentoo/elt-patches/archive/132ff07d38d8a5dd6d86b166f26bc473070ecfa4.tar.gz')

## app-server/easy-rsa
- MissingRemoteId: missing <remote-id type="github">OpenVPN/easy-rsa</remote-id> (inferred from URI 'https://github.com/OpenVPN/easy-rsa/archive/v3.2.4.tar.gz')

## app-net/wireguard-tools
- NonexistentDeps: version 9999: DEPEND: nonexistent package: app-net/openresolv
- NonsolvableDepsInStable: version 9999: nonsolvable depset(depend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-net/openresolv ]
- UnknownUseFlags: version 9999: unknown USE flag: 'wg-quick'
- VisibleVcsPkg: version 9999: VCS version visible for KEYWORDS="amd64", profile core/amd64/glibc (16 total)

## app-server/dnsmasq
- MissingRemoteId: missing <remote-id type="github">1g4-mirror/dnsmasq</remote-id> (inferred from URI 'https://github.com/1g4-mirror/dnsmasq/archive/ee09f0655c0a4347a72d2bf9b7231ff158a13f53.tar.gz')
- DeprecatedInsinto: version 20250901: deprecated insinto usage (use systemd_dounit or systemd_newunit from systemd.eclass instead), line 105: insinto /usr/lib/systemd/system
- UnknownUseFlags: version 20250901: unknown USE flags: 'auth-dns', 'conntrack', 'dhcp', 'dhcp-tools', 'dnssec', 'dumpfile', 'id', 'inotify', 'ipset', 'script', 'tftp'

## app-server/openvpn
- MissingRemoteId: missing <remote-id type="github">OpenVPN/openvpn</remote-id> (inferred from URI 'https://github.com/OpenVPN/openvpn/archive/da51cc458716605d0d19be9486b8ee08fc6a9e06.tar.gz')
- UnknownUseFlags: version 20251201: unknown USE flag: 'plugins'
- WhitespaceFound: version 20251201: ebuild has leading whitespace on lines: 23, 29, 30, 31, 32

## app-server/proxychains
- MissingRemoteId: missing <remote-id type="github">rofl0r/proxychains-ng</remote-id> (inferred from URI 'https://github.com/rofl0r/proxychains-ng/')

## app-server/containerd
- MissingRemoteId: missing <remote-id type="github">containerd/containerd</remote-id> (inferred from URI 'https://github.com/containerd/containerd/archive/3127f06ba961d5f9878feb6b81fadc43a415d6cf.tar.gz')
- DeprecatedInsinto: version 2.1.20251201: deprecated insinto usage (use systemd_dounit or systemd_newunit from systemd.eclass instead), line 64: insinto /usr/lib/systemd/system
- UnknownUseFlags: version 2.1.20251201: unknown USE flags: 'apparmor', 'btrfs', 'cri', 'device-mapper'

## app-server/haproxy
- MissingRemoteId: missing <remote-id type="github">haproxy/haproxy</remote-id> (inferred from URI 'https://github.com/haproxy/haproxy/archive/cdca48b88c02de195d7011cb6e9ac87e52dd863b.tar.gz')
- DeprecatedInsinto: version 20251203: deprecated insinto usage (use systemd_dounit or systemd_newunit from systemd.eclass instead), line 94: insinto /usr/lib/systemd/system
- UnknownUseFlags: version 20251203: unknown USE flags: '51degrees', 'net_ns', 'pcre2', 'pcre2-jit', 'tools', 'vim-syntax', 'wurfl'
- WhitespaceFound: version 20251203: ebuild has leading whitespace on lines: 20, 21, 22, 23, 24, 25, 26, 30, 31, 35, 36, 38, 39, 40, 41, 45, 46, 47, 48, 49, 50, 51, 55, 56, 57, 58, 59, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 77, 79, 81, 82, 83, 85, 86, 87, 91, 93, 94, 95, 96, 97, 99, 100, 101, 102, 103

## app-lang/go
- MissingRemoteId: missing <remote-id type="github">golang/go</remote-id> (inferred from URI 'https://github.com/golang/go/archive/d5bfdcbc47c4ab7943ce40ad34d0d4acf13cb33d.tar.gz')

## app-server/shadowsocks-rust
- MissingRemoteId: missing <remote-id type="github">shadowsocks/shadowsocks-rust</remote-id> (inferred from URI 'https://github.com/shadowsocks/shadowsocks-rust')
- RedundantDodir: version 20251203: dodir called before insinto, line 29: dodir "/etc/shadowsocks"
- DeprecatedInsinto: version 20251203: deprecated insinto usage (use systemd_dounit or systemd_newunit from systemd.eclass instead), line 34: insinto /usr/lib/systemd/system

## app-net/wpa_supplicant
- MissingRemoteId: missing <remote-id type="github">1g4-mirror/hostap</remote-id> (inferred from URI 'https://github.com/1g4-mirror/hostap/archive/9c969af8d6d79965aeb59020532722153168408f.tar.gz')
- DeprecatedInsinto: version 20251031: deprecated insinto usage (use systemd_dounit or systemd_newunit from systemd.eclass instead), line 285: insinto /usr/lib/systemd/system
- DeprecatedInsinto: version 20251031: deprecated insinto usage (use systemd_dounit or systemd_newunit from systemd.eclass instead), line 297: insinto /usr/lib/systemd/system
- ExcessiveLineLength: version 20251031: excessive line length (over 120 characters) on lines: 52, 58
- UnknownUseFlags: version 20251031: unknown USE flags: 'ap', 'eapol_test', 'fasteap', 'gnutls', 'hs2-0', 'p2p', 'privsep', 'smartcard', 'tdls', 'uncommon-eap-types', 'wps'
- UnusedInherits: version 20251031: unused eclass: qmake-utils

## app-server/nginx
- MissingRemoteId: missing <remote-id type="github">nginx/nginx</remote-id> (inferred from URI 'https://github.com/nginx/nginx/archive/481d28cb4e04c8096b9b6134856891dc52ecc68f.tar.gz')
- DeprecatedInsinto: version 1.28.20250423: deprecated insinto usage (use systemd_dounit or systemd_newunit from systemd.eclass instead), line 195: insinto /usr/lib/systemd/system
- InvalidUseFlags: version 1.28.20250423: invalid USE flags: '#', "'minimal'", '-'
- UnknownUseFlags: version 1.28.20250423: unknown USE flags: 'Common', 'a', 'aim', 'aio', 'build', 'flags', 'for', 'gunzip', 'gzip-static', 'http', 'http-cache', 'http_v2', 'http_v3', 'libatomic', 'lightweight', 'mail', 'minimal', 'pcre-jit', 'realip', 'reverse-proxy-only', 'stream', 'stub-status', 'sub'
- VariableOrderWrong: version 1.28.20250423: variable IUSE should occur before RESTRICT

## app-port/gentoopm
- MissingRemoteId: missing <remote-id type="github">mgorny/gentoopm</remote-id> (inferred from URI 'https://github.com/mgorny/gentoopm/')
- NonexistentDeps: version 20241128: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 20241128: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 20241128: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 20241128: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 20241128: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 20241128: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## app-server/opensmtpd
- MissingRemoteId: missing <remote-id type="github">OpenSMTPD/OpenSMTPD</remote-id> (inferred from URI 'https://github.com/OpenSMTPD/OpenSMTPD/archive/6b362d305179cc9f5dba3eed266e7c757795365f.tar.gz')
- DeprecatedInsinto: version 20251110: deprecated insinto usage (use systemd_dounit or systemd_newunit from systemd.eclass instead), line 52: insinto /usr/lib/systemd/system
- AbsoluteSymlink: version 20251110: dosym called with absolute path on line 63: dosym /usr/sbin/smtpctl
- AbsoluteSymlink: version 20251110: dosym called with absolute path on line 64: dosym /usr/sbin/smtpctl
- AbsoluteSymlink: version 20251110: dosym called with absolute path on line 68: dosym /usr/sbin/smtpctl
- AbsoluteSymlink: version 20251110: dosym called with absolute path on line 69: dosym /usr/sbin/smtpctl
- AbsoluteSymlink: version 20251110: dosym called with absolute path on line 70: dosym /usr/sbin/smtpctl
- UnknownUseFlags: version 20251110: unknown USE flag: 'mta'

## app-dev/pwntools
- MissingRemoteId: missing <remote-id type="github">Gallopsled/pwntools</remote-id> (inferred from URI 'https://github.com/Gallopsled/pwntools')
- NonexistentDeps: version 20251124: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 20251124: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 20251124: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 20251124: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 20251124: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 20251124: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## app-server/privoxy
- MissingRemoteId: missing <remote-id type="github">1g4-mirror/privoxy</remote-id> (inferred from URI 'https://github.com/1g4-mirror/privoxy/archive/dea56ef37ae115249f85aa6728df2ce3dd7877d0.tar.gz')
- MissingRemoteId: missing <remote-id type="sourceforge">ijbswa</remote-id> (inferred from URI 'https://sourceforge.net/projects/ijbswa/')
- UnknownUseFlags: version 20251009: unknown USE flags: 'brotli', 'client-tags', 'compression', 'editor', 'extended-host-patterns', 'extended-statistics', 'external-filters', 'fast-redirects', 'force', 'fuzz', 'graceful-termination', 'image-blocking', 'jit', 'lfs', 'mbedtls', 'openssl', 'png-images', 'sanitize', 'stats', 'toggle', 'tools', 'whitelists'

## app-port/repoman
- MissingRemoteId: missing <remote-id type="github">gentoo/portage</remote-id> (inferred from URI 'https://github.com/gentoo/portage/archive/a959ea2dd7734d6ac5d374e45f7b5ba43949476e.tar.gz')
- DistutilsNonPEP517Build: version 20251128: uses deprecated non-PEP517 build mode, please switch to DISTUTILS_USE_PEP517=...
- NonexistentDeps: version 20251128: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 20251128: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 20251128: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 20251128: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 20251128: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 20251128: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## app-lang/python
- MissingRemoteId: missing <remote-id type="github">python/cpython</remote-id> (inferred from URI 'https://github.com/python/cpython/archive/afaa3b02f79b16d175129e9c5cbf6660f7521a69.tar.gz')
- IndirectInherits: version 3.13.20251204: multiprocessing: indirect inherit usage: 'makeopts_jobs', line 212
- UnknownUseFlags: version 3.13.20251204: unknown USE flags: 'libedit', 'pgo', 'tk', 'valgrind'
- UnusedInherits: version 3.13.20251204: unused eclass: toolchain-funcs
- IndirectInherits: version 3.14.20251203: multiprocessing: indirect inherit usage: 'makeopts_jobs "${MAKEOPTS}" "$(get_nproc)"', line 63
- UnknownUseFlags: version 3.14.20251203: unknown USE flags: 'libedit', 'pgo', 'tk', 'valgrind'
- UnusedInherits: version 3.14.20251203: unused eclass: toolchain-funcs

## app-net/ulogd
- MissingRemoteId: missing <remote-id type="github">1g4-mirror/ulogd2</remote-id> (inferred from URI 'https://github.com/1g4-mirror/ulogd2/archive/1ab0c1b1fd3f598b671455ad38c52d1dce96bbba.tar.gz')
- DeprecatedInsinto: version 20250601: deprecated insinto usage (use systemd_dounit or systemd_newunit from systemd.eclass instead), line 80: insinto /usr/lib/systemd/system
- NonexistentDeps: version 20250601: DEPEND: nonexistent packages: >=lib-net/libnetfilter_acct-1.0.1, dev-db/postgresql:=, virtual/mysql
- NonsolvableDepsInStable: version 20250601: nonsolvable depset(depend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ dev-db/postgresql:=, >=lib-net/libnetfilter_acct-1.0.1, virtual/mysql ]
- UnknownUseFlags: version 20250601: unknown USE flags: 'json', 'mysql', 'nfacct', 'nfct', 'nflog', 'pcap', 'postgres'

## app-server/mariadb
- MissingTestRestrict: version 12.0.9999: missing RESTRICT="!test? ( test )" with IUSE=test
- NonexistentDeps: version 12.0.9999: DEPEND: nonexistent package: lib-core/libpcre
- NonsolvableDepsInStable: version 12.0.9999: nonsolvable depset(depend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ lib-core/libpcre ]
- UnknownUseFlags: version 12.0.9999: unknown USE flags: 'kerberos', 'numa', 'profiling'
- UnusedInherits: version 12.0.9999: unused eclass: toolchain-funcs
- VariableOrderWrong: version 12.0.9999: variable DESCRIPTION should occur before HOMEPAGE
- VisibleVcsPkg: version 12.0.9999: VCS version visible for KEYWORDS="amd64", profile core/amd64/glibc (16 total)

## app-port/gpyutils
- MissingRemoteId: missing <remote-id type="github">gentoo/gpyutils</remote-id> (inferred from URI 'https://github.com/gentoo/gpyutils/archive/af50626af32513e8d63bfdb81015ea010fc0c3d0.tar.gz')
- MissingRemoteId: missing <remote-id type="pypi">gpyutils</remote-id> (inferred from URI 'https://pypi.org/project/gpyutils/')
- EPyTestPluginsSuggestion: version 20251026: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- NonexistentDeps: version 20251026: BDEPEND: nonexistent packages: >=app-portage/gentoopm-0.3.2, app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 20251026: RDEPEND: nonexistent packages: >=app-portage/gentoopm-0.3.2, app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 20251026: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14, >=app-portage/gentoopm-0.3.2[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)] ]
- NonsolvableDepsInStable: version 20251026: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14, >=app-portage/gentoopm-0.3.2[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)] ]
- PythonMissingDeps: version 20251026: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 20251026: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## app-server/pure-ftpd
- MissingRemoteId: missing <remote-id type="github">jedisct1/pure-ftpd</remote-id> (inferred from URI 'https://github.com/jedisct1/pure-ftpd/archive/26d2fffa8789ef7c9c5db58f8bb1d28e14596d1d.tar.gz')
- DeprecatedInsinto: version 20251201: deprecated insinto usage (use systemd_dounit or systemd_newunit from systemd.eclass instead), line 100: insinto /usr/lib/systemd/system
- UnknownUseFlags: version 20251201: unknown USE flags: 'implicittls', 'mysql', 'noiplog', 'paranoidmsg', 'postgres', 'resolveids', 'vchroot'

## app-server/tor
- DeprecatedInsinto: version 0.4.8.20251117: deprecated insinto usage (use systemd_dounit or systemd_newunit from systemd.eclass instead), line 66: insinto /usr/lib/systemd/system
- MissingTestRestrict: version 0.4.8.20251117: missing RESTRICT="!test? ( test )" with IUSE=test
- NonexistentDeps: version 0.4.8.20251117: DEPEND: nonexistent package: app-crypto/libscrypt
- NonsolvableDepsInStable: version 0.4.8.20251117: nonsolvable depset(depend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-crypto/libscrypt ]
- UnknownUseFlags: version 0.4.8.20251117: unknown USE flags: 'scrypt', 'tor-hardening'

## app-tex/dos2unix
- MissingRemoteId: missing <remote-id type="github">1g4-mirror/dos2unix</remote-id> (inferred from URI 'https://github.com/1g4-mirror/dos2unix/archive/ecdd7428ac17035140f7c369c1022bca3016a099.tar.gz')
- MissingRemoteId: missing <remote-id type="sourceforge">dos2unix</remote-id> (inferred from URI 'https://sourceforge.net/projects/dos2unix/')
- DoubleEmptyLine: version 20251015: ebuild has unneeded empty line on line: 34

## app-tex/docbook-sgml-dtd
- MissingUnpackerDep: version 4.5: missing BDEPEND="app-arch/unzip" for SRC_URI archive: [ docbook-4.5.zip ]
- VariableOrderWrong: version 4.5: variable S should occur before KEYWORDS

## app-tex/hunspell-dictionaries
- MissingRemoteId: missing <remote-id type="github">wooorm/dictionaries</remote-id> (inferred from URI 'https://github.com/wooorm/dictionaries/archive/8cfea406b505e4d7df52d5a19bce525df98c54ab.tar.gz')

## app-server/nodejs
- MissingRemoteId: missing <remote-id type="github">nodejs/node</remote-id> (inferred from URI 'https://github.com/nodejs/node/archive/5cef358d10ac165dc30e5bcbde97ed926387a350.tar.gz')
- NonexistentDeps: version 24.20251111: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 24.20251111: IDEPEND: nonexistent package: app-dev/desktop-file-utils
- NonsolvableDepsInStable: version 24.20251111: nonsolvable depset(idepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-dev/desktop-file-utils ]
- PythonMissingDeps: version 24.20251111: missing DEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 24.20251111: unknown USE flags: 'inspector', 'lto', 'node-snapshot', 'npm'

## app-tex/go-md2man
- MissingRemoteId: missing <remote-id type="github">cpuguy83/go-md2man</remote-id> (inferred from URI 'https://github.com/cpuguy83/go-md2man')

## app-tex/libpaper
- MissingRemoteId: missing <remote-id type="github">rrthomas/libpaper</remote-id> (inferred from URI 'https://github.com/rrthomas/libpaper/releases/download/v2.2.6/libpaper-2.2.6.tar.gz')

## app-tex/asciidoc
- MissingRemoteId: missing <remote-id type="github">asciidoc-py/asciidoc-py</remote-id> (inferred from URI 'https://github.com/asciidoc-py/asciidoc-py/')
- NonexistentDeps: version 9.9999: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 9.9999: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 9.9999: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 9.9999: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 9.9999: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 9.9999: unknown USE flags: 'python_single_target_python3_11', 'python_single_target_python3_12', 'python_single_target_python3_13', 'python_single_target_python3_14'
- VisibleVcsPkg: version 9.9999: VCS version visible for KEYWORDS="amd64", profile core/amd64/glibc (16 total)

## app-tex/poppler-data
- MissingRemoteId: missing <remote-id type="freedesktop-gitlab">poppler/poppler-data</remote-id> (inferred from URI 'https://gitlab.freedesktop.org/poppler/poppler-data/-/archive/3d16b54346767f2e69c3dcd09d28d762d4a4add5/poppler-data-3d16b54346767f2e69c3dcd09d28d762d4a4add5.tar.bz2')
- RedundantUriRename: version 20230202: redundant rename: https://gitlab.freedesktop.org/poppler/poppler-data/-/archive/3d16b54346767f2e69c3dcd09d28d762d4a4add5/poppler-data-3d16b54346767f2e69c3dcd09d28d762d4a4add5.tar.bz2 -> poppler-data-3d16b54346767f2e69c3dcd09d28d762d4a4add5.tar.bz2

## app-lang/rust
- MissingRemoteId: missing <remote-id type="github">thepowersgang/mrustc</remote-id> (inferred from URI 'https://github.com/thepowersgang/mrustc/archive/44013560b99ee8f351807d5ad4b64ba36bfe7d01.tar.gz')
- ExcessiveLineLength: version 1.74.0: excessive line length (over 120 characters) on lines: 121, 125
- UnsortedKeywords: version 1.74.0: unsorted KEYWORDS: arm64, amd64
- UnusedInherits: version 1.74.0: unused eclass: rust-toolchain
- WhitespaceFound: version 1.74.0: ebuild has leading whitespace on lines: 62, 63, 64, 68, 69, 73, 75, 76, 78, 99, 100, 101, 102, 103, 104, 105, 106
- ExcessiveLineLength: version 1.75.0: excessive line length (over 120 characters) on line: 82
- PythonMissingDeps: version 1.75.0: missing DEPEND="${PYTHON_DEPS}"
- UnusedInherits: version 1.75.0: unused eclasses: rust-toolchain, toolchain-funcs
- WhitespaceFound: version 1.75.0: ebuild has leading whitespace on lines: 53, 54, 55, 56, 58, 59, 61, 62, 66, 67, 69
- ExcessiveLineLength: version 1.91.0: excessive line length (over 120 characters) on line: 108
- PythonMissingDeps: version 1.91.0: missing DEPEND="${PYTHON_DEPS}"
- UnusedInherits: version 1.91.0: unused eclasses: rust-toolchain, toolchain-funcs
- WhitespaceFound: version 1.91.0: ebuild has leading whitespace on lines: 79, 80, 81, 82, 83, 84, 85, 86, 88, 89, 90, 91, 93, 94, 95, 148, 149, 151, 152, 153, 154, 155, 156, 157, 158, 162, 164, 165, 166, 167, 168, 169, 170, 172, 173
- DoubleEmptyLine: version 1.92.0: ebuild has unneeded empty line on line: 113
- PythonMissingDeps: version 1.92.0: missing DEPEND="${PYTHON_DEPS}"
- UnusedInherits: version 1.92.0: unused eclasses: rust-toolchain, toolchain-funcs

## app-server/lighttpd
- MissingRemoteId: missing <remote-id type="github">lighttpd/lighttpd1.4</remote-id> (inferred from URI 'https://github.com/lighttpd/lighttpd1.4/archive/e4cea1bf7f092e37e607e35c3872a167c5ced3e3.tar.gz')
- DeprecatedInsinto: version 20251202: deprecated insinto usage (use systemd_dounit or systemd_newunit from systemd.eclass instead), line 76: insinto /usr/lib/systemd/system
- MissingTestRestrict: version 20251202: missing RESTRICT="!test? ( test )" with IUSE=test
- NonexistentDeps: version 20251202: DEPEND: nonexistent packages: lib-net/mbedtls, lib-util/libunwind
- NonsolvableDepsInStable: version 20251202: nonsolvable depset(depend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ lib-net/mbedtls, lib-util/libunwind ]
- UnknownUseFlags: version 20251202: unknown USE flags: 'dbi', 'fam', 'geoip', 'krb5', 'libunwind', 'mbedtls', 'mysql', 'php', 'postgres', 'webdav', 'xxhash'

## app-server/redis
- MissingRemoteId: missing <remote-id type="github">redis/redis</remote-id> (inferred from URI 'https://github.com/redis/redis')
- DeprecatedInsinto: version 8.2.20251102: deprecated insinto usage (use systemd_dounit or systemd_newunit from systemd.eclass instead), line 149: insinto /usr/lib/systemd/system
- MissingInherits: version 8.2.20251102: user: missing inherit usage: 'enewuser redis 6379 -1 -1 redis', line 169
- RequiredUseDefaults: version 8.2.20251102: profile: 'core/amd64/glibc' (16 total) failed REQUIRED_USE: jemalloc
- UnknownUseFlags: version 8.2.20251102: unknown USE flag: 'jemalloc'

## app-server/unbound
- MissingRemoteId: missing <remote-id type="github">NLnetLabs/unbound</remote-id> (inferred from URI 'https://github.com/NLnetLabs/unbound/archive/c0522043f0de237d605d5dbbc239a7cd6b2e24d8.tar.gz')
- DeprecatedInsinto: version 20251203: deprecated insinto usage (use systemd_dounit or systemd_newunit from systemd.eclass instead), line 81: insinto /usr/lib/systemd/system
- NonexistentDeps: version 20251203: DEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 20251203: nonsolvable depset(depend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 20251203: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 20251203: unknown USE flags: 'dnscrypt', 'ecdsa', 'gost', 'python_single_target_python3_11', 'python_single_target_python3_12', 'python_single_target_python3_13', 'python_single_target_python3_14'
- VariableScope: version 20251203: variable 'FILESDIR' used in 'pkg_preinst' on line: 96

## app-tex/hunspell
- MissingRemoteId: missing <remote-id type="github">hunspell/hunspell</remote-id> (inferred from URI 'https://github.com/hunspell/hunspell/archive/8900268aaf68b18031e103c09dc8355725ed546d.tar.gz')
- UnknownLicense: version 20250928: unknown license: LGPL/GPL/MPL
- UnknownUseFlags: version 20250928: unknown USE flag: 'minimal'

## app-util/android-udev-rules
- MissingRemoteId: missing <remote-id type="github">M0Rf30/android-udev-rules</remote-id> (inferred from URI 'https://github.com/M0Rf30/android-udev-rules')
- UnknownUseFlags: version 20251124: unknown USE flag: 'adbusers'

## app-util/bc
- MissingRemoteId: missing <remote-id type="github">gavinhoward/bc</remote-id> (inferred from URI 'https://github.com/gavinhoward/bc')

## app-server/postgresql
- DeprecatedInsinto: version 13.9999: deprecated insinto usage (use systemd_dounit or systemd_newunit from systemd.eclass instead), line 123: insinto /usr/lib/systemd/system
- DeprecatedInsinto: version 13.9999: deprecated insinto usage (use dopamd or newpamd from pam.eclass instead), line 131: insinto /etc/pam.d
- MissingInherits: version 13.9999: user: missing inherit usage: 'enewgroup postgres 70', line 47
- NonexistentBlocker: version 13.9999: nonexistent blocker DEPEND="!!<app-core/sandbox-2.0": no matches in repo history
- NonexistentDeps: version 13.9999: DEPEND: nonexistent packages: app-crypto/heimdal, app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 13.9999: nonsolvable depset(depend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-crypto/heimdal, app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 13.9999: missing RDEPEND="${PYTHON_DEPS}"
- TrailingEmptyLine: version 13.9999: ebuild has trailing blank line(s)
- UnknownUseFlags: version 13.9999: unknown USE flags: 'kerberos', 'python_single_target_python3_11', 'python_single_target_python3_12', 'python_single_target_python3_13', 'python_single_target_python3_14', 'server', 'tcl', 'uuid'
- UnnecessarySlashStrip: version 13.9999: ${EPREFIX%/} unnecessary slash strip on line: 68
- VisibleVcsPkg: version 13.9999: VCS version visible for KEYWORDS="amd64", profile core/amd64/glibc (16 total)

## app-tex/qpdf
- MissingRemoteId: missing <remote-id type="github">qpdf/qpdf</remote-id> (inferred from URI 'https://github.com/qpdf/qpdf/archive/856d32c610334855d30e96d25eb5f9636fb62f08.tar.gz')

## app-util/lshw
- MissingRemoteId: missing <remote-id type="github">lyonel/lshw</remote-id> (inferred from URI 'https://github.com/lyonel/lshw/archive/209f8306e9500cf5ac32f01abb11ff6dcce76b0a.tar.gz')

## app-var/c_rehash
- VariableOrderWrong: version 1.0: variable S should occur before KEYWORDS

## app-util/numactl
- MissingRemoteId: missing <remote-id type="github">numactl/numactl</remote-id> (inferred from URI 'https://github.com/numactl/numactl')

## app-var/crunch
- MissingRemoteId: missing <remote-id type="sourceforge">crunch-wordlist</remote-id> (inferred from URI 'https://sourceforge.net/projects/crunch-wordlist/')

## app-util/sysbench
- MissingRemoteId: missing <remote-id type="github">akopytov/sysbench.git</remote-id> (inferred from URI 'https://github.com/akopytov/sysbench.git')

## app-var/push
- MissingRemoteId: missing <remote-id type="github">vaeth/push</remote-id> (inferred from URI 'https://github.com/vaeth/push/')
- UnquotedVariable: version 5.0: unquoted variable S on line: 13

## app-var/hdparm
- MissingRemoteId: missing <remote-id type="sourceforge">hdparm</remote-id> (inferred from URI 'https://sourceforge.net/projects/hdparm/')

## app-port/pkgdev
- MissingRemoteId: missing <remote-id type="github">pkgcore/pkgdev</remote-id> (inferred from URI 'https://github.com/pkgcore/pkgdev')
- NonexistentDeps: version 20251203: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 20251203: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 20251203: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 20251203: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 20251203: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 20251203: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## app-tex/docbook-xsl-stylesheets
- MissingRemoteId: missing <remote-id type="github">docbook/wiki</remote-id> (inferred from URI 'https://github.com/docbook/wiki/wiki')
- VariableOrderWrong: version 1.79.1-r2: variable S should occur before KEYWORDS
- UnknownUseFlags: version 20230630: unknown USE flags: 'compat-symlink', 'legacy-path'
- WhitespaceFound: version 20230630: ebuild has leading whitespace on lines: 20, 27, 29, 30, 31, 33, 34, 42, 46, 47, 48, 49, 50, 51, 52, 54, 55, 56, 57, 59, 60, 61, 62, 63, 64, 65, 67, 68, 69, 70, 71, 72, 73, 74, 78, 79, 83, 84

## app-util/man-db
- MissingRemoteId: missing <remote-id type="gitlab">man-db/man-db</remote-id> (inferred from URI 'https://gitlab.com/man-db/man-db/-/archive/2b38f74972ab09985b0f7a6716a08c657ff716d8/man-db-2b38f74972ab09985b0f7a6716a08c657ff716d8.tar.bz2')
- UnusedInherits: version 20250519: unused eclass: flag-o-matic
- VariableScope: version 20250519: variable 'EROOT' used in 'src_prepare' on line: 31

## app-tex/docbook-xml-dtd
- MissingUnpackerDep: version 4.5: missing BDEPEND="app-arch/unzip" for SRC_URI archive: [ docbook-xml-4.5.zip ]
- VariableOrderWrong: version 4.5: variable S should occur before KEYWORDS
- ExcessiveLineLength: version 5.0: excessive line length (over 120 characters) on lines: 42, 43, 44
- MissingUnpackerDep: version 5.0: missing BDEPEND="app-arch/unzip" for SRC_URI archive: [ docbook-5.0.zip ]
- VariableOrderWrong: version 5.0: variable S should occur before SLOT
- WhitespaceFound: version 5.0: ebuild has leading whitespace on lines: 18, 19, 21, 22, 24, 25, 27, 28, 32, 34, 36, 37, 38, 39, 41, 42, 43, 44, 48, 50, 52, 53, 54

## bin/apktool
- GlobDistdir: version 2.12.1: line 27: unsafe filename expansion used with DISTDIR: "${DISTDIR}"/*
- VariableOrderWrong: version 2.12.1: variable LICENSE should occur before RESTRICT

## app-var/quoter
- MissingRemoteId: missing <remote-id type="github">vaeth/quoter</remote-id> (inferred from URI 'https://github.com/vaeth/quoter/')

## bin/build-tools
- MissingUnpackerDep: version 35.1: missing BDEPEND="app-arch/unzip" for SRC_URI archive: [ build-tools_r35-rc1-linux.zip ]
- UnknownLicense: version 35.1: unknown license: https://developer.android.com/studio/terms

## app-var/logrotate
- MissingRemoteId: missing <remote-id type="github">logrotate/logrotate</remote-id> (inferred from URI 'https://github.com/logrotate/logrotate')
- DeprecatedInsinto: version 20250901: deprecated insinto usage (use systemd_dounit or systemd_newunit from systemd.eclass instead), line 57: insinto /usr/lib/systemd/system
- AbsoluteSymlink: version 20250901: dosym called with absolute path on line 62: dosym /usr/lib/systemd/system/logrotate.timer

## app-var/symlinks
- UnusedInherits: version 9999: unused eclass: toolchain-funcs
- VisibleVcsPkg: version 9999: VCS version visible for KEYWORDS="amd64", profile core/amd64/glibc (16 total)

## app-var/sysstat
- MissingRemoteId: missing <remote-id type="github">sysstat/sysstat</remote-id> (inferred from URI 'https://github.com/sysstat/sysstat/archive/d5687be42acdac2ccc7388733ae7a9e75372bb38.tar.gz')
- VariableScope: version 20251110: variable 'D' used in 'global scope' on line: 23
- WhitespaceFound: version 20251110: ebuild has leading whitespace on lines: 20, 21, 22, 23, 24, 25

## app-tex/poppler
- MissingRemoteId: missing <remote-id type="freedesktop-gitlab">poppler/poppler</remote-id> (inferred from URI 'https://gitlab.freedesktop.org/poppler/poppler/-/archive/8e9c75e10c949e7bc38b86ab38c2c30102b216d2/poppler-8e9c75e10c949e7bc38b86ab38c2c30102b216d2.tar.bz2')
- IndirectInherits: version 20251203: xdg-utils: indirect inherit usage: 'xdg_environment_reset', line 62
- RedundantUriRename: version 20251203: redundant rename: https://gitlab.freedesktop.org/poppler/poppler/-/archive/8e9c75e10c949e7bc38b86ab38c2c30102b216d2/poppler-8e9c75e10c949e7bc38b86ab38c2c30102b216d2.tar.bz2 -> poppler-8e9c75e10c949e7bc38b86ab38c2c30102b216d2.tar.bz2
- UnknownUseFlags: version 20251203: unknown USE flags: 'cxx', 'introspection', 'jpeg2k', 'utils'
- UnusedInherits: version 20251203: unused eclass: toolchain-funcs

## bin/clion
- NonexistentDeps: version 2024.1.1: IDEPEND: nonexistent package: app-dev/desktop-file-utils
- NonsolvableDepsInStable: version 2024.1.1: nonsolvable depset(idepend) keyword(amd64) stable profile (core/amd64/glibc) (8 total): solutions: [ app-dev/desktop-file-utils ]
- UnknownLicense: version 2024.1.1: unknown licenses: CC-BY-2.5, CDDL-1.1, EPL-1.0, EPL-2.0, GPL-2-with-classpath-exception, JDOM, LGPL-3-with-linking-exception, MPL-1.0, OFL, codehaus-classworlds

## app-var/hwloc
- MissingRemoteId: missing <remote-id type="github">1g4-mirror/hwloc</remote-id> (inferred from URI 'https://github.com/1g4-mirror/hwloc/archive/12c46079502055c88169ec21dd9e3a5a2fc8907f.tar.gz')
- UnknownUseFlags: version 20251119: unknown USE flags: 'numa', 'pci', 'plugins'
- UnusedInherits: version 20251119: unused eclass: flag-o-matic

## bin/filebot
- MissingLicenseRestricts: version 4.7.9: EULA license 'Oracle-BCLA-JavaSE' requires RESTRICT="bindist mirror"
- NonsolvableDepsInStable: version 4.7.9: nonsolvable depset(rdepend) keyword(arm64) stable profile (core/arm64/glibc) (8 total): solutions: [ bin/openjdk8 ]
- UnknownLicense: version 4.7.9: unknown license: Oracle-BCLA-JavaSE
- UnquotedVariable: version 4.7.9: unquoted variable T on line: 33
- VariableOrderWrong: version 4.7.9: variable S should occur before RESTRICT

## app-tex/ghostscript-gpl
- MissingRemoteId: missing <remote-id type="github">ArtifexSoftware/ghostpdl-downloads</remote-id> (inferred from URI 'https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/gs10050/ghostscript-10.05.0.tar.gz')
- NonexistentDeps: version 10.05.0: DEPEND: nonexistent package: xgui-live-lib/gtk3
- NonsolvableDepsInStable: version 10.05.0: nonsolvable depset(depend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ xgui-live-lib/gtk3 ]
- WhitespaceFound: version 10.05.0: ebuild has trailing whitespace on line: 39

## bin/openjdk17
- UnknownLicense: version 17.58.21: unknown license: https://www.azul.com/products/core/openjdk-terms-of-use/

## app-tex/mupdf
- DeprecatedInsinto: version 1.23.6: deprecated insinto usage (use domenu or newmenu from desktop.eclass instead), line 122: insinto /usr/share/applications/
- NonexistentDeps: version 1.23.6: IDEPEND: nonexistent package: app-dev/desktop-file-utils
- NonsolvableDepsInStable: version 1.23.6: nonsolvable depset(idepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-dev/desktop-file-utils ]
- RequiredUseDefaults: version 1.23.6: profile: 'core/amd64/glibc/gui' (8 total) failed REQUIRED_USE: javascript
- UnknownUseFlags: version 1.23.6: unknown USE flag: 'javascript'

## bin/intellij
- DeprecatedInsinto: version 2023.2.1: deprecated insinto usage (use domenu or newmenu from desktop.eclass instead), line 53: insinto /usr/share/applications/
- NonexistentDeps: version 2023.2.1: IDEPEND: nonexistent package: app-dev/desktop-file-utils
- NonsolvableDepsInStable: version 2023.2.1: nonsolvable depset(idepend) keyword(amd64) stable profile (core/amd64/glibc) (8 total): solutions: [ app-dev/desktop-file-utils ]
- UnknownLicense: version 2023.2.1: unknown licenses: CC-BY-2.5, CDDL-1.1, EPL-1.0, EPL-2.0, GPL-2-with-classpath-exception, JDOM, LGPL-3-with-linking-exception, MPL-1.0, OFL, codehaus-classworlds

## bin/openjdk11
- UnknownLicense: version 11.80.21: unknown license: https://www.azul.com/products/core/openjdk-terms-of-use/

## bin/openjdk8
- UnknownLicense: version 8.86.0.25: unknown license: https://www.azul.com/products/core/openjdk-terms-of-use/

## bin/qaac
- MissingRemoteId: missing <remote-id type="github">nu774/qaac</remote-id> (inferred from URI 'https://github.com/nu774/qaac')
- UnknownLicense: version 2.76: unknown license: qaac
- UnquotedVariable: version 2.76: unquoted variable S on line: 17

## bin/platform-tools
- MissingUnpackerDep: version 34.0.1: missing BDEPEND="app-arch/unzip" for SRC_URI archive: [ platform-tools_r34.0.1-linux.zip ]
- UnknownLicense: version 34.0.1: unknown license: https://developer.android.com/studio/terms

## bin/nvidia-settings
- MissingRemoteId: missing <remote-id type="github">NVIDIA/nvidia-settings</remote-id> (inferred from URI 'https://github.com/NVIDIA/nvidia-settings/archive/9da030bedf43a573d9845f233c30f8c47adeebf0.tar.gz')

## bin/vscodium
- ExcessiveLineLength: version 1.106.37943: excessive line length (over 120 characters) on lines: 8, 9

## bin/signal-desktop-bin
- NonexistentDeps: version 7.30.0: IDEPEND: nonexistent package: app-dev/desktop-file-utils
- NonsolvableDepsInStable: version 7.30.0: nonsolvable depset(idepend) keyword(amd64) stable profile (core/amd64/glibc) (8 total): solutions: [ app-dev/desktop-file-utils ]

## core-perl/Date-Manip
- MissingRemoteId: missing <remote-id type="github">SBECK-github/Date-Manip</remote-id> (inferred from URI 'https://github.com/SBECK-github/Date-Manip/archive/80b496189e86463faaf0ea382e7012648482ec0b.tar.gz')
- MissingTestRestrict: version 20250601: missing RESTRICT="!test? ( test )" with IUSE=test
- UnknownUseFlags: version 20250601: unknown USE flags: 'perl_features_debug', 'perl_features_ithreads', 'perl_features_quadmath'

## bin/plexmediaserver
- DeprecatedInsinto: version 1.42.2: deprecated insinto usage (use systemd_dounit or systemd_newunit from systemd.eclass instead), line 43: insinto /usr/lib/systemd/system
- UnknownLicense: version 1.42.2: unknown license: Plex
- VariableOrderWrong: version 1.42.2: variable S should occur before RESTRICT

## bin/openjdk21
- UnknownLicense: version 21.46.19: unknown license: https://www.azul.com/products/core/openjdk-terms-of-use/

## core-perl/IO-Socket-SSL
- MissingRemoteId: missing <remote-id type="github">noxxi/p5-io-socket-ssl</remote-id> (inferred from URI 'https://github.com/noxxi/p5-io-socket-ssl/archive/a9f98837d37e744235cb9045a015486763246d9f.tar.gz')
- UnknownUseFlags: version 20250710: unknown USE flags: 'perl_features_debug', 'perl_features_ithreads', 'perl_features_quadmath'

## core-perl/HTTP-Date
- MissingRemoteId: missing <remote-id type="github">libwww-perl/HTTP-Date</remote-id> (inferred from URI 'https://github.com/libwww-perl/HTTP-Date/archive/8786c34865150134bd591218926bbf0fe102f2bc.tar.gz')
- UnknownUseFlags: version 20230717: unknown USE flags: 'perl_features_debug', 'perl_features_ithreads', 'perl_features_quadmath'

## app-server/samba
- BadDefaultUseFlags: version 4.22.20250707: bad default USE flags: '-addc', '-addns', '-ads', '-ceph', '-cluster', '-ldap'
- DeprecatedInsinto: version 4.22.20250707: deprecated insinto usage (use systemd_dounit or systemd_newunit from systemd.eclass instead), line 154: insinto /usr/lib/systemd/system
- MissingInherits: version 4.22.20250707: doins: missing inherit usage: 'sysusers_process', line 178
- NonexistentBlocker: version 4.22.20250707: nonexistent blocker DEPEND="!dev-db/ctdb": no matches in repo history
- NonexistentBlocker: version 4.22.20250707: nonexistent blocker RDEPEND="!dev-db/ctdb": no matches in repo history
- NonexistentDeps: version 4.22.20250707: DEPEND: nonexistent packages: app-core/dmapi, app-crypto/gpgme, app-dev/lttng-ust, lib-net/rpcsvc-proto, sys-cluster/ceph, virtual/fam
- NonexistentDeps: version 4.22.20250707: RDEPEND: nonexistent packages: app-core/cifs-utils, app-core/dmapi, app-crypto/gpgme, app-dev/lttng-ust, lib-net/rpcsvc-proto, sys-cluster/ceph, virtual/fam
- NonsolvableDepsInStable: version 4.22.20250707: nonsolvable depset(depend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-core/dmapi, app-crypto/gpgme, app-dev/lttng-ust, lib-net/rpcsvc-proto, sys-cluster/ceph, virtual/fam ]
- NonsolvableDepsInStable: version 4.22.20250707: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-core/cifs-utils[ads], app-core/dmapi, app-crypto/gpgme, app-dev/lttng-ust, lib-net/rpcsvc-proto, sys-cluster/ceph, virtual/fam ]
- TrailingEmptyLine: version 4.22.20250707: ebuild has trailing blank line(s)
- UnknownUseFlags: version 4.22.20250707: unknown USE flags: 'addc', 'addns', 'ads', 'ceph', 'client', 'cluster', 'dmapi', 'fam', 'gpg', 'iprint', 'json', 'quota', 'syslog', 'winbind', 'zeroconf'
- UnnecessarySlashStrip: version 4.22.20250707: ${ED%/} unnecessary slash strip on line: 151
- VisibleVcsPkg: version 4.22.20250707: VCS version visible for KEYWORDS="amd64", profile core/amd64/glibc (16 total)

## bin/protonbridge
- BadDescription: version 3.21.1: over 80 chars in length
- NonexistentDeps: version 3.21.1: IDEPEND: nonexistent package: app-dev/desktop-file-utils
- NonexistentDeps: version 3.21.1: RDEPEND: nonexistent package: dev-libs/glib:2
- NonsolvableDepsInStable: version 3.21.1: nonsolvable depset(idepend) keyword(amd64) stable profile (core/amd64/glibc) (8 total): solutions: [ app-dev/desktop-file-utils ]
- NonsolvableDepsInStable: version 3.21.1: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (8 total): solutions: [ dev-libs/glib:2 ]
- WhitespaceFound: version 3.21.1: ebuild has leading whitespace on lines: 18, 19, 20, 21, 26, 30, 34, 35, 37, 38, 40, 44, 45, 49, 50

## core-perl/Module-Build
- MissingRemoteId: missing <remote-id type="github">Perl-Toolchain-Gang/Module-Build</remote-id> (inferred from URI 'https://github.com/Perl-Toolchain-Gang/Module-Build/archive/a2ecdf98c25af7dfc7070280232513e8ccec4986.tar.gz')
- MissingTestRestrict: version 20230430: missing RESTRICT="!test? ( test )" with IUSE=test
- UnknownUseFlags: version 20230430: unknown USE flags: 'perl_features_debug', 'perl_features_ithreads', 'perl_features_quadmath'

## bin/rust-bin
- UnknownUseFlags: version 1.92.0: unknown USE flags: 'clippy', 'rls', 'rustfmt'
- UnusedInherits: version 1.92.0: unused eclass: toolchain-funcs

## core-perl/XML-Parser
- MissingRemoteId: missing <remote-id type="github">cpan-authors/XML-Parser</remote-id> (inferred from URI 'https://github.com/cpan-authors/XML-Parser/archive/0384963609c270873196cc26b71c9490738ecc32.tar.gz')
- UnknownUseFlags: version 20231229: unknown USE flags: 'perl_features_debug', 'perl_features_ithreads', 'perl_features_quadmath'

## core-perl/YAML-Tiny
- MissingRemoteId: missing <remote-id type="github">Perl-Toolchain-Gang/YAML-Tiny</remote-id> (inferred from URI 'https://github.com/Perl-Toolchain-Gang/YAML-Tiny/archive/0b3f6349d5fa2b65dbfd9e46e7ea83460f3eb631.tar.gz')
- MissingTestRestrict: version 20241216: missing RESTRICT="!test? ( test )" with IUSE=test
- UnknownUseFlags: version 20241216: unknown USE flags: 'minimal', 'perl_features_debug', 'perl_features_ithreads', 'perl_features_quadmath'

## bin/libreoffice-bin
- ExcessiveLineLength: version 25.2.4: excessive line length (over 120 characters) on line: 118
- NonexistentDeps: version 25.2.4: IDEPEND: nonexistent package: app-dev/desktop-file-utils
- NonsolvableDepsInStable: version 25.2.4: nonsolvable depset(idepend) keyword(amd64) stable profile (core/amd64/glibc) (8 total): solutions: [ app-dev/desktop-file-utils ]
- UnknownUseFlags: version 25.2.4: unknown USE flags: 'java', 'l10n_en', 'offlinehelp'
- WhitespaceFound: version 25.2.4: ebuild has leading whitespace on lines: 121, 122, 123, 124, 125, 138, 139, 140, 144, 145, 146

## bin/chromium
- MissingRemoteId: missing <remote-id type="github">ungoogled-software/ungoogled-chromium-portablelinux</remote-id> (inferred from URI 'https://github.com/ungoogled-software/ungoogled-chromium-portablelinux')
- SizeViolation: 'files/chromium.png' exceeds 20.0 KiB in size; 50.7 KiB total
- TotalSizeViolation: files/ directory exceeds 50.0 KiB in size; 50.7 KiB total
- NonexistentDeps: version 142.0.7444.162: IDEPEND: nonexistent package: app-dev/desktop-file-utils
- NonsolvableDepsInStable: version 142.0.7444.162: nonsolvable depset(idepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-dev/desktop-file-utils ]
- VariableOrderWrong: version 142.0.7444.162: variable LICENSE should occur before RESTRICT

## bin/teamviewer
- NonexistentDeps: version 15.55.3: IDEPEND: nonexistent package: app-dev/desktop-file-utils
- NonsolvableDepsInStable: version 15.55.3: nonsolvable depset(idepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-dev/desktop-file-utils ]
- UnusedInherits: version 15.55.3: unused eclass: optfeature

## bin/brave-nightly-bin
- DeprecatedInsinto: version 1.86.96: deprecated insinto usage (use domenu or newmenu from desktop.eclass instead), line 69: insinto /usr/share/applications
- DeprecatedInsinto: version 1.86.96: deprecated insinto usage (use domenu or newmenu from desktop.eclass instead), line 73: insinto /usr/share/applications
- NonexistentDeps: version 1.86.96: IDEPEND: nonexistent package: app-dev/desktop-file-utils
- NonsolvableDepsInStable: version 1.86.96: nonsolvable depset(idepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-dev/desktop-file-utils ]
- UnknownLicense: version 1.86.96: unknown license: BRAVE
- VariableOrderWrong: version 1.86.96: variable LICENSE should occur before RESTRICT

## bin/discord
- NonexistentDeps: version 0.0.42: IDEPEND: nonexistent package: app-dev/desktop-file-utils
- NonsolvableDepsInStable: version 0.0.42: nonsolvable depset(idepend) keyword(amd64) stable profile (core/amd64/glibc) (8 total): solutions: [ app-dev/desktop-file-utils ]
- UnknownLicense: version 0.0.42: unknown license: DISCORD
- VariableOrderWrong: version 0.0.42: variable LICENSE should occur before RESTRICT
- VariableOrderWrong: version 0.0.42: variable S should occur before IUSE
- VariableShadowed: version 0.0.42: variable 'S' may be shadowed, on lines: 13, 51

## bin/google-chrome-unstable
- NonexistentDeps: version 144.0.7524.0: IDEPEND: nonexistent package: app-dev/desktop-file-utils
- NonsolvableDepsInStable: version 144.0.7524.0: nonsolvable depset(idepend) keyword(amd64) stable profile (core/amd64/glibc) (8 total): solutions: [ app-dev/desktop-file-utils ]
- VariableOrderWrong: version 144.0.7524.0: variable LICENSE should occur before RESTRICT

## core-perl/libintl-perl
- MissingRemoteId: missing <remote-id type="github">gflohr/libintl-perl</remote-id> (inferred from URI 'https://github.com/gflohr/libintl-perl/archive/f6de629e6b449c5364266c5b6c40a875e783338c.tar.gz')
- UnknownUseFlags: version 20250115: unknown USE flags: 'perl_features_debug', 'perl_features_ithreads', 'perl_features_quadmath'

## bin/nvidia-cuda
- MissingLicenseRestricts: version 12.9.1.575.57.08: EULA license 'NVIDIA-CUDA' requires RESTRICT="bindist"
- ReadonlyVariable: version 12.9.1.575.57.08: read-only variable 'PV' assigned, line 9: PV="$(ver_cut 1-3)"
- UnknownUseFlags: version 12.9.1.575.57.08: unknown USE flags: 'debugger', 'sanitizer'
- UnusedInherits: version 12.9.1.575.57.08: unused eclass: toolchain-funcs
- VariableOrderWrong: version 12.9.1.575.57.08: variable S should occur before RESTRICT
- MissingLicenseRestricts: version 13.1.0.590.44.01: EULA license 'NVIDIA-CUDA' requires RESTRICT="bindist"
- ReadonlyVariable: version 13.1.0.590.44.01: read-only variable 'PV' assigned, line 9: PV="$(ver_cut 1-3)"
- UnknownUseFlags: version 13.1.0.590.44.01: unknown USE flags: 'debugger', 'sanitizer'
- UnusedInherits: version 13.1.0.590.44.01: unused eclass: toolchain-funcs
- VariableOrderWrong: version 13.1.0.590.44.01: variable S should occur before RESTRICT

## dev-py/aider
- MissingRemoteId: missing <remote-id type="github">Aider-AI/aider</remote-id> (inferred from URI 'https://github.com/Aider-AI/aider')
- NonexistentDeps: version 20251122: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 20251122: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 20251122: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 20251122: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 20251122: missing RDEPEND="${PYTHON_DEPS}"
- PythonMissingSCMDependency: version 20251122: defines SETUPTOOLS_SCM_PRETEND_VERSION but is missing BDEPEND on setuptools-scm or alike
- UnknownUseFlags: version 20251122: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'
- UnusedInherits: version 20251122: unused eclass: toolchain-funcs

## dev-py/bcrypt
- MissingRemoteId: missing <remote-id type="github">pyca/bcrypt</remote-id> (inferred from URI 'https://github.com/pyca/bcrypt/archive/296f5d086b79ee5a9a85bd6f6c3d91976b8643a6.tar.gz')
- MissingRemoteId: missing <remote-id type="pypi">bcrypt</remote-id> (inferred from URI 'https://pypi.org/project/bcrypt/')
- EPyTestPluginsSuggestion: version 20251202: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- NonexistentDeps: version 20251202: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 20251202: DEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 20251202: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 20251202: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 20251202: nonsolvable depset(depend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 20251202: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 20251202: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 20251202: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-py/regex
- MissingRemoteId: missing <remote-id type="github">mrabarnett/mrab-regex</remote-id> (inferred from URI 'https://github.com/mrabarnett/mrab-regex/')
- NonexistentDeps: version 20251103: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 20251103: DEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 20251103: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 20251103: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 20251103: nonsolvable depset(depend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 20251103: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 20251103: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 20251103: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## app-var/ansible
- MissingRemoteId: missing <remote-id type="github">ansible/ansible</remote-id> (inferred from URI 'https://github.com/ansible/ansible/archive/10d29c3105f39f0b186c771bb2c556da09767392.tar.gz')
- DistutilsNonPEP517Build: version 2.19.20251202: uses deprecated non-PEP517 build mode, please switch to DISTUTILS_USE_PEP517=...
- NonexistentDeps: version 2.19.20251202: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 2.19.20251202: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 2.19.20251202: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 2.19.20251202: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 2.19.20251202: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 2.19.20251202: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-py/rpds-py
- MissingRemoteId: missing <remote-id type="github">crate-py/rpds</remote-id> (inferred from URI 'https://github.com/crate-py/rpds/')
- NonexistentDeps: version 20251202: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 20251202: DEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 20251202: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 20251202: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 20251202: nonsolvable depset(depend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 20251202: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 20251202: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 20251202: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## bin/nvidia-drivers
- IndirectInherits: version 590.44.01: user-info: indirect inherit usage: 'egetent group video', line 302
- NonsolvableDepsInStable: version 590.44.01: nonsolvable depset(pdepend) keyword(arm64) stable profile (core/arm64/glibc) (8 total): solutions: [ bin/nvidia-settings ]
- UnknownUseFlags: version 590.44.01: unknown USE flags: 'driver', 'initramfs', 'kms', 'modules-compress', 'modules-sign', 'strip', 'uvm'
- UnusedInherits: version 590.44.01: unused eclasses: flag-o-matic, toolchain-funcs, user
- VariableOrderWrong: version 590.44.01: variable S should occur before RESTRICT
- VariableScope: version 590.44.01: variable 'S' used in 'pkg_setup' on lines: 72, 73, 74, 75, 76
- WhitespaceFound: version 590.44.01: ebuild has leading whitespace on lines: 15, 16, 27, 28, 31, 32, 33, 34, 35, 36, 37, 40, 41, 50, 51, 52, 53, 54, 55, 56, 57, 58, 62, 66, 67, 69, 70, 72, 73, 74, 75, 76, 77, 81, 82, 83, 84, 86, 88, 89, 90, 91, 95, 96, 98, 100, 101, 102, 103, 104, 105, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 120, 121, 122, 123, 125, 126, 127, 128, 129, 130, 131, 133, 135, 136, 137, 138, 140, 141, 145, 146, 148, 149, 151, 152, 153, 155, 156, 158, 159, 160, 162, 163, 164, 167, 168, 169, 171, 172, 173, 175, 176, 178, 179, 181, 182, 184, 185, 186, 188, 189, 190, 191, 192, 193, 194, 196, 197, 199, 201, 202, 204, 205, 206, 208, 209, 210, 211, 212, 213, 214, 215, 217, 218, 219, 220, 222, 223, 225, 227, 229, 230, 232, 233, 234, 236, 237, 239, 240, 242, 246, 247, 248, 249, 251, 252, 253, 254, 255, 256, 257, 258, 259, 260, 261, 262, 263, 264, 265, 266, 267, 268, 269, 270, 271, 272, 273, 274, 275, 276, 277, 278, 279, 280, 281, 282, 283, 284, 285, 286, 287, 288, 289, 290, 291, 293, 294, 295, 296, 300, 301, 302, 303, 304, 305, 306, 307, 308, 309, 310, 311, 312, 316

## dev-py/cuda-python
- MissingRemoteId: missing <remote-id type="github">NVIDIA/cuda-python</remote-id> (inferred from URI 'https://github.com/NVIDIA/cuda-python')
- NonexistentDeps: version 20251203: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 20251203: DEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 20251203: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 20251203: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 20251203: nonsolvable depset(depend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 20251203: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 20251203: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 20251203: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-py/docutils
- MissingRemoteId: missing <remote-id type="github">docutils/docutils</remote-id> (inferred from URI 'https://github.com/docutils/docutils/archive/5d129e11e46967418b884019fc3855529a5d74cf.tar.gz')
- MissingRemoteId: missing <remote-id type="sourceforge">docutils</remote-id> (inferred from URI 'https://docutils.sourceforge.io/')
- NonexistentDeps: version 20251203: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 20251203: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 20251203: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 20251203: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 20251203: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 20251203: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-py/ipwhois
- MissingRemoteId: missing <remote-id type="github">secynic/ipwhois</remote-id> (inferred from URI 'https://github.com/secynic/ipwhois')
- NonexistentDeps: version 20241015: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 20241015: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 20241015: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 20241015: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 20241015: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 20241015: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-py/llama-cpp-python
- MissingRemoteId: missing <remote-id type="github">abetlen/llama-cpp-python</remote-id> (inferred from URI 'https://github.com/abetlen/llama-cpp-python')
- MissingInherits: version 20250815: cmake: missing inherit usage: 'cmake_src_configure', line 24
- NonexistentDeps: version 20250815: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 20250815: DEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 20250815: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 20250815: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 20250815: nonsolvable depset(depend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 20250815: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 20250815: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 20250815: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'
- UnusedInherits: version 20250815: unused eclass: toolchain-funcs

## dev-py/pyscard
- MissingRemoteId: missing <remote-id type="github">LudovicRousseau/pyscard</remote-id> (inferred from URI 'https://github.com/LudovicRousseau/pyscard/')
- EPyTestPluginsSuggestion: version 20251201: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- NonexistentDeps: version 20251201: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 20251201: DEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 20251201: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 20251201: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 20251201: nonsolvable depset(depend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 20251201: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 20251201: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 20251201: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-py/html5lib
- MissingRemoteId: missing <remote-id type="github">html5lib/html5lib-python</remote-id> (inferred from URI 'https://github.com/html5lib/html5lib-python/')
- ExcessiveLineLength: version 20240221: excessive line length (over 120 characters) on lines: 37, 40
- MissingTestRestrict: version 20240221: missing RESTRICT="!test? ( test )" with IUSE=test
- NonexistentDeps: version 20240221: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12, dev-python/pytest-expect
- NonexistentDeps: version 20240221: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 20240221: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11[xml(+)], app-lang/python:3.12[xml(+)], app-lang/python:3.14[xml(+)], dev-python/pytest-expect[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)] ]
- NonsolvableDepsInStable: version 20240221: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11[xml(+)], app-lang/python:3.12[xml(+)], app-lang/python:3.14[xml(+)] ]
- PythonMissingDeps: version 20240221: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 20240221: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-py/pybind11
- MissingRemoteId: missing <remote-id type="github">pybind/pybind11</remote-id> (inferred from URI 'https://github.com/pybind/pybind11/')
- EmptyGlobalAssignment: version 3.0.1: line 26: empty global assignment: RDEPEND=""
- ExcessiveLineLength: version 3.0.1: excessive line length (over 120 characters) on line: 84
- IndirectInherits: version 3.0.1: multiprocessing: indirect inherit usage: 'get_makeopts_jobs', line 71
- NonexistentDeps: version 3.0.1: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 3.0.1: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 3.0.1: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 3.0.1: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 3.0.1: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 3.0.1: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'
- WhitespaceFound: version 3.0.1: ebuild has trailing whitespace on line: 35

## app-port/pkgcheck
- MissingRemoteId: missing <remote-id type="github">pkgcore/pkgcheck</remote-id> (inferred from URI 'https://github.com/pkgcore/pkgcheck')
- MisplacedEclassVar: version 20251130: invalid pre-inherit placement, line 7: 'DISTUTILS_USE_PEP517=standalone'
- NonexistentDeps: version 20251130: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 20251130: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 20251130: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 20251130: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 20251130: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 20251130: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-py/snakeoil
- MissingRemoteId: missing <remote-id type="github">pkgcore/snakeoil</remote-id> (inferred from URI 'https://github.com/pkgcore/snakeoil')
- ExcessiveLineLength: version 20251130: excessive line length (over 120 characters) on line: 29
- NonexistentDeps: version 20251130: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 20251130: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 20251130: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 20251130: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 20251130: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 20251130: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-py/setuptools-scm
- MissingRemoteId: missing <remote-id type="github">pypa/setuptools-scm</remote-id> (inferred from URI 'https://github.com/pypa/setuptools-scm/')
- DoubleEmptyLine: version 20251130: ebuild has unneeded empty line on line: 15
- EPyTestPluginsSuggestion: version 20251130: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- NonexistentDeps: version 20251130: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 20251130: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 20251130: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 20251130: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 20251130: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 20251130: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-py/dnspython
- MissingRemoteId: missing <remote-id type="github">rthalley/dnspython</remote-id> (inferred from URI 'https://github.com/rthalley/dnspython/archive/8f299d70bb263b6018c353d453bdeab67ec9da08.tar.gz')
- EPyTestPluginsSuggestion: version 20251121: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- NonexistentDeps: version 20251121: BDEPEND: nonexistent packages: >=dev-python/cryptography-41, >=dev-python/quart-trio-0.11.0, app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 20251121: RDEPEND: nonexistent packages: >=dev-python/cryptography-41, app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 20251121: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14, >=dev-python/cryptography-41[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], >=dev-python/quart-trio-0.11.0[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)] ]
- NonsolvableDepsInStable: version 20251121: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14, >=dev-python/cryptography-41[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)] ]
- PythonMissingDeps: version 20251121: missing RDEPEND="${PYTHON_DEPS}"
- UnknownKeywords: version 20251121: unknown KEYWORDS: 'arm', 'hppa', 'ppc', 'ppc64', 'sparc', 'x86', '~alpha', '~amd64-linux', '~loong', '~m68k', '~mips', '~ppc-macos', '~riscv', '~s390', '~x64-macos', '~x86-linux'
- UnknownUseFlags: version 20251121: unknown USE flags: 'dnssec', 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/aiofiles
- MissingRemoteId: missing <remote-id type="github">Tinche/aiofiles</remote-id> (inferred from URI 'https://github.com/Tinche/aiofiles/')
- MissingRemoteId: missing <remote-id type="pypi">aiofiles</remote-id> (inferred from URI 'https://pypi.org/project/aiofiles/')
- NonexistentDeps: version 25.1.0: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 25.1.0: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 25.1.0: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 25.1.0: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 25.1.0: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 25.1.0: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/alabaster
- MissingRemoteId: missing <remote-id type="github">sphinx-doc/alabaster</remote-id> (inferred from URI 'https://github.com/sphinx-doc/alabaster/')
- MissingRemoteId: missing <remote-id type="pypi">alabaster</remote-id> (inferred from URI 'https://pypi.org/project/alabaster/')
- NonexistentDeps: version 1.0.0: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 1.0.0: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 1.0.0: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 1.0.0: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 1.0.0: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 1.0.0: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/appdirs
- MissingRemoteId: missing <remote-id type="github">ActiveState/appdirs</remote-id> (inferred from URI 'https://github.com/ActiveState/appdirs/')
- MissingRemoteId: missing <remote-id type="pypi">appdirs</remote-id> (inferred from URI 'https://pypi.org/project/appdirs/')
- NonexistentDeps: version 1.4.4-r3: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 1.4.4-r3: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 1.4.4-r3: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 1.4.4-r3: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 1.4.4-r3: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 1.4.4-r3: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/aiohappyeyeballs
- MissingRemoteId: missing <remote-id type="github">aio-libs/aiohappyeyeballs</remote-id> (inferred from URI 'https://github.com/aio-libs/aiohappyeyeballs/')
- MissingRemoteId: missing <remote-id type="pypi">aiohappyeyeballs</remote-id> (inferred from URI 'https://pypi.org/project/aiohappyeyeballs/')
- NonexistentDeps: version 2.6.1: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 2.6.1: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 2.6.1: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 2.6.1: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 2.6.1: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 2.6.1: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/aiodns
- MissingRemoteId: missing <remote-id type="github">aio-libs/aiodns</remote-id> (inferred from URI 'https://github.com/aio-libs/aiodns/')
- MissingRemoteId: missing <remote-id type="pypi">aiodns</remote-id> (inferred from URI 'https://pypi.org/project/aiodns/')
- NonexistentDeps: version 3.5.0: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 3.5.0: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 3.5.0: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 3.5.0: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 3.5.0: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 3.5.0: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-py/beautifulsoup4
- MissingRemoteId: missing <remote-id type="pypi">beautifulsoup4</remote-id> (inferred from URI 'https://files.pythonhosted.org/packages/source/b/beautifulsoup4/beautifulsoup4-4.14.2.tar.gz')
- NonexistentDeps: version 4.14.2: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12, dev-python/faust-cchardet
- NonexistentDeps: version 4.14.2: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 4.14.2: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 4.14.2: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 4.14.2: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 4.14.2: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-py/zstandard
- MissingRemoteId: missing <remote-id type="github">indygreg/python-zstandard</remote-id> (inferred from URI 'https://github.com/indygreg/python-zstandard/')
- EPyTestPluginsSuggestion: version 20250914: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- IndirectInherits: version 20250914: flag-o-matic: indirect inherit usage: 'filter-flags -Wl,-z,defs', line 38
- NonexistentDeps: version 20250914: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 20250914: DEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 20250914: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 20250914: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 20250914: nonsolvable depset(depend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 20250914: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 20250914: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 20250914: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-py/pynacl
- MissingRemoteId: missing <remote-id type="github">pyca/pynacl</remote-id> (inferred from URI 'https://github.com/pyca/pynacl/')
- EPyTestPluginsSuggestion: version 20251203: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- NonexistentDeps: version 20251203: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 20251203: DEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 20251203: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 20251203: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 20251203: nonsolvable depset(depend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 20251203: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 20251203: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 20251203: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-py/tree-sitter
- MissingRemoteId: missing <remote-id type="github">tree-sitter/py-tree-sitter</remote-id> (inferred from URI 'https://github.com/tree-sitter/py-tree-sitter/')
- EPyTestPluginsSuggestion: version 20251115: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- NonexistentDeps: version 20251115: BDEPEND: nonexistent packages: >=lib-dev/tree-sitter-html-0.20.4, >=lib-dev/tree-sitter-javascript-0.21.0, >=lib-dev/tree-sitter-json-0.20.3, >=lib-dev/tree-sitter-python-0.23.0, >=lib-dev/tree-sitter-rust-0.21.2, app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 20251115: DEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 20251115: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 20251115: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14, >=lib-dev/tree-sitter-html-0.20.4[python,python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], >=lib-dev/tree-sitter-javascript-0.21.0[python,python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], >=lib-dev/tree-sitter-json-0.20.3[python,python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], >=lib-dev/tree-sitter-python-0.23.0[python,python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], >=lib-dev/tree-sitter-rust-0.21.2[python,python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)] ]
- NonsolvableDepsInStable: version 20251115: nonsolvable depset(depend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 20251115: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 20251115: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 20251115: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/annotated-types
- MissingRemoteId: missing <remote-id type="github">annotated-types/annotated-types</remote-id> (inferred from URI 'https://github.com/annotated-types/annotated-types/')
- MissingRemoteId: missing <remote-id type="pypi">annotated-types</remote-id> (inferred from URI 'https://pypi.org/project/annotated-types/')
- EPyTestPluginsSuggestion: version 0.7.0: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- NonexistentDeps: version 0.7.0: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12, dev-python/pytest-mock
- NonexistentDeps: version 0.7.0: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 0.7.0: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14, dev-python/pytest-mock[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)] ]
- NonsolvableDepsInStable: version 0.7.0: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 0.7.0: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 0.7.0: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-py/lxml
- MissingRemoteId: missing <remote-id type="github">lxml/lxml</remote-id> (inferred from URI 'https://github.com/lxml/lxml/archive/836841276486da2aadfcc1168321efe719536969.tar.gz')
- IndirectInherits: version 20251204: flag-o-matic: indirect inherit usage: 'append-flags -Wno-error', line 64
- NonexistentDeps: version 20251204: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12, dev-python/sphinx-rtd-theme
- NonexistentDeps: version 20251204: DEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 20251204: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 20251204: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14, dev-python/sphinx-rtd-theme[python_targets_python3_11(-)], dev-python/sphinx-rtd-theme[python_targets_python3_12(-)], dev-python/sphinx-rtd-theme[python_targets_python3_13(-)], dev-python/sphinx-rtd-theme[python_targets_python3_14(-)] ]
- NonsolvableDepsInStable: version 20251204: nonsolvable depset(depend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 20251204: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 20251204: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 20251204: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'
- WhitespaceFound: version 20251204: ebuild has leading whitespace on lines: 108, 109, 110

## dev-python/astor
- MissingRemoteId: missing <remote-id type="github">berkerpeksag/astor</remote-id> (inferred from URI 'https://github.com/berkerpeksag/astor/')
- MissingRemoteId: missing <remote-id type="pypi">astor</remote-id> (inferred from URI 'https://pypi.org/project/astor/')
- EPyTestPluginsSuggestion: version 0.8.1-r2: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- NonexistentDeps: version 0.8.1-r2: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 0.8.1-r2: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 0.8.1-r2: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 0.8.1-r2: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 0.8.1-r2: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 0.8.1-r2: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/argcomplete
- MissingRemoteId: missing <remote-id type="github">kislyuk/argcomplete</remote-id> (inferred from URI 'https://github.com/kislyuk/argcomplete/')
- MissingRemoteId: missing <remote-id type="pypi">argcomplete</remote-id> (inferred from URI 'https://pypi.org/project/argcomplete/')
- NonexistentDeps: version 3.6.3: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12, app-shells/fish, app-shells/tcsh, ~app-shells/zsh-5.9
- NonexistentDeps: version 3.6.3: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 3.6.3: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14, app-shells/fish, app-shells/tcsh, ~app-shells/zsh-5.9 ]
- NonsolvableDepsInStable: version 3.6.3: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 3.6.3: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 3.6.3: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/aiosignal
- MissingRemoteId: missing <remote-id type="github">aio-libs/aiosignal</remote-id> (inferred from URI 'https://github.com/aio-libs/aiosignal/')
- MissingRemoteId: missing <remote-id type="pypi">aiosignal</remote-id> (inferred from URI 'https://pypi.org/project/aiosignal/')
- NonexistentDeps: version 1.4.0: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 1.4.0: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 1.4.0: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 1.4.0: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 1.4.0: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 1.4.0: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/asyncstdlib
- MissingRemoteId: missing <remote-id type="github">maxfischer2781/asyncstdlib</remote-id> (inferred from URI 'https://github.com/maxfischer2781/asyncstdlib/')
- MissingRemoteId: missing <remote-id type="pypi">asyncstdlib</remote-id> (inferred from URI 'https://pypi.org/project/asyncstdlib/')
- EPyTestPluginsSuggestion: version 3.13.1: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- NonexistentDeps: version 3.13.1: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 3.13.1: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 3.13.1: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 3.13.1: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 3.13.1: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 3.13.1: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-py/numpy
- MissingRemoteId: missing <remote-id type="pypi">numpy</remote-id> (inferred from URI 'https://files.pythonhosted.org/packages/source/n/numpy/numpy-2.3.4.tar.gz')
- NonsolvableDepsInStable: version 2.3.4: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 2.3.4: nonsolvable depset(depend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 2.3.4: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.14 ]
- PythonMissingDeps: version 2.3.4: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 2.3.4: unknown USE flags: 'cpu_flags_arm_asimd', 'cpu_flags_x86_sse', 'cpu_flags_x86_sse2', 'cpudetection', 'index64', 'lapack', 'python_targets_python3_13', 'python_targets_python3_14'
- WhitespaceFound: version 2.3.4: ebuild has trailing whitespace on line: 69
- NonsolvableDepsInStable: version 2.3.9999: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 2.3.9999: nonsolvable depset(depend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 2.3.9999: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.14 ]
- PythonMissingDeps: version 2.3.9999: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 2.3.9999: unknown USE flags: 'cpu_flags_arm_asimd', 'cpu_flags_x86_sse', 'cpu_flags_x86_sse2', 'cpudetection', 'index64', 'lapack', 'python_targets_python3_13', 'python_targets_python3_14'
- VisibleVcsPkg: version 2.3.9999: VCS version visible for KEYWORDS="amd64", profile core/amd64/glibc (16 total)
- WhitespaceFound: version 2.3.9999: ebuild has trailing whitespace on line: 74

## dev-python/backports-tarfile
- MissingRemoteId: missing <remote-id type="github">jaraco/backports.tarfile</remote-id> (inferred from URI 'https://github.com/jaraco/backports.tarfile/')
- MissingRemoteId: missing <remote-id type="pypi">backports.tarfile</remote-id> (inferred from URI 'https://pypi.org/project/backports.tarfile/')
- EPyTestPluginsSuggestion: version 1.2.0: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- NonexistentDeps: version 1.2.0: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12, dev-python/jaraco-test
- NonexistentDeps: version 1.2.0: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 1.2.0: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14, dev-python/jaraco-test[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)] ]
- NonsolvableDepsInStable: version 1.2.0: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 1.2.0: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 1.2.0: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-py/setuptools-rust
- MissingRemoteId: missing <remote-id type="github">PyO3/setuptools-rust</remote-id> (inferred from URI 'https://github.com/PyO3/setuptools-rust/')
- NonexistentDeps: version 20251201: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12, dev-python/beautifulsoup4
- NonexistentDeps: version 20251201: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 20251201: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14, dev-python/beautifulsoup4[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)] ]
- NonsolvableDepsInStable: version 20251201: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 20251201: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 20251201: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-py/jinja
- MissingRemoteId: missing <remote-id type="github">pallets/jinja</remote-id> (inferred from URI 'https://github.com/pallets/jinja/archive/5ef70112a1ff19c05324ff889dd30405b1002044.tar.gz')
- EPyTestPluginsSuggestion: version 20250614: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- NonexistentDeps: version 20250614: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12, dev-python/pallets-sphinx-themes, dev-python/sphinx-issues
- NonexistentDeps: version 20250614: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 20250614: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14, dev-python/pallets-sphinx-themes[python_targets_python3_11(-)], dev-python/pallets-sphinx-themes[python_targets_python3_12(-)], dev-python/pallets-sphinx-themes[python_targets_python3_13(-)], dev-python/pallets-sphinx-themes[python_targets_python3_14(-)], dev-python/sphinx-issues[python_targets_python3_11(-)], dev-python/sphinx-issues[python_targets_python3_12(-)], dev-python/sphinx-issues[python_targets_python3_13(-)], dev-python/sphinx-issues[python_targets_python3_14(-)] ]
- NonsolvableDepsInStable: version 20250614: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 20250614: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 20250614: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/asttokens
- MissingRemoteId: missing <remote-id type="github">gristlabs/asttokens</remote-id> (inferred from URI 'https://github.com/gristlabs/asttokens/')
- MissingRemoteId: missing <remote-id type="pypi">asttokens</remote-id> (inferred from URI 'https://pypi.org/project/asttokens/')
- NonexistentDeps: version 3.0.1: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12, dev-python/astroid
- NonexistentDeps: version 3.0.1: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 3.0.1: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14, dev-python/astroid[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)] ]
- NonsolvableDepsInStable: version 3.0.1: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 3.0.1: missing RDEPEND="${PYTHON_DEPS}"
- PythonMissingSCMDependency: version 3.0.1: defines SETUPTOOLS_SCM_PRETEND_VERSION but is missing BDEPEND on setuptools-scm or alike
- UnknownUseFlags: version 3.0.1: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/arrow
- MissingRemoteId: missing <remote-id type="github">arrow-py/arrow</remote-id> (inferred from URI 'https://github.com/arrow-py/arrow/')
- MissingRemoteId: missing <remote-id type="pypi">arrow</remote-id> (inferred from URI 'https://pypi.org/project/arrow/')
- NonexistentDeps: version 1.4.0: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12, dev-python/simplejson, dev-python/tzdata
- NonexistentDeps: version 1.4.0: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12, dev-python/tzdata
- NonsolvableDepsInStable: version 1.4.0: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14, dev-python/simplejson[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], dev-python/tzdata[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)] ]
- NonsolvableDepsInStable: version 1.4.0: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14, dev-python/tzdata[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)] ]
- PythonMissingDeps: version 1.4.0: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 1.4.0: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/blinker
- MissingRemoteId: missing <remote-id type="github">pallets-eco/blinker</remote-id> (inferred from URI 'https://github.com/pallets-eco/blinker/')
- MissingRemoteId: missing <remote-id type="pypi">blinker</remote-id> (inferred from URI 'https://pypi.org/project/blinker/')
- EPyTestPluginsSuggestion: version 1.9.0: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- NonexistentDeps: version 1.9.0: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12, dev-python/pytest-asyncio
- NonexistentDeps: version 1.9.0: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 1.9.0: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14, dev-python/pytest-asyncio[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)] ]
- NonsolvableDepsInStable: version 1.9.0: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 1.9.0: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 1.9.0: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/boltons
- MissingRemoteId: missing <remote-id type="pypi">boltons</remote-id> (inferred from URI 'https://files.pythonhosted.org/packages/source/b/boltons/boltons-25.0.0.tar.gz')
- NonexistentDeps: version 25.0.0: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 25.0.0: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 25.0.0: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 25.0.0: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 25.0.0: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 25.0.0: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/betamax
- MissingRemoteId: missing <remote-id type="github">betamaxpy/betamax</remote-id> (inferred from URI 'https://github.com/betamaxpy/betamax/')
- MissingRemoteId: missing <remote-id type="pypi">betamax</remote-id> (inferred from URI 'https://pypi.org/project/betamax/')
- EPyTestPluginsSuggestion: version 0.9.0: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- NonexistentDeps: version 0.9.0: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 0.9.0: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 0.9.0: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 0.9.0: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 0.9.0: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 0.9.0: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/babel
- MissingRemoteId: missing <remote-id type="github">python-babel/babel</remote-id> (inferred from URI 'https://github.com/python-babel/babel/')
- MissingRemoteId: missing <remote-id type="pypi">babel</remote-id> (inferred from URI 'https://pypi.org/project/babel/')
- EPyTestPluginsSuggestion: version 2.17.0: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- MissingUnpackerDep: version 2.17.0: missing BDEPEND="app-arch/unzip" for SRC_URI archive: [ cldr-common-46.0.zip ]
- NonexistentDeps: version 2.17.0: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 2.17.0: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 2.17.0: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11[threads(+)], app-lang/python:3.12[threads(+)], app-lang/python:3.14[threads(+)] ]
- NonsolvableDepsInStable: version 2.17.0: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11[threads(+)], app-lang/python:3.12[threads(+)], app-lang/python:3.14[threads(+)] ]
- PythonMissingDeps: version 2.17.0: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 2.17.0: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/certifi
- MissingRemoteId: missing <remote-id type="github">tiran/certifi-system-store</remote-id> (inferred from URI 'https://github.com/tiran/certifi-system-store/')
- MissingRemoteId: missing <remote-id type="pypi">certifi-system-store</remote-id> (inferred from URI 'https://pypi.org/project/certifi-system-store/')
- EPyTestPluginsSuggestion: version 3024.7.22: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- NonexistentDeps: version 3024.7.22: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 3024.7.22: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 3024.7.22: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 3024.7.22: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 3024.7.22: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 3024.7.22: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-py/matplotlib
- MissingRemoteId: missing <remote-id type="github">matplotlib/matplotlib</remote-id> (inferred from URI 'https://github.com/matplotlib/matplotlib/')
- MissingRemoteId: missing <remote-id type="pypi">matplotlib</remote-id> (inferred from URI 'https://pypi.org/project/matplotlib/')
- EPyTestPluginsSuggestion: version 3.10.20251129: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- ExcessiveLineLength: version 3.10.20251129: excessive line length (over 120 characters) on line: 156
- NonexistentDeps: version 3.10.20251129: BDEPEND: nonexistent packages: >=dev-python/pygobject-3.40.1-r1:3, dev-python/pytest-rerunfailures, dev-python/xlwt
- NonexistentDeps: version 3.10.20251129: RDEPEND: nonexistent packages: >=dev-python/pygobject-3.40.1-r1:3, dev-python/xlwt
- NonsolvableDepsInStable: version 3.10.20251129: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.14, >=dev-python/pygobject-3.40.1-r1:3[cairo,python_targets_python3_13(-),python_targets_python3_14(-)], dev-python/pytest-rerunfailures[python_targets_python3_13(-),python_targets_python3_14(-)], dev-python/xlwt[python_targets_python3_13(-),python_targets_python3_14(-)] ]
- NonsolvableDepsInStable: version 3.10.20251129: nonsolvable depset(depend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 3.10.20251129: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.14, >=dev-python/pygobject-3.40.1-r1:3[cairo,python_targets_python3_13(-),python_targets_python3_14(-)], dev-python/xlwt[python_targets_python3_13(-),python_targets_python3_14(-)] ]
- PythonMissingDeps: version 3.10.20251129: missing RDEPEND="${PYTHON_DEPS}"
- PythonMissingSCMDependency: version 3.10.20251129: defines SETUPTOOLS_SCM_PRETEND_VERSION but is missing BDEPEND on setuptools-scm or alike
- UnknownLicense: version 3.10.20251129: unknown license: OR
- UnknownUseFlags: version 3.10.20251129: unknown USE flags: 'excel', 'gtk3', 'latex', 'python_targets_python3_13', 'python_targets_python3_14', 'tk', 'webagg', 'wxwidgets'
- VariableOrderWrong: version 3.10.20251129: variable SRC_URI should occur before S
- WhitespaceFound: version 3.10.20251129: ebuild has leading whitespace on lines: 30, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 52, 53, 54, 55, 56, 57, 58, 59, 60
- WhitespaceFound: version 3.10.20251129: ebuild has trailing whitespace on lines: 68, 78

## dev-python/charset-normalizer
- MissingRemoteId: missing <remote-id type="github">jawah/charset_normalizer</remote-id> (inferred from URI 'https://github.com/jawah/charset_normalizer/')
- MissingRemoteId: missing <remote-id type="pypi">charset-normalizer</remote-id> (inferred from URI 'https://pypi.org/project/charset-normalizer/')
- NonexistentDeps: version 3.4.4: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 3.4.4: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 3.4.4: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 3.4.4: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 3.4.4: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 3.4.4: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/characteristic
- MissingRemoteId: missing <remote-id type="github">hynek/characteristic</remote-id> (inferred from URI 'https://github.com/hynek/characteristic/')
- MissingRemoteId: missing <remote-id type="pypi">characteristic</remote-id> (inferred from URI 'https://pypi.org/project/characteristic/')
- EPyTestPluginsSuggestion: version 14.3.0-r4: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- NonexistentDeps: version 14.3.0-r4: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 14.3.0-r4: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 14.3.0-r4: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 14.3.0-r4: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 14.3.0-r4: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 14.3.0-r4: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/chardet
- MissingRemoteId: missing <remote-id type="github">chardet/chardet</remote-id> (inferred from URI 'https://github.com/chardet/chardet/')
- MissingRemoteId: missing <remote-id type="pypi">chardet</remote-id> (inferred from URI 'https://pypi.org/project/chardet/')
- EPyTestPluginsSuggestion: version 5.2.0: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- NonexistentDeps: version 5.2.0: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 5.2.0: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 5.2.0: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 5.2.0: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 5.2.0: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 5.2.0: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/atomicwrites
- MissingRemoteId: missing <remote-id type="github">untitaker/python-atomicwrites</remote-id> (inferred from URI 'https://github.com/untitaker/python-atomicwrites/')
- MissingRemoteId: missing <remote-id type="pypi">atomicwrites</remote-id> (inferred from URI 'https://pypi.org/project/atomicwrites/')
- EPyTestPluginsSuggestion: version 1.4.1: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- NonexistentDeps: version 1.4.1: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12, dev-python/sphinx-rtd-theme
- NonexistentDeps: version 1.4.1: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 1.4.1: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14, dev-python/sphinx-rtd-theme[python_targets_python3_11(-)], dev-python/sphinx-rtd-theme[python_targets_python3_12(-)], dev-python/sphinx-rtd-theme[python_targets_python3_13(-)], dev-python/sphinx-rtd-theme[python_targets_python3_14(-)] ]
- NonsolvableDepsInStable: version 1.4.1: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 1.4.1: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 1.4.1: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/cachetools
- MissingRemoteId: missing <remote-id type="github">tkem/cachetools</remote-id> (inferred from URI 'https://github.com/tkem/cachetools/')
- MissingRemoteId: missing <remote-id type="pypi">cachetools</remote-id> (inferred from URI 'https://pypi.org/project/cachetools/')
- NonexistentDeps: version 6.2.2: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 6.2.2: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 6.2.2: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 6.2.2: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 6.2.2: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 6.2.2: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/bottle
- MissingRemoteId: missing <remote-id type="github">bottlepy/bottle</remote-id> (inferred from URI 'https://github.com/bottlepy/bottle/')
- MissingRemoteId: missing <remote-id type="pypi">bottle</remote-id> (inferred from URI 'https://pypi.org/project/bottle/')
- NonexistentDeps: version 0.13.4: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 0.13.4: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 0.13.4: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 0.13.4: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 0.13.4: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 0.13.4: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'
- WhitespaceFound: version 0.13.4: ebuild has leading whitespace on line: 32

## dev-python/blessed
- MissingRemoteId: missing <remote-id type="github">jquast/blessed</remote-id> (inferred from URI 'https://github.com/jquast/blessed/')
- MissingRemoteId: missing <remote-id type="pypi">blessed</remote-id> (inferred from URI 'https://pypi.org/project/blessed/')
- NonexistentDeps: version 1.23.0: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12, dev-python/sphinx-rtd-theme
- NonexistentDeps: version 1.23.0: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 1.23.0: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14, dev-python/sphinx-rtd-theme[python_targets_python3_11(-)], dev-python/sphinx-rtd-theme[python_targets_python3_12(-)], dev-python/sphinx-rtd-theme[python_targets_python3_13(-)], dev-python/sphinx-rtd-theme[python_targets_python3_14(-)] ]
- NonsolvableDepsInStable: version 1.23.0: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 1.23.0: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 1.23.0: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/attrs
- MissingRemoteId: missing <remote-id type="github">python-attrs/attrs</remote-id> (inferred from URI 'https://github.com/python-attrs/attrs/')
- MissingRemoteId: missing <remote-id type="pypi">attrs</remote-id> (inferred from URI 'https://pypi.org/project/attrs/')
- NonexistentDeps: version 25.4.0: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12, dev-python/zope-interface
- NonexistentDeps: version 25.4.0: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 25.4.0: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.11[sqlite], app-lang/python:3.12, app-lang/python:3.12[sqlite], app-lang/python:3.14, app-lang/python:3.14[sqlite], dev-python/zope-interface[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)] ]
- NonsolvableDepsInStable: version 25.4.0: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 25.4.0: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 25.4.0: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/colored-traceback
- MissingRemoteId: missing <remote-id type="github">staticshock/colored-traceback.py</remote-id> (inferred from URI 'https://github.com/staticshock/colored-traceback.py/')
- MissingRemoteId: missing <remote-id type="pypi">colored-traceback</remote-id> (inferred from URI 'https://pypi.org/project/colored-traceback/')
- NonexistentDeps: version 0.4.2: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 0.4.2: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 0.4.2: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 0.4.2: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 0.4.2: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 0.4.2: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/comm
- MissingRemoteId: missing <remote-id type="github">ipython/comm</remote-id> (inferred from URI 'https://github.com/ipython/comm/')
- MissingRemoteId: missing <remote-id type="pypi">comm</remote-id> (inferred from URI 'https://pypi.org/project/comm/')
- NonexistentDeps: version 0.2.3: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 0.2.3: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 0.2.3: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 0.2.3: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 0.2.3: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 0.2.3: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/colorlog
- MissingRemoteId: missing <remote-id type="github">borntyping/python-colorlog</remote-id> (inferred from URI 'https://github.com/borntyping/python-colorlog/')
- MissingRemoteId: missing <remote-id type="pypi">colorlog</remote-id> (inferred from URI 'https://pypi.org/project/colorlog/')
- NonexistentDeps: version 6.10.1: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 6.10.1: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 6.10.1: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 6.10.1: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 6.10.1: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 6.10.1: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-py/cython
- MissingRemoteId: missing <remote-id type="github">cython/cython</remote-id> (inferred from URI 'https://github.com/cython/cython/archive/64e9d5a759f50c84355d5e102d2ddfac5aec9f0e.tar.gz')
- IndirectInherits: version 20251204: flag-o-matic: indirect inherit usage: 'filter-flags -Wl,-z,defs', line 36
- NonexistentDeps: version 20251204: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12, dev-python/sphinx-issues, dev-python/sphinx-tabs
- NonexistentDeps: version 20251204: DEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 20251204: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 20251204: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11[threads(+)], app-lang/python:3.12[threads(+)], app-lang/python:3.14[threads(+)], dev-python/sphinx-issues[python_targets_python3_11(-)], dev-python/sphinx-issues[python_targets_python3_12(-)], dev-python/sphinx-issues[python_targets_python3_13(-)], dev-python/sphinx-issues[python_targets_python3_14(-)], dev-python/sphinx-tabs[python_targets_python3_11(-)], dev-python/sphinx-tabs[python_targets_python3_12(-)], dev-python/sphinx-tabs[python_targets_python3_13(-)], dev-python/sphinx-tabs[python_targets_python3_14(-)] ]
- NonsolvableDepsInStable: version 20251204: nonsolvable depset(depend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11[threads(+)], app-lang/python:3.12[threads(+)], app-lang/python:3.14[threads(+)] ]
- NonsolvableDepsInStable: version 20251204: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11[threads(+)], app-lang/python:3.12[threads(+)], app-lang/python:3.14[threads(+)] ]
- PythonMissingDeps: version 20251204: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 20251204: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/cloudpickle
- MissingRemoteId: missing <remote-id type="github">cloudpipe/cloudpickle</remote-id> (inferred from URI 'https://github.com/cloudpipe/cloudpickle/')
- MissingRemoteId: missing <remote-id type="pypi">cloudpickle</remote-id> (inferred from URI 'https://pypi.org/project/cloudpickle/')
- NonexistentDeps: version 3.1.2: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 3.1.2: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 3.1.2: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 3.1.2: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 3.1.2: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 3.1.2: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/accelerate
- MissingRemoteId: missing <remote-id type="github">huggingface/accelerate</remote-id> (inferred from URI 'https://github.com/huggingface/accelerate')
- EPyTestPluginsSuggestion: version 1.7.0-r1: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- NonexistentDeps: version 1.7.0-r1: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12, dev-python/caffe2, dev-python/clearml, dev-python/evaluate, dev-python/parameterized, dev-python/pytorch, dev-python/torchdata
- NonexistentDeps: version 1.7.0-r1: DEPEND: nonexistent packages: dev-python/caffe2, dev-python/pytorch
- NonexistentDeps: version 1.7.0-r1: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12, dev-python/caffe2, dev-python/pytorch
- NonsolvableDepsInStable: version 1.7.0-r1: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14, dev-py/numpy[python_targets_python3_11(-)], dev-py/numpy[python_targets_python3_12(-)], dev-python/caffe2[gloo], dev-python/caffe2[python_single_target_python3_11(-),python_single_target_python3_12(-),python_single_target_python3_13(-),python_single_target_python3_14(-)], dev-python/clearml[python_targets_python3_11(-)], dev-python/clearml[python_targets_python3_12(-)], dev-python/clearml[python_targets_python3_13(-)], dev-python/clearml[python_targets_python3_14(-)], dev-python/evaluate[python_single_target_python3_11(-),python_single_target_python3_12(-),python_single_target_python3_13(-),python_single_target_python3_14(-)], dev-python/parameterized[python_targets_python3_11(-)], dev-python/parameterized[python_targets_python3_12(-)], dev-python/parameterized[python_targets_python3_13(-)], dev-python/parameterized[python_targets_python3_14(-)], dev-python/pytorch[python_single_target_python3_11(-),python_single_target_python3_12(-),python_single_target_python3_13(-),python_single_target_python3_14(-)], dev-python/torchdata[python_single_target_python3_11(-),python_single_target_python3_12(-),python_single_target_python3_13(-),python_single_target_python3_14(-)] ]
- NonsolvableDepsInStable: version 1.7.0-r1: nonsolvable depset(depend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ dev-py/numpy[python_targets_python3_11(-)], dev-py/numpy[python_targets_python3_12(-)], dev-python/caffe2[python_single_target_python3_11(-),python_single_target_python3_12(-),python_single_target_python3_13(-),python_single_target_python3_14(-)], dev-python/pytorch[python_single_target_python3_11(-),python_single_target_python3_12(-),python_single_target_python3_13(-),python_single_target_python3_14(-)] ]
- NonsolvableDepsInStable: version 1.7.0-r1: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14, dev-py/numpy[python_targets_python3_11(-)], dev-py/numpy[python_targets_python3_12(-)], dev-python/caffe2[python_single_target_python3_11(-),python_single_target_python3_12(-),python_single_target_python3_13(-),python_single_target_python3_14(-)], dev-python/pytorch[python_single_target_python3_11(-),python_single_target_python3_12(-),python_single_target_python3_13(-),python_single_target_python3_14(-)] ]
- PythonMissingDeps: version 1.7.0-r1: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 1.7.0-r1: unknown USE flags: 'python_single_target_python3_11', 'python_single_target_python3_12', 'python_single_target_python3_13', 'python_single_target_python3_14'

## dev-python/configargparse
- MissingRemoteId: missing <remote-id type="github">bw2/ConfigArgParse</remote-id> (inferred from URI 'https://github.com/bw2/ConfigArgParse/')
- MissingRemoteId: missing <remote-id type="pypi">ConfigArgParse</remote-id> (inferred from URI 'https://pypi.org/project/ConfigArgParse/')
- NonexistentDeps: version 1.7.1: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 1.7.1: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 1.7.1: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 1.7.1: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 1.7.1: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 1.7.1: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/brotlicffi
- MissingRemoteId: missing <remote-id type="github">python-hyper/brotlicffi</remote-id> (inferred from URI 'https://github.com/python-hyper/brotlicffi/')
- MissingRemoteId: missing <remote-id type="pypi">brotlicffi</remote-id> (inferred from URI 'https://pypi.org/project/brotlicffi/')
- EPyTestPluginsSuggestion: version 1.1.0.0: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- IndirectInherits: version 1.1.0.0: flag-o-matic: indirect inherit usage: 'filter-flags -Wl,-z,defs', line 55
- NonexistentDeps: version 1.1.0.0: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 1.1.0.0: DEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 1.1.0.0: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 1.1.0.0: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 1.1.0.0: nonsolvable depset(depend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 1.1.0.0: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 1.1.0.0: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 1.1.0.0: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/cachecontrol
- MissingRemoteId: missing <remote-id type="github">psf/cachecontrol</remote-id> (inferred from URI 'https://github.com/psf/cachecontrol/')
- MissingRemoteId: missing <remote-id type="pypi">CacheControl</remote-id> (inferred from URI 'https://pypi.org/project/CacheControl/')
- EPyTestPluginsSuggestion: version 0.14.3: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- NonexistentDeps: version 0.14.3: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 0.14.3: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 0.14.3: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 0.14.3: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 0.14.3: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 0.14.3: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/configupdater
- MissingRemoteId: missing <remote-id type="github">pyscaffold/configupdater</remote-id> (inferred from URI 'https://github.com/pyscaffold/configupdater/')
- MissingRemoteId: missing <remote-id type="pypi">ConfigUpdater</remote-id> (inferred from URI 'https://pypi.org/project/ConfigUpdater/')
- EPyTestPluginsSuggestion: version 3.2: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- NonexistentDeps: version 3.2: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 3.2: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 3.2: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 3.2: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 3.2: missing RDEPEND="${PYTHON_DEPS}"
- PythonMissingSCMDependency: version 3.2: defines SETUPTOOLS_SCM_PRETEND_VERSION but is missing BDEPEND on setuptools-scm or alike
- UnknownUseFlags: version 3.2: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/cycler
- MissingRemoteId: missing <remote-id type="github">matplotlib/cycler</remote-id> (inferred from URI 'https://github.com/matplotlib/cycler/')
- MissingRemoteId: missing <remote-id type="pypi">cycler</remote-id> (inferred from URI 'https://pypi.org/project/cycler/')
- EPyTestPluginsSuggestion: version 0.12.1: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- NonexistentDeps: version 0.12.1: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 0.12.1: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 0.12.1: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 0.12.1: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 0.12.1: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 0.12.1: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/colorama
- MissingRemoteId: missing <remote-id type="github">tartley/colorama</remote-id> (inferred from URI 'https://github.com/tartley/colorama/')
- MissingRemoteId: missing <remote-id type="pypi">colorama</remote-id> (inferred from URI 'https://pypi.org/project/colorama/')
- EPyTestPluginsSuggestion: version 0.4.6: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- NonexistentDeps: version 0.4.6: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 0.4.6: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 0.4.6: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 0.4.6: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 0.4.6: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 0.4.6: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/cffi
- MissingRemoteId: missing <remote-id type="pypi">cffi</remote-id> (inferred from URI 'https://pypi.org/project/cffi/')
- IndirectInherits: version 2.0.0: flag-o-matic: indirect inherit usage: 'filter-flags -Wl,-z,defs', line 52
- NonexistentDeps: version 2.0.0: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 2.0.0: DEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 2.0.0: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 2.0.0: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 2.0.0: nonsolvable depset(depend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 2.0.0: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 2.0.0: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 2.0.0: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/contourpy
- MissingRemoteId: missing <remote-id type="github">contourpy/contourpy</remote-id> (inferred from URI 'https://github.com/contourpy/contourpy/')
- MissingRemoteId: missing <remote-id type="pypi">contourpy</remote-id> (inferred from URI 'https://pypi.org/project/contourpy/')
- IndirectInherits: version 1.3.3-r1: flag-o-matic: indirect inherit usage: 'filter-flags -Wl,-z,defs', line 52
- NonexistentDeps: version 1.3.3-r1: BDEPEND: nonexistent package: dev-python/wurlitzer
- NonsolvableDepsInStable: version 1.3.3-r1: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.14, dev-python/wurlitzer[python_targets_python3_13(-),python_targets_python3_14(-)] ]
- NonsolvableDepsInStable: version 1.3.3-r1: nonsolvable depset(depend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 1.3.3-r1: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.14 ]
- PythonMissingDeps: version 1.3.3-r1: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 1.3.3-r1: unknown USE flags: 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/cppy
- MissingRemoteId: missing <remote-id type="github">nucleic/cppy</remote-id> (inferred from URI 'https://github.com/nucleic/cppy/')
- MissingRemoteId: missing <remote-id type="pypi">cppy</remote-id> (inferred from URI 'https://pypi.org/project/cppy/')
- EPyTestPluginsSuggestion: version 1.3.1: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- NonexistentDeps: version 1.3.1: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 1.3.1: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 1.3.1: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 1.3.1: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 1.3.1: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 1.3.1: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/distro
- MissingRemoteId: missing <remote-id type="github">python-distro/distro</remote-id> (inferred from URI 'https://github.com/python-distro/distro/')
- MissingRemoteId: missing <remote-id type="pypi">distro</remote-id> (inferred from URI 'https://pypi.org/project/distro/')
- EPyTestPluginsSuggestion: version 1.9.0: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- NonexistentDeps: version 1.9.0: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 1.9.0: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 1.9.0: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 1.9.0: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 1.9.0: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 1.9.0: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/editables
- MissingRemoteId: missing <remote-id type="github">pfmoore/editables</remote-id> (inferred from URI 'https://github.com/pfmoore/editables/')
- MissingRemoteId: missing <remote-id type="pypi">editables</remote-id> (inferred from URI 'https://pypi.org/project/editables/')
- EPyTestPluginsSuggestion: version 0.5: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- NonexistentDeps: version 0.5: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 0.5: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 0.5: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 0.5: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 0.5: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 0.5: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/distlib
- MissingRemoteId: missing <remote-id type="github">pypa/distlib</remote-id> (inferred from URI 'https://github.com/pypa/distlib/')
- MissingRemoteId: missing <remote-id type="pypi">distlib</remote-id> (inferred from URI 'https://pypi.org/project/distlib/')
- NonexistentDeps: version 0.4.0: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 0.4.0: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 0.4.0: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 0.4.0: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 0.4.0: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 0.4.0: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/defusedxml
- MissingRemoteId: missing <remote-id type="github">tiran/defusedxml</remote-id> (inferred from URI 'https://github.com/tiran/defusedxml/')
- MissingRemoteId: missing <remote-id type="pypi">defusedxml</remote-id> (inferred from URI 'https://pypi.org/project/defusedxml/')
- NonexistentDeps: version 0.7.1-r1: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 0.7.1-r1: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 0.7.1-r1: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11[xml(+)], app-lang/python:3.12[xml(+)], app-lang/python:3.14[xml(+)] ]
- NonsolvableDepsInStable: version 0.7.1-r1: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11[xml(+)], app-lang/python:3.12[xml(+)], app-lang/python:3.14[xml(+)] ]
- PythonMissingDeps: version 0.7.1-r1: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 0.7.1-r1: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/cairocffi
- MissingRemoteId: missing <remote-id type="github">Kozea/cairocffi</remote-id> (inferred from URI 'https://github.com/Kozea/cairocffi/')
- MissingRemoteId: missing <remote-id type="pypi">cairocffi</remote-id> (inferred from URI 'https://pypi.org/project/cairocffi/')
- NonexistentDeps: version 1.7.1-r1: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12, dev-python/pikepdf, x11-libs/cairo:0, x11-libs/gdk-pixbuf
- NonexistentDeps: version 1.7.1-r1: DEPEND: nonexistent packages: x11-libs/cairo:0, x11-libs/gdk-pixbuf
- NonexistentDeps: version 1.7.1-r1: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12, x11-libs/cairo:0, x11-libs/gdk-pixbuf
- NonsolvableDepsInStable: version 1.7.1-r1: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14, dev-py/numpy[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], dev-python/pikepdf[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], x11-libs/cairo:0=[X,xcb(+)], x11-libs/gdk-pixbuf[jpeg] ]
- NonsolvableDepsInStable: version 1.7.1-r1: nonsolvable depset(depend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ x11-libs/cairo:0=[X,xcb(+)], x11-libs/gdk-pixbuf[jpeg] ]
- NonsolvableDepsInStable: version 1.7.1-r1: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14, x11-libs/cairo:0=[X,xcb(+)], x11-libs/gdk-pixbuf[jpeg] ]
- PythonMissingDeps: version 1.7.1-r1: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 1.7.1-r1: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'
- WhitespaceFound: version 1.7.1-r1: ebuild has trailing whitespace on line: 8

## dev-python/cssselect
- MissingRemoteId: missing <remote-id type="github">scrapy/cssselect</remote-id> (inferred from URI 'https://github.com/scrapy/cssselect/')
- MissingRemoteId: missing <remote-id type="pypi">cssselect</remote-id> (inferred from URI 'https://pypi.org/project/cssselect/')
- NonexistentDeps: version 1.3.0: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12, dev-python/sphinx-rtd-theme
- NonexistentDeps: version 1.3.0: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 1.3.0: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14, dev-python/sphinx-rtd-theme[python_targets_python3_11(-)], dev-python/sphinx-rtd-theme[python_targets_python3_12(-)], dev-python/sphinx-rtd-theme[python_targets_python3_13(-)], dev-python/sphinx-rtd-theme[python_targets_python3_14(-)] ]
- NonsolvableDepsInStable: version 1.3.0: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 1.3.0: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 1.3.0: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/black
- MissingRemoteId: missing <remote-id type="github">psf/black</remote-id> (inferred from URI 'https://github.com/psf/black/')
- MissingRemoteId: missing <remote-id type="pypi">black</remote-id> (inferred from URI 'https://pypi.org/project/black/')
- NonexistentDeps: version 25.11.0: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12, dev-python/aiohttp-cors
- NonexistentDeps: version 25.11.0: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 25.11.0: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14, dev-python/aiohttp-cors[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)] ]
- NonsolvableDepsInStable: version 25.11.0: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 25.11.0: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 25.11.0: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'
- WhitespaceFound: version 25.11.0: ebuild has leading whitespace on line: 59

## dev-python/emoji
- MissingRemoteId: missing <remote-id type="github">carpedm20/emoji</remote-id> (inferred from URI 'https://github.com/carpedm20/emoji/')
- MissingRemoteId: missing <remote-id type="pypi">emoji</remote-id> (inferred from URI 'https://pypi.org/project/emoji/')
- NonexistentDeps: version 2.15.0: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 2.15.0: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 2.15.0: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 2.15.0: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 2.15.0: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 2.15.0: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/cloudscraper
- MissingRemoteId: missing <remote-id type="github">VeNoMouS/cloudscraper</remote-id> (inferred from URI 'https://github.com/VeNoMouS/cloudscraper/')
- MissingRemoteId: missing <remote-id type="pypi">cloudscraper</remote-id> (inferred from URI 'https://pypi.org/project/cloudscraper/')
- NonexistentDeps: version 1.2.69-r1: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12, dev-python/responses, net-libs/nodejs
- NonexistentDeps: version 1.2.69-r1: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 1.2.69-r1: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14, dev-python/responses[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], net-libs/nodejs ]
- NonsolvableDepsInStable: version 1.2.69-r1: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 1.2.69-r1: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 1.2.69-r1: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'
- WhitespaceFound: version 1.2.69-r1: ebuild has leading whitespace on lines: 48, 50
- WhitespaceFound: version 1.2.69-r1: ebuild has trailing whitespace on line: 8

## dev-python/configobj
- MissingRemoteId: missing <remote-id type="github">DiffSK/configobj</remote-id> (inferred from URI 'https://github.com/DiffSK/configobj/')
- MissingRemoteId: missing <remote-id type="pypi">configobj</remote-id> (inferred from URI 'https://pypi.org/project/configobj/')
- EPyTestPluginsSuggestion: version 5.0.9: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- NonexistentDeps: version 5.0.9: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 5.0.9: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 5.0.9: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 5.0.9: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 5.0.9: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 5.0.9: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/coverage
- MissingRemoteId: missing <remote-id type="github">coveragepy/coveragepy</remote-id> (inferred from URI 'https://github.com/coveragepy/coveragepy/')
- MissingRemoteId: missing <remote-id type="pypi">coverage</remote-id> (inferred from URI 'https://pypi.org/project/coverage/')
- NonexistentDeps: version 7.11.3: BDEPEND: nonexistent packages: >=dev-python/unittest-mixins-1.4, app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 7.11.3: DEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 7.11.3: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 7.11.3: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11[sqlite(+),threads(+)], app-lang/python:3.12[sqlite(+),threads(+)], app-lang/python:3.14[sqlite(+),threads(+)], >=dev-python/unittest-mixins-1.4[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)] ]
- NonsolvableDepsInStable: version 7.11.3: nonsolvable depset(depend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11[sqlite(+),threads(+)], app-lang/python:3.12[sqlite(+),threads(+)], app-lang/python:3.14[sqlite(+),threads(+)] ]
- NonsolvableDepsInStable: version 7.11.3: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11[sqlite(+),threads(+)], app-lang/python:3.12[sqlite(+),threads(+)], app-lang/python:3.14[sqlite(+),threads(+)] ]
- PythonMissingDeps: version 7.11.3: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 7.11.3: unknown USE flags: 'native-extensions', 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/evdev
- MissingRemoteId: missing <remote-id type="github">gvalkov/python-evdev</remote-id> (inferred from URI 'https://github.com/gvalkov/python-evdev/')
- MissingRemoteId: missing <remote-id type="pypi">evdev</remote-id> (inferred from URI 'https://pypi.org/project/evdev/')
- EPyTestPluginsSuggestion: version 1.9.2: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- NonexistentDeps: version 1.9.2: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 1.9.2: DEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 1.9.2: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 1.9.2: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 1.9.2: nonsolvable depset(depend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 1.9.2: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 1.9.2: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 1.9.2: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/exceptiongroup
- MissingRemoteId: missing <remote-id type="github">agronholm/exceptiongroup</remote-id> (inferred from URI 'https://github.com/agronholm/exceptiongroup/')
- MissingRemoteId: missing <remote-id type="pypi">exceptiongroup</remote-id> (inferred from URI 'https://pypi.org/project/exceptiongroup/')
- EPyTestPluginsSuggestion: version 1.3.0: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- NonexistentDeps: version 1.3.0: BDEPEND: nonexistent packages: >=dev-python/flit-scm-1.7.0, app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 1.3.0: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 1.3.0: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14, >=dev-python/flit-scm-1.7.0[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)] ]
- NonsolvableDepsInStable: version 1.3.0: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 1.3.0: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 1.3.0: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/diskcache
- MissingRemoteId: missing <remote-id type="github">grantjenks/python-diskcache</remote-id> (inferred from URI 'https://github.com/grantjenks/python-diskcache/')
- MissingRemoteId: missing <remote-id type="pypi">diskcache</remote-id> (inferred from URI 'https://pypi.org/project/diskcache/')
- NonexistentDeps: version 5.6.3: BDEPEND: nonexistent packages: >=dev-python/django-3.2, app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 5.6.3: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 5.6.3: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11[sqlite], app-lang/python:3.12[sqlite], app-lang/python:3.14[sqlite], >=dev-python/django-3.2[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)] ]
- NonsolvableDepsInStable: version 5.6.3: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11[sqlite], app-lang/python:3.12[sqlite], app-lang/python:3.14[sqlite] ]
- PythonMissingDeps: version 5.6.3: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 5.6.3: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/expandvars
- MissingRemoteId: missing <remote-id type="github">sayanarijit/expandvars</remote-id> (inferred from URI 'https://github.com/sayanarijit/expandvars/')
- MissingRemoteId: missing <remote-id type="pypi">expandvars</remote-id> (inferred from URI 'https://pypi.org/project/expandvars/')
- NonexistentDeps: version 1.1.2: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 1.1.2: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 1.1.2: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 1.1.2: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 1.1.2: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 1.1.2: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/fastjsonschema
- MissingRemoteId: missing <remote-id type="github">horejsek/python-fastjsonschema</remote-id> (inferred from URI 'https://github.com/horejsek/python-fastjsonschema/')
- MissingRemoteId: missing <remote-id type="pypi">fastjsonschema</remote-id> (inferred from URI 'https://pypi.org/project/fastjsonschema/')
- NonexistentDeps: version 2.21.2: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 2.21.2: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 2.21.2: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 2.21.2: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 2.21.2: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 2.21.2: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/dependency-groups
- MissingRemoteId: missing <remote-id type="github">pypa/dependency-groups</remote-id> (inferred from URI 'https://github.com/pypa/dependency-groups/')
- MissingRemoteId: missing <remote-id type="pypi">dependency-groups</remote-id> (inferred from URI 'https://pypi.org/project/dependency-groups/')
- EPyTestPluginsSuggestion: version 1.3.1: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- NonexistentDeps: version 1.3.1: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 1.3.1: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 1.3.1: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 1.3.1: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 1.3.1: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 1.3.1: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/execnet
- MissingRemoteId: missing <remote-id type="github">pytest-dev/execnet</remote-id> (inferred from URI 'https://github.com/pytest-dev/execnet/')
- MissingRemoteId: missing <remote-id type="pypi">execnet</remote-id> (inferred from URI 'https://pypi.org/project/execnet/')
- NonexistentDeps: version 2.1.2: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 2.1.2: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 2.1.2: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 2.1.2: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 2.1.2: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 2.1.2: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/elementpath
- MissingRemoteId: missing <remote-id type="github">sissaschool/elementpath</remote-id> (inferred from URI 'https://github.com/sissaschool/elementpath/')
- MissingRemoteId: missing <remote-id type="pypi">elementpath</remote-id> (inferred from URI 'https://pypi.org/project/elementpath/')
- NonexistentDeps: version 5.0.4: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 5.0.4: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 5.0.4: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 5.0.4: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 5.0.4: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 5.0.4: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/fqdn
- MissingRemoteId: missing <remote-id type="github">ypcrts/fqdn</remote-id> (inferred from URI 'https://github.com/ypcrts/fqdn/')
- MissingRemoteId: missing <remote-id type="pypi">fqdn</remote-id> (inferred from URI 'https://pypi.org/project/fqdn/')
- EPyTestPluginsSuggestion: version 1.5.1-r2: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- NonexistentDeps: version 1.5.1-r2: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 1.5.1-r2: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 1.5.1-r2: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 1.5.1-r2: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 1.5.1-r2: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 1.5.1-r2: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/flaky
- MissingRemoteId: missing <remote-id type="github">box/flaky</remote-id> (inferred from URI 'https://github.com/box/flaky/')
- MissingRemoteId: missing <remote-id type="pypi">flaky</remote-id> (inferred from URI 'https://pypi.org/project/flaky/')
- NonexistentDeps: version 3.8.1: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 3.8.1: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 3.8.1: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 3.8.1: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 3.8.1: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 3.8.1: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/fields
- MissingRemoteId: missing <remote-id type="github">ionelmc/python-fields</remote-id> (inferred from URI 'https://github.com/ionelmc/python-fields/')
- MissingRemoteId: missing <remote-id type="pypi">fields</remote-id> (inferred from URI 'https://pypi.org/project/fields/')
- EPyTestPluginsSuggestion: version 5.0.0-r3: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- NonexistentDeps: version 5.0.0-r3: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 5.0.0-r3: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 5.0.0-r3: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 5.0.0-r3: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 5.0.0-r3: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 5.0.0-r3: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/executing
- MissingRemoteId: missing <remote-id type="github">alexmojaki/executing</remote-id> (inferred from URI 'https://github.com/alexmojaki/executing/')
- MissingRemoteId: missing <remote-id type="pypi">executing</remote-id> (inferred from URI 'https://pypi.org/project/executing/')
- NonexistentDeps: version 2.2.1: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12, dev-python/littleutils
- NonexistentDeps: version 2.2.1: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 2.2.1: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14, dev-python/littleutils[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)] ]
- NonsolvableDepsInStable: version 2.2.1: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 2.2.1: missing RDEPEND="${PYTHON_DEPS}"
- PythonMissingSCMDependency: version 2.2.1: defines SETUPTOOLS_SCM_PRETEND_VERSION but is missing BDEPEND on setuptools-scm or alike
- UnknownUseFlags: version 2.2.1: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'
- WhitespaceFound: version 2.2.1: ebuild has leading whitespace on line: 57
- WhitespaceFound: version 2.2.1: ebuild has trailing whitespace on line: 10

## dev-python/faker
- MissingRemoteId: missing <remote-id type="github">joke2k/faker</remote-id> (inferred from URI 'https://github.com/joke2k/faker/')
- MissingRemoteId: missing <remote-id type="pypi">Faker</remote-id> (inferred from URI 'https://pypi.org/project/Faker/')
- NonexistentBlocker: version 38.0.0: nonexistent blocker BDEPEND="!dev-ruby/faker": no matches in repo history
- NonexistentBlocker: version 38.0.0: nonexistent blocker RDEPEND="!dev-ruby/faker": no matches in repo history
- NonexistentDeps: version 38.0.0: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12, dev-python/tzdata, dev-python/validators
- NonexistentDeps: version 38.0.0: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12, dev-python/tzdata
- NonsolvableDepsInStable: version 38.0.0: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14, dev-python/tzdata[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], dev-python/validators[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)] ]
- NonsolvableDepsInStable: version 38.0.0: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14, dev-python/tzdata[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)] ]
- PythonMissingDeps: version 38.0.0: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 38.0.0: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/filelock
- MissingRemoteId: missing <remote-id type="github">tox-dev/filelock</remote-id> (inferred from URI 'https://github.com/tox-dev/filelock/')
- MissingRemoteId: missing <remote-id type="pypi">filelock</remote-id> (inferred from URI 'https://pypi.org/project/filelock/')
- NonexistentDeps: version 3.20.0: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 3.20.0: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 3.20.0: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 3.20.0: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 3.20.0: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 3.20.0: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/gpep517
- MissingRemoteId: missing <remote-id type="github">projg2/gpep517</remote-id> (inferred from URI 'https://github.com/projg2/gpep517/')
- MissingRemoteId: missing <remote-id type="pypi">gpep517</remote-id> (inferred from URI 'https://pypi.org/project/gpep517/')
- NonexistentDeps: version 19: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 19: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 19: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 19: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 19: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 19: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/genty
- MissingRemoteId: missing <remote-id type="github">box/genty</remote-id> (inferred from URI 'https://github.com/box/genty/')
- MissingRemoteId: missing <remote-id type="pypi">genty</remote-id> (inferred from URI 'https://pypi.org/project/genty/')
- NonexistentDeps: version 1.3.2-r3: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 1.3.2-r3: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 1.3.2-r3: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 1.3.2-r3: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 1.3.2-r3: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 1.3.2-r3: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/furo
- MissingRemoteId: missing <remote-id type="github">pradyunsg/furo</remote-id> (inferred from URI 'https://github.com/pradyunsg/furo/')
- MissingRemoteId: missing <remote-id type="pypi">furo</remote-id> (inferred from URI 'https://pypi.org/project/furo/')
- NonexistentDeps: version 2025.9.25: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 2025.9.25: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12, dev-python/beautifulsoup4, dev-python/sphinx-basic-ng
- NonsolvableDepsInStable: version 2025.9.25: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 2025.9.25: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14, dev-python/beautifulsoup4[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], dev-python/sphinx-basic-ng[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)] ]
- PythonMissingDeps: version 2025.9.25: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 2025.9.25: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/freezegun
- MissingRemoteId: missing <remote-id type="github">spulec/freezegun</remote-id> (inferred from URI 'https://github.com/spulec/freezegun/')
- MissingRemoteId: missing <remote-id type="pypi">freezegun</remote-id> (inferred from URI 'https://pypi.org/project/freezegun/')
- NonexistentDeps: version 1.5.5: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 1.5.5: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 1.5.5: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.11[sqlite], app-lang/python:3.12, app-lang/python:3.12[sqlite], app-lang/python:3.14, app-lang/python:3.14[sqlite] ]
- NonsolvableDepsInStable: version 1.5.5: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 1.5.5: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 1.5.5: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/fido2
- MissingRemoteId: missing <remote-id type="github">Yubico/python-fido2</remote-id> (inferred from URI 'https://github.com/Yubico/python-fido2/')
- MissingRemoteId: missing <remote-id type="pypi">fido2</remote-id> (inferred from URI 'https://pypi.org/project/fido2/')
- EPyTestPluginsSuggestion: version 2.0.0: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- NonexistentDeps: version 2.0.0: BDEPEND: nonexistent packages: <dev-py/pyscard-3, app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 2.0.0: RDEPEND: nonexistent packages: <dev-py/pyscard-3, app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 2.0.0: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14, <dev-py/pyscard-3[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)] ]
- NonsolvableDepsInStable: version 2.0.0: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14, <dev-py/pyscard-3[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)] ]
- PythonMissingDeps: version 2.0.0: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 2.0.0: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/h11
- MissingRemoteId: missing <remote-id type="github">python-hyper/h11</remote-id> (inferred from URI 'https://github.com/python-hyper/h11/')
- MissingRemoteId: missing <remote-id type="pypi">h11</remote-id> (inferred from URI 'https://pypi.org/project/h11/')
- EPyTestPluginsSuggestion: version 0.16.0: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- NonexistentDeps: version 0.16.0: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 0.16.0: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 0.16.0: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 0.16.0: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 0.16.0: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 0.16.0: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/cherrypy
- MissingRemoteId: missing <remote-id type="github">cherrypy/cherrypy</remote-id> (inferred from URI 'https://github.com/cherrypy/cherrypy/')
- MissingRemoteId: missing <remote-id type="pypi">CherryPy</remote-id> (inferred from URI 'https://pypi.org/project/CherryPy/')
- EPyTestPluginsSuggestion: version 18.10.0: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- NonexistentDeps: version 18.10.0: BDEPEND: nonexistent packages: >=dev-python/cheroot-8.2.1, app-lang/python:3.11, app-lang/python:3.12, dev-python/objgraph, dev-python/routes, dev-python/simplejson, dev-python/zc-lockfile
- NonexistentDeps: version 18.10.0: RDEPEND: nonexistent packages: >=dev-python/cheroot-8.2.1, app-lang/python:3.11, app-lang/python:3.12, dev-python/zc-lockfile
- NonsolvableDepsInStable: version 18.10.0: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14, >=dev-python/cheroot-8.2.1[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], dev-python/objgraph[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], dev-python/routes[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], dev-python/simplejson[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], dev-python/zc-lockfile[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)] ]
- NonsolvableDepsInStable: version 18.10.0: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14, >=dev-python/cheroot-8.2.1[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], dev-python/zc-lockfile[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)] ]
- PythonMissingDeps: version 18.10.0: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 18.10.0: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'
- WhitespaceFound: version 18.10.0: ebuild has trailing whitespace on line: 41

## dev-python/gitdb
- MissingRemoteId: missing <remote-id type="github">gitpython-developers/gitdb</remote-id> (inferred from URI 'https://github.com/gitpython-developers/gitdb/')
- MissingRemoteId: missing <remote-id type="pypi">gitdb</remote-id> (inferred from URI 'https://pypi.org/project/gitdb/')
- EPyTestPluginsSuggestion: version 4.0.12: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- NonexistentDeps: version 4.0.12: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 4.0.12: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 4.0.12: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 4.0.12: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 4.0.12: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 4.0.12: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'
- WhitespaceFound: version 4.0.12: ebuild has trailing whitespace on line: 24

## dev-python/flit-core
- MissingRemoteId: missing <remote-id type="github">pypa/flit</remote-id> (inferred from URI 'https://github.com/pypa/flit/')
- MissingRemoteId: missing <remote-id type="pypi">flit-core</remote-id> (inferred from URI 'https://pypi.org/project/flit-core/')
- EPyTestPluginsSuggestion: version 3.12.0: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- NonexistentDeps: version 3.12.0: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 3.12.0: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 3.12.0: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 3.12.0: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 3.12.0: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 3.12.0: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/frozenlist
- MissingRemoteId: missing <remote-id type="github">aio-libs/frozenlist</remote-id> (inferred from URI 'https://github.com/aio-libs/frozenlist/')
- MissingRemoteId: missing <remote-id type="pypi">frozenlist</remote-id> (inferred from URI 'https://pypi.org/project/frozenlist/')
- IndirectInherits: version 1.8.0: flag-o-matic: indirect inherit usage: 'filter-flags -Wl,-z,defs', line 41
- NonexistentDeps: version 1.8.0: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 1.8.0: DEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 1.8.0: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 1.8.0: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 1.8.0: nonsolvable depset(depend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 1.8.0: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 1.8.0: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 1.8.0: unknown USE flags: 'native-extensions', 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/hpack
- MissingRemoteId: missing <remote-id type="github">python-hyper/hpack</remote-id> (inferred from URI 'https://github.com/python-hyper/hpack/')
- MissingRemoteId: missing <remote-id type="pypi">hpack</remote-id> (inferred from URI 'https://pypi.org/project/hpack/')
- EPyTestPluginsSuggestion: version 4.1.0: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- NonexistentDeps: version 4.1.0: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 4.1.0: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 4.1.0: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 4.1.0: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 4.1.0: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 4.1.0: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/hatch-vcs
- MissingRemoteId: missing <remote-id type="github">ofek/hatch-vcs</remote-id> (inferred from URI 'https://github.com/ofek/hatch-vcs/')
- MissingRemoteId: missing <remote-id type="pypi">hatch-vcs</remote-id> (inferred from URI 'https://pypi.org/project/hatch-vcs/')
- EPyTestPluginsSuggestion: version 0.5.0: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- NonexistentDeps: version 0.5.0: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 0.5.0: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 0.5.0: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 0.5.0: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 0.5.0: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 0.5.0: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'
- WhitespaceFound: version 0.5.0: ebuild has trailing whitespace on line: 28

## dev-python/hatch-fancy-pypi-readme
- MissingRemoteId: missing <remote-id type="github">hynek/hatch-fancy-pypi-readme</remote-id> (inferred from URI 'https://github.com/hynek/hatch-fancy-pypi-readme/')
- MissingRemoteId: missing <remote-id type="pypi">hatch-fancy-pypi-readme</remote-id> (inferred from URI 'https://pypi.org/project/hatch-fancy-pypi-readme/')
- EPyTestPluginsSuggestion: version 25.1.0: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- NonexistentDeps: version 25.1.0: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 25.1.0: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 25.1.0: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 25.1.0: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 25.1.0: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 25.1.0: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/aiohttp
- MissingRemoteId: missing <remote-id type="github">aio-libs/aiohttp</remote-id> (inferred from URI 'https://github.com/aio-libs/aiohttp/')
- MissingRemoteId: missing <remote-id type="pypi">aiohttp</remote-id> (inferred from URI 'https://pypi.org/project/aiohttp/')
- IndirectInherits: version 3.13.2: flag-o-matic: indirect inherit usage: 'filter-flags -Wl,-z,defs', line 104
- NonexistentDeps: version 3.13.2: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12, dev-python/backports-zstd, dev-python/blockbuster, dev-python/isal, dev-python/pkgconfig, dev-python/re-assert, dev-python/time-machine, dev-python/zlib-ng, net-libs/llhttp:=, www-servers/gunicorn
- NonexistentDeps: version 3.13.2: DEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12, net-libs/llhttp:=
- NonexistentDeps: version 3.13.2: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12, net-libs/llhttp:=
- NonsolvableDepsInStable: version 3.13.2: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14, dev-python/backports-zstd[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-)], dev-python/blockbuster[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], dev-python/isal[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], dev-python/pkgconfig[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], dev-python/re-assert[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], dev-python/time-machine[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], dev-python/zlib-ng[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], net-libs/llhttp:=, www-servers/gunicorn[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)] ]
- NonsolvableDepsInStable: version 3.13.2: nonsolvable depset(depend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14, net-libs/llhttp:= ]
- NonsolvableDepsInStable: version 3.13.2: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14, net-libs/llhttp:= ]
- PythonMissingDeps: version 3.13.2: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 3.13.2: unknown USE flags: 'native-extensions', 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14', 'test-rust'

## dev-python/html2text
- MissingRemoteId: missing <remote-id type="github">Alir3z4/html2text</remote-id> (inferred from URI 'https://github.com/Alir3z4/html2text/')
- MissingRemoteId: missing <remote-id type="pypi">html2text</remote-id> (inferred from URI 'https://pypi.org/project/html2text/')
- EPyTestPluginsSuggestion: version 2025.4.15-r1: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- NonexistentDeps: version 2025.4.15-r1: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 2025.4.15-r1: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 2025.4.15-r1: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 2025.4.15-r1: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 2025.4.15-r1: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 2025.4.15-r1: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/idna
- MissingRemoteId: missing <remote-id type="github">kjd/idna</remote-id> (inferred from URI 'https://github.com/kjd/idna/')
- MissingRemoteId: missing <remote-id type="pypi">idna</remote-id> (inferred from URI 'https://pypi.org/project/idna/')
- NonexistentDeps: version 3.11: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 3.11: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 3.11: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 3.11: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 3.11: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 3.11: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/hyperframe
- MissingRemoteId: missing <remote-id type="github">python-hyper/hyperframe</remote-id> (inferred from URI 'https://github.com/python-hyper/hyperframe/')
- MissingRemoteId: missing <remote-id type="pypi">hyperframe</remote-id> (inferred from URI 'https://pypi.org/project/hyperframe/')
- EPyTestPluginsSuggestion: version 6.1.0: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- NonexistentDeps: version 6.1.0: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 6.1.0: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 6.1.0: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 6.1.0: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 6.1.0: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 6.1.0: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/build
- MissingRemoteId: missing <remote-id type="github">pypa/build</remote-id> (inferred from URI 'https://github.com/pypa/build/')
- MissingRemoteId: missing <remote-id type="pypi">build</remote-id> (inferred from URI 'https://pypi.org/project/build/')
- NonexistentDeps: version 1.3.0: BDEPEND: nonexistent packages: >=dev-python/pytest-mock-2, >=dev-python/pytest-rerunfailures-9.1, app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 1.3.0: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 1.3.0: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14, >=dev-python/pytest-mock-2[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], >=dev-python/pytest-rerunfailures-9.1[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)] ]
- NonsolvableDepsInStable: version 1.3.0: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 1.3.0: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 1.3.0: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14', 'test-rust'
- WhitespaceFound: version 1.3.0: ebuild has trailing whitespace on line: 46

## dev-python/ensurepip-setuptools
- MissingRemoteId: missing <remote-id type="github">pypa/setuptools</remote-id> (inferred from URI 'https://github.com/pypa/setuptools/')
- MissingRemoteId: missing <remote-id type="pypi">setuptools</remote-id> (inferred from URI 'https://pypi.org/project/setuptools/')
- NonexistentDeps: version 80.9.0-r1: BDEPEND: nonexistent packages: >=dev-python/jaraco-test-5.5, app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 80.9.0-r1: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 80.9.0-r1: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11[xml(+)], app-lang/python:3.12[xml(+)], app-lang/python:3.14[xml(+)], >=dev-python/jaraco-test-5.5[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)] ]
- NonsolvableDepsInStable: version 80.9.0-r1: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11[xml(+)], app-lang/python:3.12[xml(+)], app-lang/python:3.14[xml(+)] ]
- PythonMissingDeps: version 80.9.0-r1: missing RDEPEND="${PYTHON_DEPS}"
- ReferenceInMetadataVar: version 80.9.0-r1: LICENSE includes variable: VENDOR_LICENSES[*]
- UnknownUseFlags: version 80.9.0-r1: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'
- VariableOrderWrong: version 80.9.0-r1: variable LICENSE should occur before RESTRICT

## dev-python/fsspec
- MissingRemoteId: missing <remote-id type="github">fsspec/filesystem_spec</remote-id> (inferred from URI 'https://github.com/fsspec/filesystem_spec/')
- MissingRemoteId: missing <remote-id type="pypi">fsspec</remote-id> (inferred from URI 'https://pypi.org/project/fsspec/')
- NonexistentDeps: version 2025.10.0: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 2025.10.0: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 2025.10.0: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14, dev-py/numpy[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)] ]
- NonsolvableDepsInStable: version 2025.10.0: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 2025.10.0: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 2025.10.0: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/imagesize
- MissingRemoteId: missing <remote-id type="github">shibukawa/imagesize_py</remote-id> (inferred from URI 'https://github.com/shibukawa/imagesize_py/')
- MissingRemoteId: missing <remote-id type="pypi">imagesize</remote-id> (inferred from URI 'https://pypi.org/project/imagesize/')
- EPyTestPluginsSuggestion: version 1.4.1: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- NonexistentDeps: version 1.4.1: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 1.4.1: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 1.4.1: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 1.4.1: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 1.4.1: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 1.4.1: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/h2
- MissingRemoteId: missing <remote-id type="github">python-hyper/h2</remote-id> (inferred from URI 'https://github.com/python-hyper/h2/')
- MissingRemoteId: missing <remote-id type="pypi">h2</remote-id> (inferred from URI 'https://pypi.org/project/h2/')
- NonexistentDeps: version 4.3.0: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 4.3.0: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 4.3.0: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 4.3.0: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 4.3.0: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 4.3.0: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/immutables
- MissingRemoteId: missing <remote-id type="github">MagicStack/immutables</remote-id> (inferred from URI 'https://github.com/MagicStack/immutables/')
- MissingRemoteId: missing <remote-id type="pypi">immutables</remote-id> (inferred from URI 'https://pypi.org/project/immutables/')
- EPyTestPluginsSuggestion: version 0.21: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- NonexistentDeps: version 0.21: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 0.21: DEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 0.21: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 0.21: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 0.21: nonsolvable depset(depend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 0.21: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 0.21: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 0.21: unknown USE flags: 'native-extensions', 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/iniconfig
- MissingRemoteId: missing <remote-id type="github">pytest-dev/iniconfig</remote-id> (inferred from URI 'https://github.com/pytest-dev/iniconfig/')
- MissingRemoteId: missing <remote-id type="pypi">iniconfig</remote-id> (inferred from URI 'https://pypi.org/project/iniconfig/')
- NonexistentDeps: version 2.3.0: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 2.3.0: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 2.3.0: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 2.3.0: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 2.3.0: missing RDEPEND="${PYTHON_DEPS}"
- PythonMissingSCMDependency: version 2.3.0: defines SETUPTOOLS_SCM_PRETEND_VERSION but is missing BDEPEND on setuptools-scm or alike
- UnknownUseFlags: version 2.3.0: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/incremental
- MissingRemoteId: missing <remote-id type="github">twisted/incremental</remote-id> (inferred from URI 'https://github.com/twisted/incremental/')
- MissingRemoteId: missing <remote-id type="pypi">incremental</remote-id> (inferred from URI 'https://pypi.org/project/incremental/')
- NonexistentDeps: version 24.7.2: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12, dev-python/twisted
- NonexistentDeps: version 24.7.2: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 24.7.2: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14, dev-python/twisted[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)] ]
- NonsolvableDepsInStable: version 24.7.2: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 24.7.2: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 24.7.2: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/intervaltree
- MissingRemoteId: missing <remote-id type="github">chaimleib/intervaltree</remote-id> (inferred from URI 'https://github.com/chaimleib/intervaltree/')
- MissingRemoteId: missing <remote-id type="pypi">intervaltree</remote-id> (inferred from URI 'https://pypi.org/project/intervaltree/')
- EPyTestPluginsSuggestion: version 3.1.0-r1: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- NonexistentDeps: version 3.1.0-r1: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 3.1.0-r1: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 3.1.0-r1: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 3.1.0-r1: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 3.1.0-r1: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 3.1.0-r1: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/importlib-metadata
- MissingRemoteId: missing <remote-id type="github">python/importlib_metadata</remote-id> (inferred from URI 'https://github.com/python/importlib_metadata/')
- MissingRemoteId: missing <remote-id type="pypi">importlib-metadata</remote-id> (inferred from URI 'https://pypi.org/project/importlib-metadata/')
- NonexistentDeps: version 8.7.0: BDEPEND: nonexistent packages: >=dev-python/jaraco-test-5.4, app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 8.7.0: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 8.7.0: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14, >=dev-python/jaraco-test-5.4[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)] ]
- NonsolvableDepsInStable: version 8.7.0: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 8.7.0: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 8.7.0: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-py/setuptools
- MissingRemoteId: missing <remote-id type="github">pypa/setuptools</remote-id> (inferred from URI 'https://github.com/pypa/setuptools/')
- NonexistentBlocker: version 20251031: nonexistent blocker BDEPEND="!<=dev-libs/gobject-introspection-1.76.1-r0": no matches in repo history
- NonexistentBlocker: version 20251031: nonexistent blocker BDEPEND="!<dev-py/setuptools-rust-1.8.0": no matches in repo history
- NonexistentBlocker: version 20251031: nonexistent blocker BDEPEND="!=dev-libs/gobject-introspection-1.78.1-r0": no matches in repo history
- NonexistentBlocker: version 20251031: nonexistent blocker BDEPEND="!=dev-libs/gobject-introspection-1.80.1-r1": no matches in repo history
- NonexistentBlocker: version 20251031: nonexistent blocker RDEPEND="!<=dev-libs/gobject-introspection-1.76.1-r0": no matches in repo history
- NonexistentBlocker: version 20251031: nonexistent blocker RDEPEND="!<dev-py/setuptools-rust-1.8.0": no matches in repo history
- NonexistentBlocker: version 20251031: nonexistent blocker RDEPEND="!=dev-libs/gobject-introspection-1.78.1-r0": no matches in repo history
- NonexistentBlocker: version 20251031: nonexistent blocker RDEPEND="!=dev-libs/gobject-introspection-1.80.1-r1": no matches in repo history
- NonexistentDeps: version 20251031: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12, dev-python/jaraco-test, dev-python/pip-run, dev-python/pytest-subprocess
- NonexistentDeps: version 20251031: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 20251031: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14, dev-python/jaraco-test[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], dev-python/pip-run[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], dev-python/pytest-subprocess[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)] ]
- NonsolvableDepsInStable: version 20251031: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 20251031: missing RDEPEND="${PYTHON_DEPS}"
- PythonMissingSCMDependency: version 20251031: defines SETUPTOOLS_SCM_PRETEND_VERSION but is missing BDEPEND on setuptools-scm or alike
- UnknownUseFlags: version 20251031: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/httplib2
- MissingRemoteId: missing <remote-id type="github">httplib2/httplib2</remote-id> (inferred from URI 'https://github.com/httplib2/httplib2/')
- MissingRemoteId: missing <remote-id type="pypi">httplib2</remote-id> (inferred from URI 'https://pypi.org/project/httplib2/')
- NonexistentDeps: version 0.31.0: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 0.31.0: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 0.31.0: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 0.31.0: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 0.31.0: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 0.31.0: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14', 'socks5'

## dev-python/itsdangerous
- MissingRemoteId: missing <remote-id type="github">pallets/itsdangerous</remote-id> (inferred from URI 'https://github.com/pallets/itsdangerous/')
- MissingRemoteId: missing <remote-id type="pypi">itsdangerous</remote-id> (inferred from URI 'https://pypi.org/project/itsdangerous/')
- EPyTestPluginsSuggestion: version 2.2.0: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- NonexistentDeps: version 2.2.0: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 2.2.0: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 2.2.0: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 2.2.0: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 2.2.0: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 2.2.0: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/jaraco-classes
- MissingRemoteId: missing <remote-id type="github">jaraco/jaraco.classes</remote-id> (inferred from URI 'https://github.com/jaraco/jaraco.classes/')
- MissingRemoteId: missing <remote-id type="pypi">jaraco.classes</remote-id> (inferred from URI 'https://pypi.org/project/jaraco.classes/')
- EPyTestPluginsSuggestion: version 3.4.0: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- NonexistentDeps: version 3.4.0: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 3.4.0: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 3.4.0: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 3.4.0: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 3.4.0: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 3.4.0: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/jaraco-collections
- MissingRemoteId: missing <remote-id type="github">jaraco/jaraco.collections</remote-id> (inferred from URI 'https://github.com/jaraco/jaraco.collections/')
- MissingRemoteId: missing <remote-id type="pypi">jaraco.collections</remote-id> (inferred from URI 'https://pypi.org/project/jaraco.collections/')
- EPyTestPluginsSuggestion: version 5.2.1: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- NonexistentDeps: version 5.2.1: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 5.2.1: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 5.2.1: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 5.2.1: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 5.2.1: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 5.2.1: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/hypercorn
- MissingRemoteId: missing <remote-id type="github">pgjones/hypercorn</remote-id> (inferred from URI 'https://github.com/pgjones/hypercorn/')
- MissingRemoteId: missing <remote-id type="pypi">Hypercorn</remote-id> (inferred from URI 'https://pypi.org/project/Hypercorn/')
- NonexistentDeps: version 0.18.0: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12, dev-python/priority
- NonexistentDeps: version 0.18.0: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12, dev-python/priority
- NonsolvableDepsInStable: version 0.18.0: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14, dev-python/priority[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)] ]
- NonsolvableDepsInStable: version 0.18.0: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14, dev-python/priority[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)] ]
- PythonMissingDeps: version 0.18.0: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 0.18.0: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/jaraco-path
- MissingRemoteId: missing <remote-id type="github">jaraco/jaraco.path</remote-id> (inferred from URI 'https://github.com/jaraco/jaraco.path/')
- MissingRemoteId: missing <remote-id type="pypi">jaraco.path</remote-id> (inferred from URI 'https://pypi.org/project/jaraco.path/')
- EPyTestPluginsSuggestion: version 3.7.2: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- NonexistentDeps: version 3.7.2: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 3.7.2: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 3.7.2: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 3.7.2: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 3.7.2: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 3.7.2: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/jaraco-context
- MissingRemoteId: missing <remote-id type="github">jaraco/jaraco.context</remote-id> (inferred from URI 'https://github.com/jaraco/jaraco.context/')
- MissingRemoteId: missing <remote-id type="pypi">jaraco.context</remote-id> (inferred from URI 'https://pypi.org/project/jaraco.context/')
- EPyTestPluginsSuggestion: version 6.0.1-r1: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- NonexistentDeps: version 6.0.1-r1: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 6.0.1-r1: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 6.0.1-r1: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 6.0.1-r1: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 6.0.1-r1: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 6.0.1-r1: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/isoduration
- MissingRemoteId: missing <remote-id type="github">bolsote/isoduration</remote-id> (inferred from URI 'https://github.com/bolsote/isoduration/')
- MissingRemoteId: missing <remote-id type="pypi">isoduration</remote-id> (inferred from URI 'https://pypi.org/project/isoduration/')
- EPyTestPluginsSuggestion: version 20.11.0-r1: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- NonexistentDeps: version 20.11.0-r1: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12, dev-python/isodate
- NonexistentDeps: version 20.11.0-r1: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 20.11.0-r1: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14, dev-python/isodate[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)] ]
- NonsolvableDepsInStable: version 20.11.0-r1: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 20.11.0-r1: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 20.11.0-r1: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/huggingface_hub
- MissingRemoteId: missing <remote-id type="github">huggingface/huggingface_hub</remote-id> (inferred from URI 'https://github.com/huggingface/huggingface_hub/archive/refs/tags/v0.36.0.tar.gz')
- MissingRemoteId: missing <remote-id type="pypi">huggingface_hub</remote-id> (inferred from URI 'https://pypi.org/project/huggingface_hub/')
- EPyTestPluginsSuggestion: version 0.36.0: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- NonexistentDeps: version 0.36.0: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12, dev-python/pytorch
- NonexistentDeps: version 0.36.0: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 0.36.0: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14, dev-python/pytorch[python_single_target_python3_11(-),python_single_target_python3_12(-),python_single_target_python3_13(-),python_single_target_python3_14(-)] ]
- NonsolvableDepsInStable: version 0.36.0: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 0.36.0: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 0.36.0: unknown USE flags: 'python_single_target_python3_11', 'python_single_target_python3_12', 'python_single_target_python3_13', 'python_single_target_python3_14'

## dev-python/jaraco-envs
- MissingRemoteId: missing <remote-id type="github">jaraco/jaraco.envs</remote-id> (inferred from URI 'https://github.com/jaraco/jaraco.envs/')
- MissingRemoteId: missing <remote-id type="pypi">jaraco.envs</remote-id> (inferred from URI 'https://pypi.org/project/jaraco.envs/')
- EPyTestPluginsSuggestion: version 2.6.0: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- NonexistentDeps: version 2.6.0: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 2.6.0: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 2.6.0: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 2.6.0: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 2.6.0: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 2.6.0: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/installer
- MissingRemoteId: missing <remote-id type="github">pypa/installer</remote-id> (inferred from URI 'https://github.com/pypa/installer/')
- MissingRemoteId: missing <remote-id type="pypi">installer</remote-id> (inferred from URI 'https://pypi.org/project/installer/')
- EPyTestPluginsSuggestion: version 0.7.0: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- MissingUnpackerDep: version 0.7.0: missing BDEPEND="app-arch/unzip" for SRC_URI archive: [ installer-0.7.0-py3-none-any.whl.zip ]
- NonexistentDeps: version 0.7.0: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 0.7.0: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 0.7.0: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 0.7.0: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 0.7.0: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 0.7.0: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/jaraco-functools
- MissingRemoteId: missing <remote-id type="github">jaraco/jaraco.functools</remote-id> (inferred from URI 'https://github.com/jaraco/jaraco.functools/')
- MissingRemoteId: missing <remote-id type="pypi">jaraco.functools</remote-id> (inferred from URI 'https://pypi.org/project/jaraco.functools/')
- NonexistentDeps: version 4.3.0: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 4.3.0: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 4.3.0: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 4.3.0: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 4.3.0: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 4.3.0: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/ini2toml
- MissingRemoteId: missing <remote-id type="github">abravalheri/ini2toml</remote-id> (inferred from URI 'https://github.com/abravalheri/ini2toml/')
- MissingRemoteId: missing <remote-id type="pypi">ini2toml</remote-id> (inferred from URI 'https://pypi.org/project/ini2toml/')
- EPyTestPluginsSuggestion: version 0.15: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- NonexistentDeps: version 0.15: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 0.15: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 0.15: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 0.15: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 0.15: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 0.15: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/jsonpointer
- MissingRemoteId: missing <remote-id type="github">stefankoegl/python-json-pointer</remote-id> (inferred from URI 'https://github.com/stefankoegl/python-json-pointer/')
- MissingRemoteId: missing <remote-id type="pypi">jsonpointer</remote-id> (inferred from URI 'https://pypi.org/project/jsonpointer/')
- NonexistentDeps: version 3.0.0: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 3.0.0: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 3.0.0: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 3.0.0: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 3.0.0: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 3.0.0: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/jaraco-text
- MissingRemoteId: missing <remote-id type="github">jaraco/jaraco.text</remote-id> (inferred from URI 'https://github.com/jaraco/jaraco.text/')
- MissingRemoteId: missing <remote-id type="pypi">jaraco.text</remote-id> (inferred from URI 'https://pypi.org/project/jaraco.text/')
- EPyTestPluginsSuggestion: version 4.0.0: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- NonexistentDeps: version 4.0.0: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 4.0.0: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 4.0.0: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 4.0.0: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 4.0.0: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 4.0.0: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/ensurepip-pip
- MissingRemoteId: missing <remote-id type="github">pypa/pip</remote-id> (inferred from URI 'https://github.com/pypa/pip/')
- MissingRemoteId: missing <remote-id type="pypi">pip</remote-id> (inferred from URI 'https://pypi.org/project/pip/')
- NonexistentDeps: version 25.3: BDEPEND: nonexistent packages: <dev-python/ensurepip-setuptools-80, app-lang/python:3.11, app-lang/python:3.12, dev-python/ensurepip-wheel
- NonexistentDeps: version 25.3: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 25.3: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11[ssl(+),threads(+)], app-lang/python:3.12[ssl(+),threads(+)], app-lang/python:3.14[ssl(+),threads(+)], <dev-python/ensurepip-setuptools-80, dev-python/ensurepip-wheel ]
- NonsolvableDepsInStable: version 25.3: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11[ssl(+),threads(+)], app-lang/python:3.12[ssl(+),threads(+)], app-lang/python:3.14[ssl(+),threads(+)] ]
- PythonMissingDeps: version 25.3: missing RDEPEND="${PYTHON_DEPS}"
- ReferenceInMetadataVar: version 25.3: LICENSE includes variable: VENDOR_LICENSES[*]
- UnknownUseFlags: version 25.3: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14', 'test-rust'
- VariableOrderWrong: version 25.3: variable LICENSE should occur before RESTRICT

## dev-python/jeepney
- MissingRemoteId: missing <remote-id type="gitlab">takluyver/jeepney</remote-id> (inferred from URI 'https://gitlab.com/takluyver/jeepney/')
- MissingRemoteId: missing <remote-id type="pypi">jeepney</remote-id> (inferred from URI 'https://pypi.org/project/jeepney/')
- EPyTestPluginsSuggestion: version 0.9.0: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- NonexistentDeps: version 0.9.0: BDEPEND: nonexistent packages: >=dev-python/pytest-asyncio-0.7.1, app-lang/python:3.11, app-lang/python:3.12, dev-python/sphinx-rtd-theme, sys-apps/dbus
- NonexistentDeps: version 0.9.0: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 0.9.0: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14, >=dev-python/pytest-asyncio-0.7.1[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], dev-python/sphinx-rtd-theme[python_targets_python3_11(-)], dev-python/sphinx-rtd-theme[python_targets_python3_12(-)], dev-python/sphinx-rtd-theme[python_targets_python3_13(-)], dev-python/sphinx-rtd-theme[python_targets_python3_14(-)], sys-apps/dbus ]
- NonsolvableDepsInStable: version 0.9.0: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 0.9.0: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 0.9.0: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/js2py
- MissingRemoteId: missing <remote-id type="github">PiotrDabkowski/Js2Py</remote-id> (inferred from URI 'https://github.com/PiotrDabkowski/Js2Py')
- MissingRemoteId: missing <remote-id type="pypi">Js2Py</remote-id> (inferred from URI 'https://pypi.org/project/Js2Py/')
- NonexistentDeps: version 0.74-r2: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 0.74-r2: RDEPEND: nonexistent packages: >=dev-python/pyjsparser-2.5.1, app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 0.74-r2: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 0.74-r2: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14, >=dev-python/pyjsparser-2.5.1[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)] ]
- PythonMissingDeps: version 0.74-r2: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 0.74-r2: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/hypothesis
- MissingRemoteId: missing <remote-id type="github">HypothesisWorks/hypothesis</remote-id> (inferred from URI 'https://github.com/HypothesisWorks/hypothesis/')
- MissingRemoteId: missing <remote-id type="pypi">hypothesis</remote-id> (inferred from URI 'https://pypi.org/project/hypothesis/')
- NonexistentDeps: version 6.148.1: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 6.148.1: PDEPEND: nonexistent package: dev-python/hypothesis-gentoo
- NonexistentDeps: version 6.148.1: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 6.148.1: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11[sqlite,threads(+)], app-lang/python:3.12[sqlite,threads(+)], app-lang/python:3.14[sqlite,threads(+)] ]
- NonsolvableDepsInStable: version 6.148.1: nonsolvable depset(pdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ dev-python/hypothesis-gentoo[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)] ]
- NonsolvableDepsInStable: version 6.148.1: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11[sqlite,threads(+)], app-lang/python:3.12[sqlite,threads(+)], app-lang/python:3.14[sqlite,threads(+)] ]
- PythonMissingDeps: version 6.148.1: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 6.148.1: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'
- WhitespaceFound: version 6.148.1: ebuild has leading whitespace on lines: 84, 85, 86, 87, 88, 89
- WhitespaceFound: version 6.148.1: ebuild has trailing whitespace on line: 10

## dev-python/joblib
- MissingRemoteId: missing <remote-id type="github">joblib/joblib</remote-id> (inferred from URI 'https://github.com/joblib/joblib/')
- MissingRemoteId: missing <remote-id type="pypi">joblib</remote-id> (inferred from URI 'https://pypi.org/project/joblib/')
- NonexistentDeps: version 1.5.2: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12, dev-python/loky, dev-python/threadpoolctl
- NonexistentDeps: version 1.5.2: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12, dev-python/loky
- NonsolvableDepsInStable: version 1.5.2: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14, dev-python/loky[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], dev-python/threadpoolctl[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)] ]
- NonsolvableDepsInStable: version 1.5.2: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14, dev-python/loky[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)] ]
- PythonMissingDeps: version 1.5.2: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 1.5.2: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/jsonschema-specifications
- MissingRemoteId: missing <remote-id type="github">python-jsonschema/jsonschema-specifications</remote-id> (inferred from URI 'https://github.com/python-jsonschema/jsonschema-specifications/')
- MissingRemoteId: missing <remote-id type="pypi">jsonschema-specifications</remote-id> (inferred from URI 'https://pypi.org/project/jsonschema-specifications/')
- NonexistentDeps: version 2025.9.1: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 2025.9.1: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 2025.9.1: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 2025.9.1: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 2025.9.1: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 2025.9.1: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/jedi
- MissingRemoteId: missing <remote-id type="github">davidhalter/jedi</remote-id> (inferred from URI 'https://github.com/davidhalter/jedi/')
- MissingRemoteId: missing <remote-id type="pypi">jedi</remote-id> (inferred from URI 'https://pypi.org/project/jedi/')
- EPyTestPluginsSuggestion: version 0.19.2: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- NonexistentDeps: version 0.19.2: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12, dev-python/sphinx-rtd-theme
- NonexistentDeps: version 0.19.2: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 0.19.2: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14, dev-python/sphinx-rtd-theme[python_targets_python3_11(-)], dev-python/sphinx-rtd-theme[python_targets_python3_12(-)], dev-python/sphinx-rtd-theme[python_targets_python3_13(-)], dev-python/sphinx-rtd-theme[python_targets_python3_14(-)] ]
- NonsolvableDepsInStable: version 0.19.2: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 0.19.2: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 0.19.2: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/lazy-object-proxy
- MissingRemoteId: missing <remote-id type="github">ionelmc/python-lazy-object-proxy</remote-id> (inferred from URI 'https://github.com/ionelmc/python-lazy-object-proxy/')
- MissingRemoteId: missing <remote-id type="pypi">lazy-object-proxy</remote-id> (inferred from URI 'https://pypi.org/project/lazy-object-proxy/')
- NonexistentDeps: version 1.12.0: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 1.12.0: DEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 1.12.0: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 1.12.0: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 1.12.0: nonsolvable depset(depend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 1.12.0: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 1.12.0: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 1.12.0: unknown USE flags: 'native-extensions', 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/httpcore
- MissingRemoteId: missing <remote-id type="github">encode/httpcore</remote-id> (inferred from URI 'https://github.com/encode/httpcore/')
- MissingRemoteId: missing <remote-id type="pypi">httpcore</remote-id> (inferred from URI 'https://pypi.org/project/httpcore/')
- EPyTestPluginsSuggestion: version 1.0.9-r1: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- NonexistentDeps: version 1.0.9-r1: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12, dev-python/pytest-asyncio, dev-python/pytest-httpbin, dev-python/pytest-trio, dev-python/socksio
- NonexistentDeps: version 1.0.9-r1: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 1.0.9-r1: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14, dev-python/pytest-asyncio[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], dev-python/pytest-httpbin[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], dev-python/pytest-trio[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-)], dev-python/socksio[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)] ]
- NonsolvableDepsInStable: version 1.0.9-r1: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 1.0.9-r1: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 1.0.9-r1: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'
- WhitespaceFound: version 1.0.9-r1: ebuild has leading whitespace on line: 67
- WhitespaceFound: version 1.0.9-r1: ebuild has trailing whitespace on line: 8

## dev-python/linkify-it-py
- MissingRemoteId: missing <remote-id type="github">tsutsu3/linkify-it-py</remote-id> (inferred from URI 'https://github.com/tsutsu3/linkify-it-py/')
- MissingRemoteId: missing <remote-id type="pypi">linkify-it-py</remote-id> (inferred from URI 'https://pypi.org/project/linkify-it-py/')
- EPyTestPluginsSuggestion: version 2.0.3: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- NonexistentDeps: version 2.0.3: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 2.0.3: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 2.0.3: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 2.0.3: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 2.0.3: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 2.0.3: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/markupsafe
- MissingRemoteId: missing <remote-id type="github">pallets/markupsafe</remote-id> (inferred from URI 'https://github.com/pallets/markupsafe/')
- MissingRemoteId: missing <remote-id type="pypi">MarkupSafe</remote-id> (inferred from URI 'https://pypi.org/project/MarkupSafe/')
- IndirectInherits: version 3.0.3: flag-o-matic: indirect inherit usage: 'filter-flags -Wl,-z,defs', line 28
- NonexistentDeps: version 3.0.3: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 3.0.3: DEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 3.0.3: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 3.0.3: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 3.0.3: nonsolvable depset(depend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 3.0.3: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 3.0.3: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 3.0.3: unknown USE flags: 'native-extensions', 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/mako
- MissingRemoteId: missing <remote-id type="github">sqlalchemy/mako</remote-id> (inferred from URI 'https://github.com/sqlalchemy/mako/')
- MissingRemoteId: missing <remote-id type="pypi">Mako</remote-id> (inferred from URI 'https://pypi.org/project/Mako/')
- EPyTestPluginsSuggestion: version 1.3.10: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- NonexistentDeps: version 1.3.10: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 1.3.10: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 1.3.10: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 1.3.10: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 1.3.10: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 1.3.10: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/kiwisolver
- MissingRemoteId: missing <remote-id type="github">nucleic/kiwi</remote-id> (inferred from URI 'https://github.com/nucleic/kiwi/')
- MissingRemoteId: missing <remote-id type="pypi">kiwisolver</remote-id> (inferred from URI 'https://pypi.org/project/kiwisolver/')
- IndirectInherits: version 1.4.9: flag-o-matic: indirect inherit usage: 'filter-flags -Wl,-z,defs', line 45
- NonexistentDeps: version 1.4.9: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 1.4.9: DEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 1.4.9: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 1.4.9: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 1.4.9: nonsolvable depset(depend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 1.4.9: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 1.4.9: missing RDEPEND="${PYTHON_DEPS}"
- PythonMissingSCMDependency: version 1.4.9: defines SETUPTOOLS_SCM_PRETEND_VERSION but is missing BDEPEND on setuptools-scm or alike
- UnknownUseFlags: version 1.4.9: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/mdurl
- MissingRemoteId: missing <remote-id type="github">executablebooks/mdurl</remote-id> (inferred from URI 'https://github.com/executablebooks/mdurl/')
- MissingRemoteId: missing <remote-id type="pypi">mdurl</remote-id> (inferred from URI 'https://pypi.org/project/mdurl/')
- EPyTestPluginsSuggestion: version 0.1.2: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- NonexistentDeps: version 0.1.2: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 0.1.2: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 0.1.2: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 0.1.2: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 0.1.2: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 0.1.2: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/lark
- MissingRemoteId: missing <remote-id type="github">lark-parser/lark</remote-id> (inferred from URI 'https://github.com/lark-parser/lark/')
- MissingRemoteId: missing <remote-id type="pypi">lark</remote-id> (inferred from URI 'https://pypi.org/project/lark/')
- NonexistentDeps: version 1.3.1: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 1.3.1: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 1.3.1: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 1.3.1: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 1.3.1: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 1.3.1: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/mock
- MissingRemoteId: missing <remote-id type="github">testing-cabal/mock</remote-id> (inferred from URI 'https://github.com/testing-cabal/mock/')
- MissingRemoteId: missing <remote-id type="pypi">mock</remote-id> (inferred from URI 'https://pypi.org/project/mock/')
- EPyTestPluginsSuggestion: version 5.2.0: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- NonexistentDeps: version 5.2.0: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 5.2.0: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 5.2.0: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 5.2.0: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 5.2.0: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 5.2.0: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/jsonschema-spec
- MissingRemoteId: missing <remote-id type="github">p1c2u/jsonschema-spec</remote-id> (inferred from URI 'https://github.com/p1c2u/jsonschema-spec/')
- MissingRemoteId: missing <remote-id type="pypi">jsonschema-spec</remote-id> (inferred from URI 'https://pypi.org/project/jsonschema-spec/')
- EPyTestPluginsSuggestion: version 0.2.4-r1: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- NonexistentDeps: version 0.2.4-r1: BDEPEND: nonexistent packages: >=dev-python/pathable-0.4.1, app-lang/python:3.11, app-lang/python:3.12, dev-python/responses
- NonexistentDeps: version 0.2.4-r1: RDEPEND: nonexistent packages: >=dev-python/pathable-0.4.1, app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 0.2.4-r1: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14, >=dev-python/pathable-0.4.1[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], dev-python/responses[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)] ]
- NonsolvableDepsInStable: version 0.2.4-r1: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14, >=dev-python/pathable-0.4.1[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)] ]
- PythonMissingDeps: version 0.2.4-r1: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 0.2.4-r1: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/more-itertools
- MissingRemoteId: missing <remote-id type="github">more-itertools/more-itertools</remote-id> (inferred from URI 'https://github.com/more-itertools/more-itertools/')
- MissingRemoteId: missing <remote-id type="pypi">more-itertools</remote-id> (inferred from URI 'https://pypi.org/project/more-itertools/')
- NonexistentDeps: version 10.8.0: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 10.8.0: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 10.8.0: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 10.8.0: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 10.8.0: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 10.8.0: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/markdown-it-py
- MissingRemoteId: missing <remote-id type="github">executablebooks/markdown-it-py</remote-id> (inferred from URI 'https://github.com/executablebooks/markdown-it-py/')
- MissingRemoteId: missing <remote-id type="pypi">markdown-it-py</remote-id> (inferred from URI 'https://pypi.org/project/markdown-it-py/')
- NonexistentDeps: version 4.0.0: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 4.0.0: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 4.0.0: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 4.0.0: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 4.0.0: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 4.0.0: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/httpx
- MissingRemoteId: missing <remote-id type="github">encode/httpx</remote-id> (inferred from URI 'https://github.com/encode/httpx/')
- MissingRemoteId: missing <remote-id type="pypi">httpx</remote-id> (inferred from URI 'https://pypi.org/project/httpx/')
- EPyTestPluginsSuggestion: version 0.28.1-r1: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- NonexistentDeps: version 0.28.1-r1: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12, dev-python/socksio
- NonexistentDeps: version 0.28.1-r1: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 0.28.1-r1: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14, dev-python/socksio[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)] ]
- NonsolvableDepsInStable: version 0.28.1-r1: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 0.28.1-r1: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 0.28.1-r1: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'
- WhitespaceFound: version 0.28.1-r1: ebuild has leading whitespace on lines: 97, 98, 99
- WhitespaceFound: version 0.28.1-r1: ebuild has trailing whitespace on line: 8

## dev-python/ipywidgets
- MissingRemoteId: missing <remote-id type="github">jupyter-widgets/ipywidgets</remote-id> (inferred from URI 'https://github.com/jupyter-widgets/ipywidgets/')
- MissingRemoteId: missing <remote-id type="pypi">ipywidgets</remote-id> (inferred from URI 'https://pypi.org/project/ipywidgets/')
- NonexistentDeps: version 8.1.8: BDEPEND: nonexistent packages: >=dev-python/ipython-genutils-0.2.0, >=dev-python/jupyterlab-widgets-3.0.15, >=dev-python/widgetsnbextension-4.0.14, app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 8.1.8: PDEPEND: nonexistent package: >=dev-python/ipython-6.1.0
- NonexistentDeps: version 8.1.8: RDEPEND: nonexistent packages: >=dev-python/ipython-genutils-0.2.0, >=dev-python/jupyterlab-widgets-3.0.15, >=dev-python/widgetsnbextension-4.0.14, app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 8.1.8: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11[threads(+)], app-lang/python:3.12[threads(+)], app-lang/python:3.14[threads(+)], >=dev-python/ipython-genutils-0.2.0[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], >=dev-python/jupyterlab-widgets-3.0.15[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], >=dev-python/widgetsnbextension-4.0.14[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)] ]
- NonsolvableDepsInStable: version 8.1.8: nonsolvable depset(pdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ >=dev-python/ipython-6.1.0[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)] ]
- NonsolvableDepsInStable: version 8.1.8: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11[threads(+)], app-lang/python:3.12[threads(+)], app-lang/python:3.14[threads(+)], >=dev-python/ipython-genutils-0.2.0[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], >=dev-python/jupyterlab-widgets-3.0.15[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], >=dev-python/widgetsnbextension-4.0.14[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)] ]
- PythonMissingDeps: version 8.1.8: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 8.1.8: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/keyring
- MissingRemoteId: missing <remote-id type="github">jaraco/keyring</remote-id> (inferred from URI 'https://github.com/jaraco/keyring/')
- MissingRemoteId: missing <remote-id type="pypi">keyring</remote-id> (inferred from URI 'https://pypi.org/project/keyring/')
- NonexistentDeps: version 25.7.0: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 25.7.0: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 25.7.0: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 25.7.0: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 25.7.0: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 25.7.0: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/makefun
- MissingRemoteId: missing <remote-id type="github">smarie/python-makefun</remote-id> (inferred from URI 'https://github.com/smarie/python-makefun/')
- MissingRemoteId: missing <remote-id type="pypi">makefun</remote-id> (inferred from URI 'https://pypi.org/project/makefun/')
- EPyTestPluginsSuggestion: version 1.16.0: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- NonexistentDeps: version 1.16.0: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12, dev-python/pytest-asyncio
- NonexistentDeps: version 1.16.0: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 1.16.0: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14, dev-python/pytest-asyncio[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)] ]
- NonsolvableDepsInStable: version 1.16.0: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 1.16.0: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 1.16.0: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/meson-python
- MissingRemoteId: missing <remote-id type="github">mesonbuild/meson-python</remote-id> (inferred from URI 'https://github.com/mesonbuild/meson-python/')
- MissingRemoteId: missing <remote-id type="pypi">meson-python</remote-id> (inferred from URI 'https://pypi.org/project/meson-python/')
- EPyTestPluginsSuggestion: version 0.18.0-r1: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- NonexistentDeps: version 0.18.0-r1: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12, dev-python/pytest-mock
- NonexistentDeps: version 0.18.0-r1: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 0.18.0-r1: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14, dev-python/pytest-mock[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)] ]
- NonsolvableDepsInStable: version 0.18.0-r1: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 0.18.0-r1: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 0.18.0-r1: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/josepy
- MissingRemoteId: missing <remote-id type="github">certbot/josepy</remote-id> (inferred from URI 'https://github.com/certbot/josepy/')
- MissingRemoteId: missing <remote-id type="pypi">josepy</remote-id> (inferred from URI 'https://pypi.org/project/josepy/')
- NonexistentDeps: version 2.2.0: BDEPEND: nonexistent packages: >=dev-python/sphinx-rtd-theme-1.0, app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 2.2.0: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 2.2.0: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14, >=dev-python/sphinx-rtd-theme-1.0[python_targets_python3_11(-)], >=dev-python/sphinx-rtd-theme-1.0[python_targets_python3_12(-)], >=dev-python/sphinx-rtd-theme-1.0[python_targets_python3_13(-)], >=dev-python/sphinx-rtd-theme-1.0[python_targets_python3_14(-)] ]
- NonsolvableDepsInStable: version 2.2.0: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 2.2.0: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 2.2.0: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/ordered-set
- MissingRemoteId: missing <remote-id type="github">rspeer/ordered-set</remote-id> (inferred from URI 'https://github.com/rspeer/ordered-set/')
- MissingRemoteId: missing <remote-id type="pypi">ordered-set</remote-id> (inferred from URI 'https://pypi.org/project/ordered-set/')
- EPyTestPluginsSuggestion: version 4.1.0-r1: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- NonexistentDeps: version 4.1.0-r1: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 4.1.0-r1: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 4.1.0-r1: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 4.1.0-r1: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 4.1.0-r1: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 4.1.0-r1: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/hatchling
- MissingRemoteId: missing <remote-id type="github">pypa/hatch</remote-id> (inferred from URI 'https://github.com/pypa/hatch/')
- MissingRemoteId: missing <remote-id type="pypi">hatchling</remote-id> (inferred from URI 'https://pypi.org/project/hatchling/')
- NonexistentDeps: version 1.27.0: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12, dev-python/pytest-mock
- NonexistentDeps: version 1.27.0: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 1.27.0: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14, dev-python/pytest-mock[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)] ]
- NonsolvableDepsInStable: version 1.27.0: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 1.27.0: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 1.27.0: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/multidict
- MissingRemoteId: missing <remote-id type="github">aio-libs/multidict</remote-id> (inferred from URI 'https://github.com/aio-libs/multidict/')
- MissingRemoteId: missing <remote-id type="pypi">multidict</remote-id> (inferred from URI 'https://pypi.org/project/multidict/')
- IndirectInherits: version 6.7.0: flag-o-matic: indirect inherit usage: 'filter-flags -Wl,-z,defs', line 36
- NonexistentDeps: version 6.7.0: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12, dev-python/objgraph
- NonexistentDeps: version 6.7.0: DEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 6.7.0: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 6.7.0: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14, dev-python/objgraph[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)] ]
- NonsolvableDepsInStable: version 6.7.0: nonsolvable depset(depend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 6.7.0: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 6.7.0: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 6.7.0: unknown USE flags: 'native-extensions', 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/jsonschema-path
- MissingRemoteId: missing <remote-id type="github">p1c2u/jsonschema-path</remote-id> (inferred from URI 'https://github.com/p1c2u/jsonschema-path/')
- MissingRemoteId: missing <remote-id type="pypi">jsonschema-path</remote-id> (inferred from URI 'https://pypi.org/project/jsonschema-path/')
- EPyTestPluginsSuggestion: version 0.4.0_beta1: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- NonexistentDeps: version 0.4.0_beta1: BDEPEND: nonexistent packages: >=dev-python/pathable-0.5.0_beta1, >=dev-python/pyrsistent-0.20.0, app-lang/python:3.11, app-lang/python:3.12, dev-python/responses
- NonexistentDeps: version 0.4.0_beta1: RDEPEND: nonexistent packages: >=dev-python/pathable-0.5.0_beta1, >=dev-python/pyrsistent-0.20.0, app-lang/python:3.11, app-lang/python:3.12
- PythonMissingDeps: version 0.4.0_beta1: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 0.4.0_beta1: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/olefile
- MissingRemoteId: missing <remote-id type="github">decalage2/olefile</remote-id> (inferred from URI 'https://github.com/decalage2/olefile/')
- MissingRemoteId: missing <remote-id type="pypi">olefile</remote-id> (inferred from URI 'https://pypi.org/project/olefile/')
- NonexistentDeps: version 0.47: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12, dev-python/sphinx-rtd-theme
- NonexistentDeps: version 0.47: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 0.47: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14, dev-python/sphinx-rtd-theme[python_targets_python3_11(-)], dev-python/sphinx-rtd-theme[python_targets_python3_12(-)], dev-python/sphinx-rtd-theme[python_targets_python3_13(-)], dev-python/sphinx-rtd-theme[python_targets_python3_14(-)] ]
- NonsolvableDepsInStable: version 0.47: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 0.47: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 0.47: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/msgpack
- MissingRemoteId: missing <remote-id type="github">msgpack/msgpack-python</remote-id> (inferred from URI 'https://github.com/msgpack/msgpack-python/')
- MissingRemoteId: missing <remote-id type="pypi">msgpack</remote-id> (inferred from URI 'https://pypi.org/project/msgpack/')
- IndirectInherits: version 1.1.2: flag-o-matic: indirect inherit usage: 'filter-flags -Wl,-z,defs', line 36
- NonexistentDeps: version 1.1.2: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 1.1.2: DEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 1.1.2: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 1.1.2: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 1.1.2: nonsolvable depset(depend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 1.1.2: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 1.1.2: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 1.1.2: unknown USE flags: 'native-extensions', 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/pathspec
- MissingRemoteId: missing <remote-id type="github">cpburnz/python-pathspec</remote-id> (inferred from URI 'https://github.com/cpburnz/python-pathspec/')
- MissingRemoteId: missing <remote-id type="pypi">pathspec</remote-id> (inferred from URI 'https://pypi.org/project/pathspec/')
- NonexistentDeps: version 0.12.1: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 0.12.1: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 0.12.1: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 0.12.1: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 0.12.1: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 0.12.1: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/packaging
- MissingRemoteId: missing <remote-id type="github">pypa/packaging</remote-id> (inferred from URI 'https://github.com/pypa/packaging/')
- MissingRemoteId: missing <remote-id type="pypi">packaging</remote-id> (inferred from URI 'https://pypi.org/project/packaging/')
- EPyTestPluginsSuggestion: version 25.0: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- NonexistentBlocker: version 25.0: nonexistent blocker BDEPEND="!<dev-py/setuptools-67": no matches in repo history
- NonexistentBlocker: version 25.0: nonexistent blocker RDEPEND="!<dev-py/setuptools-67": no matches in repo history
- NonexistentDeps: version 25.0: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 25.0: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 25.0: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 25.0: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 25.0: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 25.0: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/mypy-extensions
- MissingRemoteId: missing <remote-id type="github">python/mypy_extensions</remote-id> (inferred from URI 'https://github.com/python/mypy_extensions/')
- NonexistentDeps: version 1.1.0: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 1.1.0: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 1.1.0: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 1.1.0: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 1.1.0: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 1.1.0: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/markdown
- MissingRemoteId: missing <remote-id type="github">Python-Markdown/markdown</remote-id> (inferred from URI 'https://github.com/Python-Markdown/markdown/')
- MissingRemoteId: missing <remote-id type="pypi">Markdown</remote-id> (inferred from URI 'https://pypi.org/project/Markdown/')
- NonexistentDeps: version 3.10: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12, dev-python/pytidylib
- NonexistentDeps: version 3.10: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 3.10: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14, dev-python/pytidylib[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)] ]
- NonsolvableDepsInStable: version 3.10: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 3.10: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 3.10: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/flit
- MissingRemoteId: missing <remote-id type="github">pypa/flit</remote-id> (inferred from URI 'https://github.com/pypa/flit/')
- MissingRemoteId: missing <remote-id type="pypi">flit</remote-id> (inferred from URI 'https://pypi.org/project/flit/')
- EPyTestPluginsSuggestion: version 3.12.0: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- NonexistentDeps: version 3.12.0: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12, dev-python/pygments-github-lexers, dev-python/responses, dev-python/sphinx-rtd-theme, dev-python/sphinxcontrib-github-alt, sys-apps/grep
- NonexistentDeps: version 3.12.0: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 3.12.0: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14, dev-python/pygments-github-lexers[python_targets_python3_11(-)], dev-python/pygments-github-lexers[python_targets_python3_12(-)], dev-python/pygments-github-lexers[python_targets_python3_13(-)], dev-python/pygments-github-lexers[python_targets_python3_14(-)], dev-python/responses[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], dev-python/sphinx-rtd-theme[python_targets_python3_11(-)], dev-python/sphinx-rtd-theme[python_targets_python3_12(-)], dev-python/sphinx-rtd-theme[python_targets_python3_13(-)], dev-python/sphinx-rtd-theme[python_targets_python3_14(-)], dev-python/sphinxcontrib-github-alt[python_targets_python3_11(-)], dev-python/sphinxcontrib-github-alt[python_targets_python3_12(-)], dev-python/sphinxcontrib-github-alt[python_targets_python3_13(-)], dev-python/sphinxcontrib-github-alt[python_targets_python3_14(-)], sys-apps/grep ]
- NonsolvableDepsInStable: version 3.12.0: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 3.12.0: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 3.12.0: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/parsedatetime
- MissingRemoteId: missing <remote-id type="github">bear/parsedatetime</remote-id> (inferred from URI 'https://github.com/bear/parsedatetime')
- EPyTestPluginsSuggestion: version 2.6-r1: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- NonexistentDeps: version 2.6-r1: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 2.6-r1: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 2.6-r1: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 2.6-r1: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 2.6-r1: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 2.6-r1: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/parso
- MissingRemoteId: missing <remote-id type="github">davidhalter/parso</remote-id> (inferred from URI 'https://github.com/davidhalter/parso/')
- MissingRemoteId: missing <remote-id type="pypi">parso</remote-id> (inferred from URI 'https://pypi.org/project/parso/')
- NonexistentDeps: version 0.8.5: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 0.8.5: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 0.8.5: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 0.8.5: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 0.8.5: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 0.8.5: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/ipykernel
- MissingRemoteId: missing <remote-id type="github">ipython/ipykernel</remote-id> (inferred from URI 'https://github.com/ipython/ipykernel/')
- MissingRemoteId: missing <remote-id type="pypi">ipykernel</remote-id> (inferred from URI 'https://pypi.org/project/ipykernel/')
- NonexistentDeps: version 7.1.0: BDEPEND: nonexistent packages: >=dev-py/matplotlib-inline-0.1, >=dev-python/ipython-7.23.1, >=dev-python/jupyter-client-8.0.0, >=dev-python/jupyter-core-4.12, >=dev-python/nest-asyncio-1.4, app-lang/python:3.11, app-lang/python:3.12, dev-python/ipyparallel
- NonexistentDeps: version 7.1.0: RDEPEND: nonexistent packages: >=dev-py/matplotlib-inline-0.1, >=dev-python/ipython-7.23.1, >=dev-python/jupyter-client-8.0.0, >=dev-python/jupyter-core-4.12, >=dev-python/nest-asyncio-1.4, app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 7.1.0: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11[threads(+)], app-lang/python:3.12[threads(+)], app-lang/python:3.14[threads(+)], >=dev-py/matplotlib-inline-0.1[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], dev-python/ipyparallel[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], >=dev-python/ipython-7.23.1[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], >=dev-python/jupyter-client-8.0.0[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], >=dev-python/jupyter-core-4.12[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], >=dev-python/nest-asyncio-1.4[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)] ]
- NonsolvableDepsInStable: version 7.1.0: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11[threads(+)], app-lang/python:3.12[threads(+)], app-lang/python:3.14[threads(+)], >=dev-py/matplotlib-inline-0.1[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], >=dev-python/ipython-7.23.1[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], >=dev-python/jupyter-client-8.0.0[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], >=dev-python/jupyter-core-4.12[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], >=dev-python/nest-asyncio-1.4[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)] ]
- PythonMissingDeps: version 7.1.0: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 7.1.0: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'
- WhitespaceFound: version 7.1.0: ebuild has trailing whitespace on line: 9

## dev-python/orjson
- MissingRemoteId: missing <remote-id type="github">ijl/orjson</remote-id> (inferred from URI 'https://github.com/ijl/orjson/')
- MissingRemoteId: missing <remote-id type="pypi">orjson</remote-id> (inferred from URI 'https://pypi.org/project/orjson/')
- NonexistentDeps: version 3.11.4-r1: BDEPEND: nonexistent packages: >=dev-util/maturin-1.7.8, app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 3.11.4-r1: DEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 3.11.4-r1: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 3.11.4-r1: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14, dev-py/numpy[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], >=dev-util/maturin-1.7.8[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)] ]
- NonsolvableDepsInStable: version 3.11.4-r1: nonsolvable depset(depend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 3.11.4-r1: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 3.11.4-r1: missing RDEPEND="${PYTHON_DEPS}"
- UnknownLicense: version 3.11.4-r1: unknown licenses: Apache-2.0-with-LLVM-exceptions, Unicode-3.0
- UnknownUseFlags: version 3.11.4-r1: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/paramiko
- MissingRemoteId: missing <remote-id type="github">paramiko/paramiko</remote-id> (inferred from URI 'https://github.com/paramiko/paramiko/')
- MissingRemoteId: missing <remote-id type="pypi">paramiko</remote-id> (inferred from URI 'https://pypi.org/project/paramiko/')
- NonexistentDeps: version 4.0.0-r1: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 4.0.0-r1: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 4.0.0-r1: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11[threads(+)], app-lang/python:3.12[threads(+)], app-lang/python:3.14[threads(+)] ]
- NonsolvableDepsInStable: version 4.0.0-r1: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11[threads(+)], app-lang/python:3.12[threads(+)], app-lang/python:3.14[threads(+)] ]
- PythonMissingDeps: version 4.0.0-r1: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 4.0.0-r1: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/pluggy
- MissingRemoteId: missing <remote-id type="github">pytest-dev/pluggy</remote-id> (inferred from URI 'https://github.com/pytest-dev/pluggy/')
- MissingRemoteId: missing <remote-id type="pypi">pluggy</remote-id> (inferred from URI 'https://pypi.org/project/pluggy/')
- EPyTestPluginsSuggestion: version 1.6.0: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- NonexistentDeps: version 1.6.0: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 1.6.0: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 1.6.0: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 1.6.0: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 1.6.0: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 1.6.0: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/platformdirs
- MissingRemoteId: missing <remote-id type="github">tox-dev/platformdirs</remote-id> (inferred from URI 'https://github.com/tox-dev/platformdirs/')
- MissingRemoteId: missing <remote-id type="pypi">platformdirs</remote-id> (inferred from URI 'https://pypi.org/project/platformdirs/')
- NonexistentDeps: version 4.5.0: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 4.5.0: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 4.5.0: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 4.5.0: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 4.5.0: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 4.5.0: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/ptyprocess
- MissingRemoteId: missing <remote-id type="github">pexpect/ptyprocess</remote-id> (inferred from URI 'https://github.com/pexpect/ptyprocess/')
- MissingRemoteId: missing <remote-id type="pypi">ptyprocess</remote-id> (inferred from URI 'https://pypi.org/project/ptyprocess/')
- NonexistentDeps: version 0.7.0-r1: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 0.7.0-r1: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 0.7.0-r1: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 0.7.0-r1: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 0.7.0-r1: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 0.7.0-r1: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/pyasn1
- MissingRemoteId: missing <remote-id type="github">pyasn1/pyasn1</remote-id> (inferred from URI 'https://github.com/pyasn1/pyasn1/')
- MissingRemoteId: missing <remote-id type="pypi">pyasn1</remote-id> (inferred from URI 'https://pypi.org/project/pyasn1/')
- NonexistentDeps: version 0.6.1: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 0.6.1: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 0.6.1: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 0.6.1: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 0.6.1: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 0.6.1: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/ply
- MissingRemoteId: missing <remote-id type="github">dabeaz/ply</remote-id> (inferred from URI 'https://github.com/dabeaz/ply/')
- MissingRemoteId: missing <remote-id type="pypi">ply</remote-id> (inferred from URI 'https://pypi.org/project/ply/')
- NonexistentDeps: version 3.11-r2: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 3.11-r2: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 3.11-r2: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 3.11-r2: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 3.11-r2: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 3.11-r2: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/mpmath
- MissingRemoteId: missing <remote-id type="github">mpmath/mpmath</remote-id> (inferred from URI 'https://github.com/mpmath/mpmath/')
- MissingRemoteId: missing <remote-id type="pypi">mpmath</remote-id> (inferred from URI 'https://pypi.org/project/mpmath/')
- NonexistentDeps: version 1.4.0_beta2: BDEPEND: nonexistent packages: >=dev-python/gmpy2-2.3.0_alpha1, app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 1.4.0_beta2: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- PythonMissingDeps: version 1.4.0_beta2: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 1.4.0_beta2: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14', 'test-full'
- WhitespaceFound: version 1.4.0_beta2: ebuild has leading whitespace on lines: 54, 55

## dev-python/portend
- MissingRemoteId: missing <remote-id type="github">jaraco/portend</remote-id> (inferred from URI 'https://github.com/jaraco/portend/')
- MissingRemoteId: missing <remote-id type="pypi">portend</remote-id> (inferred from URI 'https://pypi.org/project/portend/')
- EPyTestPluginsSuggestion: version 3.2.1: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- NonexistentDeps: version 3.2.1: BDEPEND: nonexistent packages: >=dev-python/tempora-1.8, app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 3.2.1: RDEPEND: nonexistent packages: >=dev-python/tempora-1.8, app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 3.2.1: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14, >=dev-python/tempora-1.8[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)] ]
- NonsolvableDepsInStable: version 3.2.1: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14, >=dev-python/tempora-1.8[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)] ]
- PythonMissingDeps: version 3.2.1: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 3.2.1: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/psutil
- MissingRemoteId: missing <remote-id type="github">giampaolo/psutil</remote-id> (inferred from URI 'https://github.com/giampaolo/psutil/')
- MissingRemoteId: missing <remote-id type="pypi">psutil</remote-id> (inferred from URI 'https://pypi.org/project/psutil/')
- IndirectInherits: version 7.1.3: flag-o-matic: indirect inherit usage: 'filter-flags -Wl,-z,defs', line 88
- NonexistentDeps: version 7.1.3: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 7.1.3: DEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 7.1.3: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 7.1.3: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 7.1.3: nonsolvable depset(depend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 7.1.3: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 7.1.3: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 7.1.3: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/path
- MissingRemoteId: missing <remote-id type="github">jaraco/path</remote-id> (inferred from URI 'https://github.com/jaraco/path/')
- MissingRemoteId: missing <remote-id type="pypi">path</remote-id> (inferred from URI 'https://pypi.org/project/path/')
- NonexistentDeps: version 17.1.1: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 17.1.1: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 17.1.1: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 17.1.1: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 17.1.1: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 17.1.1: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/plumbum
- MissingRemoteId: missing <remote-id type="github">tomerfiliba/plumbum</remote-id> (inferred from URI 'https://github.com/tomerfiliba/plumbum/')
- MissingRemoteId: missing <remote-id type="pypi">plumbum</remote-id> (inferred from URI 'https://pypi.org/project/plumbum/')
- NonexistentDeps: version 1.10.0: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 1.10.0: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 1.10.0: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 1.10.0: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 1.10.0: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 1.10.0: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'
- WhitespaceFound: version 1.10.0: ebuild has leading whitespace on lines: 51, 52, 53, 54

## dev-python/outcome
- MissingRemoteId: missing <remote-id type="github">python-trio/outcome</remote-id> (inferred from URI 'https://github.com/python-trio/outcome/')
- MissingRemoteId: missing <remote-id type="pypi">outcome</remote-id> (inferred from URI 'https://pypi.org/project/outcome/')
- EPyTestPluginsSuggestion: version 1.3.0_p0: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- NonexistentDeps: version 1.3.0_p0: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12, dev-python/pytest-asyncio, dev-python/sphinx-rtd-theme, dev-python/sphinxcontrib-trio
- NonexistentDeps: version 1.3.0_p0: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 1.3.0_p0: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14, dev-python/pytest-asyncio[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], dev-python/sphinx-rtd-theme[python_targets_python3_11(-)], dev-python/sphinx-rtd-theme[python_targets_python3_12(-)], dev-python/sphinx-rtd-theme[python_targets_python3_13(-)], dev-python/sphinx-rtd-theme[python_targets_python3_14(-)], dev-python/sphinxcontrib-trio[python_targets_python3_11(-)], dev-python/sphinxcontrib-trio[python_targets_python3_12(-)], dev-python/sphinxcontrib-trio[python_targets_python3_13(-)], dev-python/sphinxcontrib-trio[python_targets_python3_14(-)] ]
- NonsolvableDepsInStable: version 1.3.0_p0: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 1.3.0_p0: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 1.3.0_p0: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/pyelftools
- MissingRemoteId: missing <remote-id type="github">eliben/pyelftools</remote-id> (inferred from URI 'https://github.com/eliben/pyelftools/')
- MissingRemoteId: missing <remote-id type="pypi">pyelftools</remote-id> (inferred from URI 'https://pypi.org/project/pyelftools/')
- NonexistentDeps: version 0.32: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 0.32: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 0.32: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 0.32: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 0.32: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 0.32: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/openpyxl
- MissingRemoteId: missing <remote-id type="heptapod">openpyxl/openpyxl</remote-id> (inferred from URI 'https://foss.heptapod.net/openpyxl/openpyxl/')
- EPyTestPluginsSuggestion: version 3.1.5: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- NonexistentDeps: version 3.1.5: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12, dev-python/et-xmlfile, dev-python/sphinx-rtd-theme
- NonexistentDeps: version 3.1.5: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12, dev-python/et-xmlfile
- NonsolvableDepsInStable: version 3.1.5: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14, dev-python/et-xmlfile[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], dev-python/sphinx-rtd-theme[python_targets_python3_11(-)], dev-python/sphinx-rtd-theme[python_targets_python3_12(-)], dev-python/sphinx-rtd-theme[python_targets_python3_13(-)], dev-python/sphinx-rtd-theme[python_targets_python3_14(-)] ]
- NonsolvableDepsInStable: version 3.1.5: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14, dev-python/et-xmlfile[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)] ]
- PythonMissingDeps: version 3.1.5: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 3.1.5: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/networkx
- MissingRemoteId: missing <remote-id type="github">networkx/networkx</remote-id> (inferred from URI 'https://github.com/networkx/networkx/')
- MissingRemoteId: missing <remote-id type="pypi">networkx</remote-id> (inferred from URI 'https://pypi.org/project/networkx/')
- EPyTestPluginsSuggestion: version 3.5-r1: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- NonexistentDeps: version 3.5-r1: BDEPEND: nonexistent packages: >=dev-python/scipy-1.11.2, app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 3.5-r1: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 3.5-r1: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14, >=dev-py/matplotlib-3.8[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-)], >=dev-py/numpy-1.25[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-)], >=dev-python/scipy-1.11.2[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-)] ]
- NonsolvableDepsInStable: version 3.5-r1: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 3.5-r1: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 3.5-r1: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'
- WhitespaceFound: version 3.5-r1: ebuild has leading whitespace on lines: 58, 59, 60, 61, 62
- WhitespaceFound: version 3.5-r1: ebuild has trailing whitespace on line: 9

## dev-python/propcache
- MissingRemoteId: missing <remote-id type="github">aio-libs/propcache</remote-id> (inferred from URI 'https://github.com/aio-libs/propcache/')
- MissingRemoteId: missing <remote-id type="pypi">propcache</remote-id> (inferred from URI 'https://pypi.org/project/propcache/')
- IndirectInherits: version 0.4.1: flag-o-matic: indirect inherit usage: 'filter-flags -Wl,-z,defs', line 34
- NonexistentDeps: version 0.4.1: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 0.4.1: DEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 0.4.1: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 0.4.1: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 0.4.1: nonsolvable depset(depend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 0.4.1: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 0.4.1: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 0.4.1: unknown USE flags: 'native-extensions', 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/pexpect
- MissingRemoteId: missing <remote-id type="github">pexpect/pexpect</remote-id> (inferred from URI 'https://github.com/pexpect/pexpect/')
- MissingRemoteId: missing <remote-id type="pypi">pexpect</remote-id> (inferred from URI 'https://pypi.org/project/pexpect/')
- EPyTestPluginsSuggestion: version 4.9.0: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- NonexistentDeps: version 4.9.0: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12, dev-python/sphinxcontrib-github-alt
- NonexistentDeps: version 4.9.0: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 4.9.0: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11[threads(+)], app-lang/python:3.12[threads(+)], app-lang/python:3.14[threads(+)], dev-python/sphinxcontrib-github-alt[python_targets_python3_11(-)], dev-python/sphinxcontrib-github-alt[python_targets_python3_12(-)], dev-python/sphinxcontrib-github-alt[python_targets_python3_13(-)], dev-python/sphinxcontrib-github-alt[python_targets_python3_14(-)] ]
- NonsolvableDepsInStable: version 4.9.0: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11[threads(+)], app-lang/python:3.12[threads(+)], app-lang/python:3.14[threads(+)] ]
- PythonMissingDeps: version 4.9.0: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 4.9.0: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/jsonschema
- MissingRemoteId: missing <remote-id type="github">python-jsonschema/jsonschema</remote-id> (inferred from URI 'https://github.com/python-jsonschema/jsonschema/')
- MissingRemoteId: missing <remote-id type="pypi">jsonschema</remote-id> (inferred from URI 'https://pypi.org/project/jsonschema/')
- NonexistentBlocker: version 4.25.1: nonexistent blocker BDEPEND="!!dev-python/shiboken6": no matches in repo history
- NonexistentDeps: version 4.25.1: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12, dev-python/jsonpath-ng
- NonexistentDeps: version 4.25.1: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 4.25.1: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14, dev-python/jsonpath-ng[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)] ]
- NonsolvableDepsInStable: version 4.25.1: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 4.25.1: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 4.25.1: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/py
- MissingRemoteId: missing <remote-id type="github">pytest-dev/py</remote-id> (inferred from URI 'https://github.com/pytest-dev/py/')
- MissingRemoteId: missing <remote-id type="pypi">py</remote-id> (inferred from URI 'https://pypi.org/project/py/')
- EPyTestPluginsSuggestion: version 1.11.0-r1: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- NonexistentDeps: version 1.11.0-r1: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 1.11.0-r1: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 1.11.0-r1: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 1.11.0-r1: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 1.11.0-r1: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 1.11.0-r1: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/pycparser
- MissingRemoteId: missing <remote-id type="github">eliben/pycparser</remote-id> (inferred from URI 'https://github.com/eliben/pycparser/')
- MissingRemoteId: missing <remote-id type="pypi">pycparser</remote-id> (inferred from URI 'https://pypi.org/project/pycparser/')
- NonexistentDeps: version 2.23: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 2.23: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 2.23: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 2.23: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 2.23: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 2.23: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/pretend
- MissingRemoteId: missing <remote-id type="github">alex/pretend</remote-id> (inferred from URI 'https://github.com/alex/pretend/')
- MissingRemoteId: missing <remote-id type="pypi">pretend</remote-id> (inferred from URI 'https://pypi.org/project/pretend/')
- EPyTestPluginsSuggestion: version 1.0.9-r2: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- NonexistentDeps: version 1.0.9-r2: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 1.0.9-r2: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 1.0.9-r2: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 1.0.9-r2: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 1.0.9-r2: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 1.0.9-r2: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/pyfakefs
- MissingRemoteId: missing <remote-id type="github">pytest-dev/pyfakefs</remote-id> (inferred from URI 'https://github.com/pytest-dev/pyfakefs/')
- MissingRemoteId: missing <remote-id type="pypi">pyfakefs</remote-id> (inferred from URI 'https://pypi.org/project/pyfakefs/')
- NonexistentDeps: version 5.10.2: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 5.10.2: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 5.10.2: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 5.10.2: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 5.10.2: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 5.10.2: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/pyparsing
- MissingRemoteId: missing <remote-id type="github">pyparsing/pyparsing</remote-id> (inferred from URI 'https://github.com/pyparsing/pyparsing/')
- MissingRemoteId: missing <remote-id type="pypi">pyparsing</remote-id> (inferred from URI 'https://pypi.org/project/pyparsing/')
- NonexistentDeps: version 3.2.5: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 3.2.5: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 3.2.5: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 3.2.5: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 3.2.5: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 3.2.5: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/pdm-backend
- MissingRemoteId: missing <remote-id type="github">pdm-project/pdm-backend</remote-id> (inferred from URI 'https://github.com/pdm-project/pdm-backend/')
- MissingRemoteId: missing <remote-id type="pypi">pdm-backend</remote-id> (inferred from URI 'https://pypi.org/project/pdm-backend/')
- NonexistentDeps: version 2.4.6: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 2.4.6: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 2.4.6: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 2.4.6: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 2.4.6: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 2.4.6: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/pyserial
- MissingRemoteId: missing <remote-id type="github">pyserial/pyserial</remote-id> (inferred from URI 'https://github.com/pyserial/pyserial/')
- MissingRemoteId: missing <remote-id type="pypi">pyserial</remote-id> (inferred from URI 'https://pypi.org/project/pyserial/')
- NonexistentDeps: version 3.5-r2: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 3.5-r2: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 3.5-r2: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 3.5-r2: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 3.5-r2: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 3.5-r2: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/pyperclip
- MissingRemoteId: missing <remote-id type="github">asweigart/pyperclip</remote-id> (inferred from URI 'https://github.com/asweigart/pyperclip/')
- MissingRemoteId: missing <remote-id type="pypi">pyperclip</remote-id> (inferred from URI 'https://pypi.org/project/pyperclip/')
- NonexistentDeps: version 1.11.0: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12, dev-python/pyqt5, dev-python/qtpy, kde-plasma/plasma-workspace, x11-misc/xclip, x11-misc/xsel
- NonexistentDeps: version 1.11.0: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12, dev-python/pyqt5, dev-python/qtpy, kde-plasma/plasma-workspace, x11-misc/xclip, x11-misc/xsel
- NonsolvableDepsInStable: version 1.11.0: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14, dev-python/pyqt5[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], dev-python/qtpy[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], kde-plasma/plasma-workspace, x11-misc/xclip, x11-misc/xsel ]
- NonsolvableDepsInStable: version 1.11.0: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14, dev-python/pyqt5[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], dev-python/qtpy[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], kde-plasma/plasma-workspace, x11-misc/xclip, x11-misc/xsel ]
- PythonMissingDeps: version 1.11.0: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 1.11.0: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'
- UnstatedIuse: version 1.11.0: attr(bdepend): profile 'core/amd64/glibc' (8 total): unstated flag: [ test ]

## dev-python/pyrfc3339
- MissingRemoteId: missing <remote-id type="github">kurtraschke/pyRFC3339</remote-id> (inferred from URI 'https://github.com/kurtraschke/pyRFC3339/')
- MissingRemoteId: missing <remote-id type="pypi">pyRFC3339</remote-id> (inferred from URI 'https://pypi.org/project/pyRFC3339/')
- NonexistentDeps: version 2.1.0: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 2.1.0: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 2.1.0: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 2.1.0: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 2.1.0: missing RDEPEND="${PYTHON_DEPS}"
- PythonMissingSCMDependency: version 2.1.0: defines SETUPTOOLS_SCM_PRETEND_VERSION but is missing BDEPEND on setuptools-scm or alike
- UnknownUseFlags: version 2.1.0: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/pytokens
- MissingRemoteId: missing <remote-id type="github">tusharsadhwani/pytokens</remote-id> (inferred from URI 'https://github.com/tusharsadhwani/pytokens/')
- MissingRemoteId: missing <remote-id type="pypi">pytokens</remote-id> (inferred from URI 'https://pypi.org/project/pytokens/')
- NonexistentDeps: version 0.3.0: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 0.3.0: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 0.3.0: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 0.3.0: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 0.3.0: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 0.3.0: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/pyproject-hooks
- MissingRemoteId: missing <remote-id type="github">pypa/pyproject-hooks</remote-id> (inferred from URI 'https://github.com/pypa/pyproject-hooks/')
- MissingRemoteId: missing <remote-id type="pypi">pyproject-hooks</remote-id> (inferred from URI 'https://pypi.org/project/pyproject-hooks/')
- EPyTestPluginsSuggestion: version 1.2.0: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- NonexistentDeps: version 1.2.0: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 1.2.0: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 1.2.0: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 1.2.0: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 1.2.0: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 1.2.0: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/click
- MissingRemoteId: missing <remote-id type="github">pallets/click</remote-id> (inferred from URI 'https://github.com/pallets/click/')
- MissingRemoteId: missing <remote-id type="pypi">click</remote-id> (inferred from URI 'https://pypi.org/project/click/')
- NonexistentDeps: version 8.3.1-r1: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12, dev-python/myst-parser, dev-python/pallets-sphinx-themes, dev-python/sphinx-tabs, dev-python/sphinxcontrib-log-cabinet
- NonexistentDeps: version 8.3.1-r1: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 8.3.1-r1: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14, dev-python/myst-parser[python_targets_python3_11(-)], dev-python/myst-parser[python_targets_python3_12(-)], dev-python/myst-parser[python_targets_python3_13(-)], dev-python/myst-parser[python_targets_python3_14(-)], dev-python/pallets-sphinx-themes[python_targets_python3_11(-)], dev-python/pallets-sphinx-themes[python_targets_python3_12(-)], dev-python/pallets-sphinx-themes[python_targets_python3_13(-)], dev-python/pallets-sphinx-themes[python_targets_python3_14(-)], dev-python/sphinx-tabs[python_targets_python3_11(-)], dev-python/sphinx-tabs[python_targets_python3_12(-)], dev-python/sphinx-tabs[python_targets_python3_13(-)], dev-python/sphinx-tabs[python_targets_python3_14(-)], dev-python/sphinxcontrib-log-cabinet[python_targets_python3_11(-)], dev-python/sphinxcontrib-log-cabinet[python_targets_python3_12(-)], dev-python/sphinxcontrib-log-cabinet[python_targets_python3_13(-)], dev-python/sphinxcontrib-log-cabinet[python_targets_python3_14(-)] ]
- NonsolvableDepsInStable: version 8.3.1-r1: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 8.3.1-r1: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 8.3.1-r1: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/pyproject-metadata
- MissingRemoteId: missing <remote-id type="github">pypa/pyproject-metadata</remote-id> (inferred from URI 'https://github.com/pypa/pyproject-metadata/')
- MissingRemoteId: missing <remote-id type="pypi">pyproject-metadata</remote-id> (inferred from URI 'https://pypi.org/project/pyproject-metadata/')
- EPyTestPluginsSuggestion: version 0.9.1: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- NonexistentDeps: version 0.9.1: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 0.9.1: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 0.9.1: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 0.9.1: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 0.9.1: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 0.9.1: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/pyxdg
- MissingRemoteId: missing <remote-id type="github">takluyver/pyxdg</remote-id> (inferred from URI 'https://github.com/takluyver/pyxdg/archive/rel-0.28.tar.gz')
- MissingRemoteId: missing <remote-id type="pypi">pyxdg</remote-id> (inferred from URI 'https://pypi.org/project/pyxdg/')
- EPyTestPluginsSuggestion: version 0.28-r2: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- NonexistentDeps: version 0.28-r2: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 0.28-r2: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 0.28-r2: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 0.28-r2: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 0.28-r2: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 0.28-r2: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/pysocks
- MissingRemoteId: missing <remote-id type="github">Anorov/PySocks</remote-id> (inferred from URI 'https://github.com/Anorov/PySocks/')
- MissingRemoteId: missing <remote-id type="pypi">PySocks</remote-id> (inferred from URI 'https://pypi.org/project/PySocks/')
- NonexistentDeps: version 1.7.1-r2: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 1.7.1-r2: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 1.7.1-r2: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 1.7.1-r2: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 1.7.1-r2: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 1.7.1-r2: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/anyio
- MissingRemoteId: missing <remote-id type="github">agronholm/anyio</remote-id> (inferred from URI 'https://github.com/agronholm/anyio/')
- MissingRemoteId: missing <remote-id type="pypi">anyio</remote-id> (inferred from URI 'https://pypi.org/project/anyio/')
- NonexistentDeps: version 4.11.0: BDEPEND: nonexistent packages: >=dev-python/blockbuster-1.5.23, >=dev-python/sphinx-rtd-theme-1.2.2, >=dev-python/uvloop-0.21.0_beta1, app-lang/python:3.11, app-lang/python:3.12, dev-python/sphinx-autodoc-typehints, dev-python/sphinx-tabs, dev-python/sphinxcontrib-jquery
- NonexistentDeps: version 4.11.0: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 4.11.0: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (8 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14, >=dev-python/blockbuster-1.5.23[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], dev-python/sphinx-autodoc-typehints[python_targets_python3_11(-)], dev-python/sphinx-autodoc-typehints[python_targets_python3_12(-)], dev-python/sphinx-autodoc-typehints[python_targets_python3_13(-)], dev-python/sphinx-autodoc-typehints[python_targets_python3_14(-)], >=dev-python/sphinx-rtd-theme-1.2.2[python_targets_python3_11(-)], >=dev-python/sphinx-rtd-theme-1.2.2[python_targets_python3_12(-)], >=dev-python/sphinx-rtd-theme-1.2.2[python_targets_python3_13(-)], >=dev-python/sphinx-rtd-theme-1.2.2[python_targets_python3_14(-)], dev-python/sphinx-tabs[python_targets_python3_11(-)], dev-python/sphinx-tabs[python_targets_python3_12(-)], dev-python/sphinx-tabs[python_targets_python3_13(-)], dev-python/sphinx-tabs[python_targets_python3_14(-)], dev-python/sphinxcontrib-jquery[python_targets_python3_11(-)], dev-python/sphinxcontrib-jquery[python_targets_python3_12(-)], dev-python/sphinxcontrib-jquery[python_targets_python3_13(-)], dev-python/sphinxcontrib-jquery[python_targets_python3_14(-)], >=dev-python/uvloop-0.21.0_beta1[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-)] ]
- NonsolvableDepsInStable: version 4.11.0: nonsolvable depset(bdepend) keyword(arm64) stable profile (core/arm64/glibc) (8 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14, >=dev-python/blockbuster-1.5.23[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], dev-python/sphinx-autodoc-typehints[python_targets_python3_11(-)], dev-python/sphinx-autodoc-typehints[python_targets_python3_12(-)], dev-python/sphinx-autodoc-typehints[python_targets_python3_13(-)], dev-python/sphinx-autodoc-typehints[python_targets_python3_14(-)], >=dev-python/sphinx-rtd-theme-1.2.2[python_targets_python3_11(-)], >=dev-python/sphinx-rtd-theme-1.2.2[python_targets_python3_12(-)], >=dev-python/sphinx-rtd-theme-1.2.2[python_targets_python3_13(-)], >=dev-python/sphinx-rtd-theme-1.2.2[python_targets_python3_14(-)], dev-python/sphinx-tabs[python_targets_python3_11(-)], dev-python/sphinx-tabs[python_targets_python3_12(-)], dev-python/sphinx-tabs[python_targets_python3_13(-)], dev-python/sphinx-tabs[python_targets_python3_14(-)], dev-python/sphinxcontrib-jquery[python_targets_python3_11(-)], dev-python/sphinxcontrib-jquery[python_targets_python3_12(-)], dev-python/sphinxcontrib-jquery[python_targets_python3_13(-)], dev-python/sphinxcontrib-jquery[python_targets_python3_14(-)] ]
- NonsolvableDepsInStable: version 4.11.0: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 4.11.0: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 4.11.0: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/pygments
- MissingRemoteId: missing <remote-id type="github">pygments/pygments</remote-id> (inferred from URI 'https://github.com/pygments/pygments/')
- MissingRemoteId: missing <remote-id type="pypi">Pygments</remote-id> (inferred from URI 'https://pypi.org/project/Pygments/')
- EPyTestPluginsSuggestion: version 2.19.2: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- NonexistentDeps: version 2.19.2: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12, dev-python/wcag-contrast-ratio, virtual/ttf-fonts
- NonexistentDeps: version 2.19.2: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 2.19.2: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14, dev-python/wcag-contrast-ratio[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], virtual/ttf-fonts ]
- NonsolvableDepsInStable: version 2.19.2: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 2.19.2: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 2.19.2: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/pytest-timeout
- MissingRemoteId: missing <remote-id type="github">pytest-dev/pytest-timeout</remote-id> (inferred from URI 'https://github.com/pytest-dev/pytest-timeout/')
- MissingRemoteId: missing <remote-id type="pypi">pytest-timeout</remote-id> (inferred from URI 'https://pypi.org/project/pytest-timeout/')
- EPyTestPluginsSuggestion: version 2.4.0: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- NonexistentDeps: version 2.4.0: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 2.4.0: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 2.4.0: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 2.4.0: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 2.4.0: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 2.4.0: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/poetry-core
- MissingRemoteId: missing <remote-id type="github">python-poetry/poetry-core</remote-id> (inferred from URI 'https://github.com/python-poetry/poetry-core/')
- MissingRemoteId: missing <remote-id type="pypi">poetry-core</remote-id> (inferred from URI 'https://pypi.org/project/poetry-core/')
- NonexistentDeps: version 2.2.1: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12, dev-python/pytest-mock
- NonexistentDeps: version 2.2.1: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 2.2.1: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14, dev-python/pytest-mock[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)] ]
- NonsolvableDepsInStable: version 2.2.1: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 2.2.1: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 2.2.1: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/pytz
- MissingRemoteId: missing <remote-id type="github">stub42/pytz</remote-id> (inferred from URI 'https://github.com/stub42/pytz/')
- MissingRemoteId: missing <remote-id type="pypi">pytz</remote-id> (inferred from URI 'https://pypi.org/project/pytz/')
- NonexistentDeps: version 2025.2: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12, sys-libs/glibc
- NonexistentDeps: version 2025.2: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12, sys-libs/glibc
- NonsolvableDepsInStable: version 2025.2: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11[threads(+)], app-lang/python:3.12[threads(+)], app-lang/python:3.14[threads(+)] ]
- NonsolvableDepsInStable: version 2025.2: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11[threads(+)], app-lang/python:3.12[threads(+)], app-lang/python:3.14[threads(+)] ]
- PythonMissingDeps: version 2025.2: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 2025.2: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/pyte
- MissingRemoteId: missing <remote-id type="github">selectel/pyte</remote-id> (inferred from URI 'https://github.com/selectel/pyte/')
- MissingRemoteId: missing <remote-id type="pypi">pyte</remote-id> (inferred from URI 'https://pypi.org/project/pyte/')
- EPyTestPluginsSuggestion: version 0.8.2: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- NonexistentDeps: version 0.8.2: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 0.8.2: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 0.8.2: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 0.8.2: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 0.8.2: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 0.8.2: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/pytest-home
- MissingRemoteId: missing <remote-id type="github">jaraco/pytest-home</remote-id> (inferred from URI 'https://github.com/jaraco/pytest-home/')
- MissingRemoteId: missing <remote-id type="pypi">pytest-home</remote-id> (inferred from URI 'https://pypi.org/project/pytest-home/')
- EPyTestPluginsSuggestion: version 0.6.0: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- NonexistentDeps: version 0.6.0: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 0.6.0: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 0.6.0: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 0.6.0: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 0.6.0: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 0.6.0: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'
- WhitespaceFound: version 0.6.0: ebuild has trailing whitespace on line: 24

## dev-python/pycares
- MissingRemoteId: missing <remote-id type="github">saghul/pycares</remote-id> (inferred from URI 'https://github.com/saghul/pycares/')
- MissingRemoteId: missing <remote-id type="pypi">pycares</remote-id> (inferred from URI 'https://pypi.org/project/pycares/')
- NonexistentDeps: version 4.11.0: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 4.11.0: DEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 4.11.0: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 4.11.0: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 4.11.0: nonsolvable depset(depend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 4.11.0: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 4.11.0: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 4.11.0: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/pyyaml
- MissingRemoteId: missing <remote-id type="github">yaml/pyyaml</remote-id> (inferred from URI 'https://github.com/yaml/pyyaml/')
- MissingRemoteId: missing <remote-id type="pypi">PyYAML</remote-id> (inferred from URI 'https://pypi.org/project/PyYAML/')
- NonexistentDeps: version 6.0.3: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 6.0.3: DEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 6.0.3: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 6.0.3: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 6.0.3: nonsolvable depset(depend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 6.0.3: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 6.0.3: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 6.0.3: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/python-dateutil
- MissingRemoteId: missing <remote-id type="github">dateutil/dateutil</remote-id> (inferred from URI 'https://github.com/dateutil/dateutil/')
- MissingRemoteId: missing <remote-id type="pypi">python-dateutil</remote-id> (inferred from URI 'https://pypi.org/project/python-dateutil/')
- EPyTestPluginsSuggestion: version 2.9.0_p0: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- NonexistentDeps: version 2.9.0_p0: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 2.9.0_p0: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 2.9.0_p0: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 2.9.0_p0: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 2.9.0_p0: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 2.9.0_p0: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/retrying
- MissingRemoteId: missing <remote-id type="github">groodt/retrying</remote-id> (inferred from URI 'https://github.com/groodt/retrying/')
- MissingRemoteId: missing <remote-id type="pypi">retrying</remote-id> (inferred from URI 'https://pypi.org/project/retrying/')
- EPyTestPluginsSuggestion: version 1.4.2: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- NonexistentDeps: version 1.4.2: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 1.4.2: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 1.4.2: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 1.4.2: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 1.4.2: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 1.4.2: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/pypiserver
- MissingRemoteId: missing <remote-id type="github">pypiserver/pypiserver</remote-id> (inferred from URI 'https://github.com/pypiserver/pypiserver/')
- MissingRemoteId: missing <remote-id type="pypi">pypiserver</remote-id> (inferred from URI 'https://pypi.org/project/pypiserver/')
- NonexistentDeps: version 2.4.0: BDEPEND: nonexistent packages: >=dev-python/passlib-1.6, app-lang/python:3.11, app-lang/python:3.12, dev-py/setuptools-git, dev-python/importlib-resources, dev-python/webtest
- NonexistentDeps: version 2.4.0: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12, dev-python/importlib-resources
- NonsolvableDepsInStable: version 2.4.0: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14, dev-py/setuptools-git[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], dev-python/importlib-resources[python_targets_python3_11(-)], >=dev-python/passlib-1.6[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], dev-python/webtest[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)] ]
- NonsolvableDepsInStable: version 2.4.0: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14, dev-python/importlib-resources[python_targets_python3_11(-)] ]
- PythonMissingDeps: version 2.4.0: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 2.4.0: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/rsa
- MissingRemoteId: missing <remote-id type="github">sybrenstuvel/python-rsa</remote-id> (inferred from URI 'https://github.com/sybrenstuvel/python-rsa/')
- MissingRemoteId: missing <remote-id type="pypi">rsa</remote-id> (inferred from URI 'https://pypi.org/project/rsa/')
- NonexistentDeps: version 4.9: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 4.9: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 4.9: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 4.9: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 4.9: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 4.9: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/pyzmq
- MissingRemoteId: missing <remote-id type="github">zeromq/pyzmq</remote-id> (inferred from URI 'https://github.com/zeromq/pyzmq/')
- MissingRemoteId: missing <remote-id type="pypi">pyzmq</remote-id> (inferred from URI 'https://pypi.org/project/pyzmq/')
- NonexistentDeps: version 27.1.0: BDEPEND: nonexistent packages: >=net-libs/zeromq-4.2.2-r2, app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 27.1.0: DEPEND: nonexistent packages: >=net-libs/zeromq-4.2.2-r2, app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 27.1.0: RDEPEND: nonexistent packages: >=net-libs/zeromq-4.2.2-r2, app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 27.1.0: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11[threads(+)], app-lang/python:3.12[threads(+)], app-lang/python:3.14[threads(+)], >=net-libs/zeromq-4.2.2-r2:=[drafts] ]
- NonsolvableDepsInStable: version 27.1.0: nonsolvable depset(depend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11[threads(+)], app-lang/python:3.12[threads(+)], app-lang/python:3.14[threads(+)], >=net-libs/zeromq-4.2.2-r2:=[drafts] ]
- NonsolvableDepsInStable: version 27.1.0: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11[threads(+)], app-lang/python:3.12[threads(+)], app-lang/python:3.14[threads(+)], >=net-libs/zeromq-4.2.2-r2:=[drafts] ]
- PythonMissingDeps: version 27.1.0: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 27.1.0: unknown USE flags: 'drafts', 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/scripttest
- MissingRemoteId: missing <remote-id type="github">pypa/scripttest</remote-id> (inferred from URI 'https://github.com/pypa/scripttest/')
- MissingRemoteId: missing <remote-id type="pypi">scripttest</remote-id> (inferred from URI 'https://pypi.org/project/scripttest/')
- EPyTestPluginsSuggestion: version 2.0_p1: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- NonexistentDeps: version 2.0_p1: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 2.0_p1: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 2.0_p1: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 2.0_p1: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 2.0_p1: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 2.0_p1: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/rfc3986-validator
- MissingRemoteId: missing <remote-id type="github">naimetti/rfc3986-validator</remote-id> (inferred from URI 'https://github.com/naimetti/rfc3986-validator')
- MissingRemoteId: missing <remote-id type="pypi">rfc3986-validator</remote-id> (inferred from URI 'https://pypi.org/project/rfc3986-validator/')
- EPyTestPluginsSuggestion: version 0.1.1-r2: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- NonexistentDeps: version 0.1.1-r2: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 0.1.1-r2: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 0.1.1-r2: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 0.1.1-r2: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 0.1.1-r2: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 0.1.1-r2: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/referencing
- MissingRemoteId: missing <remote-id type="github">python-jsonschema/referencing</remote-id> (inferred from URI 'https://github.com/python-jsonschema/referencing/')
- MissingRemoteId: missing <remote-id type="pypi">referencing</remote-id> (inferred from URI 'https://pypi.org/project/referencing/')
- NonexistentDeps: version 0.37.0: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 0.37.0: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 0.37.0: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 0.37.0: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 0.37.0: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 0.37.0: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/rfc3987
- MissingRemoteId: missing <remote-id type="github">dgerber/rfc3987</remote-id> (inferred from URI 'https://github.com/dgerber/rfc3987/')
- MissingRemoteId: missing <remote-id type="pypi">rfc3987</remote-id> (inferred from URI 'https://pypi.org/project/rfc3987/')
- NonexistentDeps: version 1.3.8-r3: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 1.3.8-r3: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 1.3.8-r3: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 1.3.8-r3: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 1.3.8-r3: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 1.3.8-r3: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/resolvelib
- MissingRemoteId: missing <remote-id type="github">sarugaku/resolvelib</remote-id> (inferred from URI 'https://github.com/sarugaku/resolvelib/')
- MissingRemoteId: missing <remote-id type="pypi">resolvelib</remote-id> (inferred from URI 'https://pypi.org/project/resolvelib/')
- NonexistentDeps: version 1.2.1: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 1.2.1: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 1.2.1: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 1.2.1: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 1.2.1: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 1.2.1: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/send2trash
- MissingRemoteId: missing <remote-id type="github">arsenetar/send2trash</remote-id> (inferred from URI 'https://github.com/arsenetar/send2trash/')
- MissingRemoteId: missing <remote-id type="pypi">Send2Trash</remote-id> (inferred from URI 'https://pypi.org/project/Send2Trash/')
- EPyTestPluginsSuggestion: version 1.8.3: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- NonexistentDeps: version 1.8.3: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 1.8.3: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 1.8.3: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 1.8.3: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 1.8.3: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 1.8.3: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/pytest-cov
- MissingRemoteId: missing <remote-id type="github">pytest-dev/pytest-cov</remote-id> (inferred from URI 'https://github.com/pytest-dev/pytest-cov/')
- MissingRemoteId: missing <remote-id type="pypi">pytest-cov</remote-id> (inferred from URI 'https://pypi.org/project/pytest-cov/')
- NonexistentDeps: version 7.0.0: BDEPEND: nonexistent packages: >=dev-python/process-tests-2.0.2, app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 7.0.0: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 7.0.0: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14, >=dev-python/process-tests-2.0.2[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)] ]
- NonsolvableDepsInStable: version 7.0.0: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 7.0.0: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 7.0.0: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/safetensors
- MissingRemoteId: missing <remote-id type="github">huggingface/safetensors</remote-id> (inferred from URI 'https://github.com/huggingface/safetensors/archive/refs/tags/v0.6.2.tar.gz')
- MissingRemoteId: missing <remote-id type="pypi">safetensors</remote-id> (inferred from URI 'https://pypi.org/project/safetensors/')
- EPyTestPluginsSuggestion: version 0.6.2: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- NonexistentDeps: version 0.6.2: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12, dev-python/h5py
- NonexistentDeps: version 0.6.2: DEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 0.6.2: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 0.6.2: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14, dev-python/h5py[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)] ]
- NonsolvableDepsInStable: version 0.6.2: nonsolvable depset(depend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 0.6.2: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 0.6.2: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 0.6.2: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/secretstorage
- MissingRemoteId: missing <remote-id type="github">mitya57/secretstorage</remote-id> (inferred from URI 'https://github.com/mitya57/secretstorage/')
- MissingRemoteId: missing <remote-id type="pypi">SecretStorage</remote-id> (inferred from URI 'https://pypi.org/project/SecretStorage/')
- DoubleEmptyLine: version 3.4.1: ebuild has unneeded empty line on line: 27
- NonexistentDeps: version 3.4.1: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 3.4.1: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 3.4.1: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 3.4.1: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 3.4.1: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 3.4.1: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/rfc3339-validator
- MissingRemoteId: missing <remote-id type="github">naimetti/rfc3339-validator</remote-id> (inferred from URI 'https://github.com/naimetti/rfc3339-validator/')
- MissingRemoteId: missing <remote-id type="pypi">rfc3339-validator</remote-id> (inferred from URI 'https://pypi.org/project/rfc3339-validator/')
- EPyTestPluginsSuggestion: version 0.1.4-r1: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- NonexistentDeps: version 0.1.4-r1: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 0.1.4-r1: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 0.1.4-r1: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 0.1.4-r1: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 0.1.4-r1: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 0.1.4-r1: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/rich
- MissingRemoteId: missing <remote-id type="github">Textualize/rich</remote-id> (inferred from URI 'https://github.com/Textualize/rich/')
- MissingRemoteId: missing <remote-id type="pypi">rich</remote-id> (inferred from URI 'https://pypi.org/project/rich/')
- NonexistentDeps: version 14.2.0: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 14.2.0: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 14.2.0: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 14.2.0: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 14.2.0: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 14.2.0: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'
- WhitespaceFound: version 14.2.0: ebuild has leading whitespace on line: 66
- WhitespaceFound: version 14.2.0: ebuild has trailing whitespace on line: 8

## dev-python/rpyc
- MissingRemoteId: missing <remote-id type="github">tomerfiliba-org/rpyc</remote-id> (inferred from URI 'https://github.com/tomerfiliba-org/rpyc')
- MissingRemoteId: missing <remote-id type="pypi">rpyc</remote-id> (inferred from URI 'https://pypi.org/project/rpyc/')
- ExcessiveLineLength: version 6.0.0: excessive line length (over 120 characters) on line: 65
- NonexistentDeps: version 6.0.0: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 6.0.0: DEPEND: nonexistent packages: dev-debug/gdb, dev-python/pandas
- NonexistentDeps: version 6.0.0: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12, dev-debug/gdb, dev-python/pandas
- NonsolvableDepsInStable: version 6.0.0: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 6.0.0: nonsolvable depset(depend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ dev-debug/gdb, dev-py/numpy[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], dev-python/pandas[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)] ]
- NonsolvableDepsInStable: version 6.0.0: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14, dev-debug/gdb, dev-py/numpy[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], dev-python/pandas[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)] ]
- PythonMissingDeps: version 6.0.0: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 6.0.0: unknown USE flags: 'gdb', 'numpy', 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/smmap
- MissingRemoteId: missing <remote-id type="github">gitpython-developers/smmap</remote-id> (inferred from URI 'https://github.com/gitpython-developers/smmap/')
- MissingRemoteId: missing <remote-id type="pypi">smmap</remote-id> (inferred from URI 'https://pypi.org/project/smmap/')
- NonexistentDeps: version 6.0.0: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 6.0.0: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 6.0.0: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 6.0.0: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 6.0.0: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 6.0.0: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/semantic-version
- MissingRemoteId: missing <remote-id type="github">rbarrois/python-semanticversion</remote-id> (inferred from URI 'https://github.com/rbarrois/python-semanticversion/')
- MissingRemoteId: missing <remote-id type="pypi">semantic-version</remote-id> (inferred from URI 'https://pypi.org/project/semantic-version/')
- EPyTestPluginsSuggestion: version 2.10.0: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- NonexistentDeps: version 2.10.0: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12, dev-python/sphinx-rtd-theme
- NonexistentDeps: version 2.10.0: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 2.10.0: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14, dev-python/sphinx-rtd-theme[python_targets_python3_11(-)], dev-python/sphinx-rtd-theme[python_targets_python3_12(-)], dev-python/sphinx-rtd-theme[python_targets_python3_13(-)], dev-python/sphinx-rtd-theme[python_targets_python3_14(-)] ]
- NonsolvableDepsInStable: version 2.10.0: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 2.10.0: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 2.10.0: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/pytest-xdist
- MissingRemoteId: missing <remote-id type="github">pytest-dev/pytest-xdist</remote-id> (inferred from URI 'https://github.com/pytest-dev/pytest-xdist/')
- MissingRemoteId: missing <remote-id type="pypi">pytest-xdist</remote-id> (inferred from URI 'https://pypi.org/project/pytest-xdist/')
- NonexistentDeps: version 3.8.0: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 3.8.0: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 3.8.0: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 3.8.0: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 3.8.0: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 3.8.0: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/six
- MissingRemoteId: missing <remote-id type="github">benjaminp/six</remote-id> (inferred from URI 'https://github.com/benjaminp/six/')
- MissingRemoteId: missing <remote-id type="pypi">six</remote-id> (inferred from URI 'https://pypi.org/project/six/')
- EPyTestPluginsSuggestion: version 1.17.0: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- NonexistentDeps: version 1.17.0: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 1.17.0: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 1.17.0: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 1.17.0: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 1.17.0: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 1.17.0: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/pydantic
- MissingRemoteId: missing <remote-id type="github">pydantic/pydantic</remote-id> (inferred from URI 'https://github.com/pydantic/pydantic/')
- MissingRemoteId: missing <remote-id type="pypi">pydantic</remote-id> (inferred from URI 'https://pypi.org/project/pydantic/')
- MisplacedEclassVar: version 2.12.4: invalid pre-inherit placement, line 191: 'DISTUTILS_USE_PEP517=maturin'
- NonexistentBlocker: version 2.12.4: nonexistent blocker BDEPEND="!dev-python/pydantic-core": no matches in repo history
- NonexistentBlocker: version 2.12.4: nonexistent blocker RDEPEND="!dev-python/pydantic-core": no matches in repo history
- NonexistentDeps: version 2.12.4: BDEPEND: nonexistent packages: >=dev-python/dirty-equals-0.5.0, >=dev-python/email-validator-2.0.0, >=dev-python/inline-snapshot-0.13.3, >=dev-python/typing-inspection-0.4.1, >=dev-python/typing-inspection-0.4.2, app-lang/python:3.11, app-lang/python:3.12, dev-python/dirty-equals, dev-python/tzdata, dev-util/maturin
- NonexistentDeps: version 2.12.4: DEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 2.12.4: RDEPEND: nonexistent packages: >=dev-python/typing-inspection-0.4.2, app-lang/python:3.11, app-lang/python:3.12, dev-python/tzdata
- NonsolvableDepsInStable: version 2.12.4: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14, dev-python/dirty-equals[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], >=dev-python/dirty-equals-0.5.0[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], >=dev-python/email-validator-2.0.0[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], >=dev-python/inline-snapshot-0.13.3[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], >=dev-python/typing-inspection-0.4.1[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], >=dev-python/typing-inspection-0.4.2[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], dev-python/tzdata[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], dev-util/maturin[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)] ]
- NonsolvableDepsInStable: version 2.12.4: nonsolvable depset(depend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 2.12.4: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14, >=dev-python/typing-inspection-0.4.2[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], dev-python/tzdata[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)] ]
- PythonMissingDeps: version 2.12.4: missing RDEPEND="${PYTHON_DEPS}"
- UnknownLicense: version 2.12.4: unknown licenses: Apache-2.0-with-LLVM-exceptions, Unicode-3.0, Unicode-DFS-2016
- UnknownUseFlags: version 2.12.4: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/requests-toolbelt
- MissingRemoteId: missing <remote-id type="github">requests/toolbelt</remote-id> (inferred from URI 'https://github.com/requests/toolbelt/')
- MissingRemoteId: missing <remote-id type="pypi">requests-toolbelt</remote-id> (inferred from URI 'https://pypi.org/project/requests-toolbelt/')
- EPyTestPluginsSuggestion: version 1.0.0: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- NonexistentDeps: version 1.0.0: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 1.0.0: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 1.0.0: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 1.0.0: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 1.0.0: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 1.0.0: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14', 'test-rust'

## dev-python/shellingham
- MissingRemoteId: missing <remote-id type="github">sarugaku/shellingham</remote-id> (inferred from URI 'https://github.com/sarugaku/shellingham/')
- MissingRemoteId: missing <remote-id type="pypi">shellingham</remote-id> (inferred from URI 'https://pypi.org/project/shellingham/')
- EPyTestPluginsSuggestion: version 1.5.4: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- NonexistentDeps: version 1.5.4: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 1.5.4: DEPEND: nonexistent package: dev-python/pytest-mock
- NonexistentDeps: version 1.5.4: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 1.5.4: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 1.5.4: nonsolvable depset(depend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ dev-python/pytest-mock[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)] ]
- NonsolvableDepsInStable: version 1.5.4: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 1.5.4: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 1.5.4: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/pyopenssl
- MissingRemoteId: missing <remote-id type="github">pyca/pyopenssl</remote-id> (inferred from URI 'https://github.com/pyca/pyopenssl/')
- MissingRemoteId: missing <remote-id type="pypi">pyOpenSSL</remote-id> (inferred from URI 'https://pypi.org/project/pyOpenSSL/')
- NonexistentDeps: version 25.3.0: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12, dev-python/sphinx-rtd-theme
- NonexistentDeps: version 25.3.0: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 25.3.0: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11[threads(+)], app-lang/python:3.12[threads(+)], app-lang/python:3.14[threads(+)], dev-python/sphinx-rtd-theme[python_targets_python3_11(-)], dev-python/sphinx-rtd-theme[python_targets_python3_12(-)], dev-python/sphinx-rtd-theme[python_targets_python3_13(-)], dev-python/sphinx-rtd-theme[python_targets_python3_14(-)] ]
- NonsolvableDepsInStable: version 25.3.0: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11[threads(+)], app-lang/python:3.12[threads(+)], app-lang/python:3.14[threads(+)] ]
- PythonMissingDeps: version 25.3.0: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 25.3.0: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'
- UnusedInherits: version 25.3.0: unused eclass: toolchain-funcs

## dev-python/flask
- MissingRemoteId: missing <remote-id type="github">pallets/flask</remote-id> (inferred from URI 'https://github.com/pallets/flask/')
- MissingRemoteId: missing <remote-id type="pypi">Flask</remote-id> (inferred from URI 'https://pypi.org/project/Flask/')
- NonexistentBlocker: version 3.1.2: nonexistent blocker BDEPEND="!!dev-python/shiboken2[python_targets_python3_11(-)?,python_targets_python3_12(-)?,python_targets_python3_13(-)?,python_targets_python3_14(-)?]": no matches in repo history
- NonexistentDeps: version 3.1.2: BDEPEND: nonexistent packages: >=dev-python/asgiref-3.2, app-lang/python:3.11, app-lang/python:3.12, dev-python/pallets-sphinx-themes, dev-python/sphinx-issues, dev-python/sphinx-tabs, dev-python/sphinxcontrib-log-cabinet
- NonexistentDeps: version 3.1.2: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 3.1.2: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14, >=dev-python/asgiref-3.2[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], dev-python/pallets-sphinx-themes[python_targets_python3_11(-)], dev-python/pallets-sphinx-themes[python_targets_python3_12(-)], dev-python/pallets-sphinx-themes[python_targets_python3_13(-)], dev-python/pallets-sphinx-themes[python_targets_python3_14(-)], dev-python/sphinx-issues[python_targets_python3_11(-)], dev-python/sphinx-issues[python_targets_python3_12(-)], dev-python/sphinx-issues[python_targets_python3_13(-)], dev-python/sphinx-issues[python_targets_python3_14(-)], dev-python/sphinx-tabs[python_targets_python3_11(-)], dev-python/sphinx-tabs[python_targets_python3_12(-)], dev-python/sphinx-tabs[python_targets_python3_13(-)], dev-python/sphinx-tabs[python_targets_python3_14(-)], dev-python/sphinxcontrib-log-cabinet[python_targets_python3_11(-)], dev-python/sphinxcontrib-log-cabinet[python_targets_python3_12(-)], dev-python/sphinxcontrib-log-cabinet[python_targets_python3_13(-)], dev-python/sphinxcontrib-log-cabinet[python_targets_python3_14(-)] ]
- NonsolvableDepsInStable: version 3.1.2: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 3.1.2: missing RDEPEND="${PYTHON_DEPS}"
- UnknownKeywords: version 3.1.2: unknown KEYWORDS: 'arm', 'ppc', 'ppc64', 'x86', '~alpha', '~hppa', '~loong', '~mips', '~riscv', '~s390', '~sparc'
- UnknownUseFlags: version 3.1.2: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/sortedcontainers
- MissingRemoteId: missing <remote-id type="github">grantjenks/python-sortedcontainers</remote-id> (inferred from URI 'https://github.com/grantjenks/python-sortedcontainers/')
- MissingRemoteId: missing <remote-id type="pypi">sortedcontainers</remote-id> (inferred from URI 'https://pypi.org/project/sortedcontainers/')
- EPyTestPluginsSuggestion: version 2.4.0-r1: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- NonexistentDeps: version 2.4.0-r1: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 2.4.0-r1: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 2.4.0-r1: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 2.4.0-r1: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 2.4.0-r1: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 2.4.0-r1: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/strict-rfc3339
- MissingRemoteId: missing <remote-id type="github">danielrichman/strict-rfc3339</remote-id> (inferred from URI 'https://github.com/danielrichman/strict-rfc3339')
- MissingRemoteId: missing <remote-id type="pypi">strict-rfc3339</remote-id> (inferred from URI 'https://pypi.org/project/strict-rfc3339/')
- NonexistentDeps: version 0.7-r2: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 0.7-r2: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 0.7-r2: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 0.7-r2: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 0.7-r2: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 0.7-r2: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/sniffio
- MissingRemoteId: missing <remote-id type="github">python-trio/sniffio</remote-id> (inferred from URI 'https://github.com/python-trio/sniffio/')
- MissingRemoteId: missing <remote-id type="pypi">sniffio</remote-id> (inferred from URI 'https://pypi.org/project/sniffio/')
- EPyTestPluginsSuggestion: version 1.3.1: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- NonexistentDeps: version 1.3.1: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 1.3.1: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 1.3.1: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 1.3.1: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 1.3.1: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 1.3.1: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/requests
- MissingRemoteId: missing <remote-id type="github">psf/requests</remote-id> (inferred from URI 'https://github.com/psf/requests/')
- MissingRemoteId: missing <remote-id type="pypi">requests</remote-id> (inferred from URI 'https://pypi.org/project/requests/')
- NonexistentDeps: version 2.32.5: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 2.32.5: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 2.32.5: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11[threads(+)], app-lang/python:3.12[threads(+)], app-lang/python:3.14[threads(+)] ]
- NonsolvableDepsInStable: version 2.32.5: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11[threads(+)], app-lang/python:3.12[threads(+)], app-lang/python:3.14[threads(+)] ]
- PythonMissingDeps: version 2.32.5: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 2.32.5: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14', 'socks5', 'test-rust'

## dev-python/termcolor
- MissingRemoteId: missing <remote-id type="github">termcolor/termcolor</remote-id> (inferred from URI 'https://github.com/termcolor/termcolor/')
- MissingRemoteId: missing <remote-id type="pypi">termcolor</remote-id> (inferred from URI 'https://pypi.org/project/termcolor/')
- NonexistentDeps: version 3.2.0: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 3.2.0: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 3.2.0: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 3.2.0: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 3.2.0: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 3.2.0: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/tomli
- MissingRemoteId: missing <remote-id type="github">hukkin/tomli</remote-id> (inferred from URI 'https://github.com/hukkin/tomli/')
- MissingRemoteId: missing <remote-id type="pypi">tomli</remote-id> (inferred from URI 'https://pypi.org/project/tomli/')
- MissingUnpackerDep: version 2.3.0: missing BDEPEND="app-arch/unzip" for SRC_URI archive: [ tomli-2.3.0-py3-none-any.whl.zip ]
- NonexistentDeps: version 2.3.0: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 2.3.0: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 2.3.0: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 2.3.0: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 2.3.0: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 2.3.0: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/testpath
- MissingRemoteId: missing <remote-id type="github">jupyter/testpath</remote-id> (inferred from URI 'https://github.com/jupyter/testpath/')
- MissingRemoteId: missing <remote-id type="pypi">testpath</remote-id> (inferred from URI 'https://pypi.org/project/testpath/')
- EPyTestPluginsSuggestion: version 0.6.0: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- NonexistentDeps: version 0.6.0: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 0.6.0: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 0.6.0: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 0.6.0: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 0.6.0: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 0.6.0: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/soupsieve
- MissingRemoteId: missing <remote-id type="github">facelessuser/soupsieve</remote-id> (inferred from URI 'https://github.com/facelessuser/soupsieve/')
- MissingRemoteId: missing <remote-id type="pypi">soupsieve</remote-id> (inferred from URI 'https://pypi.org/project/soupsieve/')
- NonexistentDeps: version 2.8: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12, dev-python/beautifulsoup4, dev-python/html5lib
- NonexistentDeps: version 2.8: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 2.8: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14, dev-python/beautifulsoup4[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], dev-python/html5lib[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)] ]
- NonsolvableDepsInStable: version 2.8: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 2.8: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 2.8: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/scikit-build-core
- MissingRemoteId: missing <remote-id type="github">scikit-build/scikit-build-core</remote-id> (inferred from URI 'https://github.com/scikit-build/scikit-build-core/')
- MissingRemoteId: missing <remote-id type="pypi">scikit-build-core</remote-id> (inferred from URI 'https://pypi.org/project/scikit-build-core/')
- NonexistentDeps: version 0.11.6: BDEPEND: nonexistent packages: >=dev-python/cattrs-22.2.0, >=dev-python/pytest-subprocess-1.5, app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 0.11.6: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 0.11.6: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14, >=dev-python/cattrs-22.2.0[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], >=dev-python/pytest-subprocess-1.5[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)] ]
- NonsolvableDepsInStable: version 0.11.6: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 0.11.6: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 0.11.6: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/tomli-w
- MissingRemoteId: missing <remote-id type="github">hukkin/tomli-w</remote-id> (inferred from URI 'https://github.com/hukkin/tomli-w/')
- MissingRemoteId: missing <remote-id type="pypi">tomli-w</remote-id> (inferred from URI 'https://pypi.org/project/tomli-w/')
- EPyTestPluginsSuggestion: version 1.2.0: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- NonexistentDeps: version 1.2.0: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 1.2.0: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 1.2.0: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 1.2.0: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 1.2.0: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 1.2.0: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/tomlkit
- MissingRemoteId: missing <remote-id type="github">python-poetry/tomlkit</remote-id> (inferred from URI 'https://github.com/python-poetry/tomlkit/')
- MissingRemoteId: missing <remote-id type="pypi">tomlkit</remote-id> (inferred from URI 'https://pypi.org/project/tomlkit/')
- EPyTestPluginsSuggestion: version 0.13.3: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- NonexistentDeps: version 0.13.3: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 0.13.3: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 0.13.3: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 0.13.3: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 0.13.3: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 0.13.3: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/trove-classifiers
- MissingRemoteId: missing <remote-id type="github">pypa/trove-classifiers</remote-id> (inferred from URI 'https://github.com/pypa/trove-classifiers/')
- MissingRemoteId: missing <remote-id type="pypi">trove-classifiers</remote-id> (inferred from URI 'https://pypi.org/project/trove-classifiers/')
- NonexistentDeps: version 2025.11.14.15: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 2025.11.14.15: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 2025.11.14.15: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 2025.11.14.15: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 2025.11.14.15: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 2025.11.14.15: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/quart
- MissingRemoteId: missing <remote-id type="github">pallets/quart</remote-id> (inferred from URI 'https://github.com/pallets/quart/')
- MissingRemoteId: missing <remote-id type="pypi">Quart</remote-id> (inferred from URI 'https://pypi.org/project/Quart/')
- EPyTestPluginsSuggestion: version 0.20.0: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- NonexistentDeps: version 0.20.0: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12, dev-python/pytest-asyncio, dev-python/python-dotenv
- NonexistentDeps: version 0.20.0: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 0.20.0: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14, dev-python/pytest-asyncio[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], dev-python/python-dotenv[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)] ]
- NonsolvableDepsInStable: version 0.20.0: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 0.20.0: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 0.20.0: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/tokenizers
- MissingRemoteId: missing <remote-id type="github">huggingface/tokenizers</remote-id> (inferred from URI 'https://github.com/huggingface/tokenizers')
- EPyTestPluginsSuggestion: version 0.22.1: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- NonexistentDeps: version 0.22.1: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12, dev-libs/oniguruma, dev-python/datasets
- NonexistentDeps: version 0.22.1: DEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 0.22.1: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12, dev-libs/oniguruma
- NonsolvableDepsInStable: version 0.22.1: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14, dev-libs/oniguruma, dev-python/datasets[python_single_target_python3_11(-),python_single_target_python3_12(-),python_single_target_python3_13(-),python_single_target_python3_14(-)] ]
- NonsolvableDepsInStable: version 0.22.1: nonsolvable depset(depend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 0.22.1: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14, dev-libs/oniguruma ]
- PythonMissingDeps: version 0.22.1: missing RDEPEND="${PYTHON_DEPS}"
- UnknownLicense: version 0.22.1: unknown licenses: Apache-2.0-with-LLVM-exceptions, Unicode-DFS-2016
- UnknownUseFlags: version 0.22.1: unknown USE flags: 'python_single_target_python3_11', 'python_single_target_python3_12', 'python_single_target_python3_13', 'python_single_target_python3_14'

## dev-python/tornado
- MissingRemoteId: missing <remote-id type="github">tornadoweb/tornado</remote-id> (inferred from URI 'https://github.com/tornadoweb/tornado/')
- MissingRemoteId: missing <remote-id type="pypi">tornado</remote-id> (inferred from URI 'https://pypi.org/project/tornado/')
- NonexistentDeps: version 6.5.2: BDEPEND: nonexistent packages: >=dev-python/pycurl-7.19.3.1, >=dev-python/twisted-16.0.0, app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 6.5.2: DEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 6.5.2: RDEPEND: nonexistent packages: >=dev-python/twisted-16.0.0, app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 6.5.2: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11[threads(+)], app-lang/python:3.12[threads(+)], app-lang/python:3.14[threads(+)], >=dev-python/pycurl-7.19.3.1[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], >=dev-python/twisted-16.0.0[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)] ]
- NonsolvableDepsInStable: version 6.5.2: nonsolvable depset(depend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11[threads(+)], app-lang/python:3.12[threads(+)], app-lang/python:3.14[threads(+)] ]
- NonsolvableDepsInStable: version 6.5.2: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11[threads(+)], app-lang/python:3.12[threads(+)], app-lang/python:3.14[threads(+)], >=dev-python/twisted-16.0.0[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)] ]
- PythonMissingDeps: version 6.5.2: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 6.5.2: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/typing-extensions
- MissingRemoteId: missing <remote-id type="github">python/typing_extensions</remote-id> (inferred from URI 'https://github.com/python/typing_extensions/')
- MissingRemoteId: missing <remote-id type="pypi">typing-extensions</remote-id> (inferred from URI 'https://pypi.org/project/typing-extensions/')
- NonexistentDeps: version 4.15.0: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12, dev-python/test
- NonexistentDeps: version 4.15.0: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 4.15.0: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14, dev-python/test[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)] ]
- NonsolvableDepsInStable: version 4.15.0: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 4.15.0: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 4.15.0: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/tqdm
- MissingRemoteId: missing <remote-id type="github">tqdm/tqdm</remote-id> (inferred from URI 'https://github.com/tqdm/tqdm/')
- MissingRemoteId: missing <remote-id type="pypi">tqdm</remote-id> (inferred from URI 'https://pypi.org/project/tqdm/')
- EPyTestPluginsSuggestion: version 4.67.1: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- NonexistentDeps: version 4.67.1: BDEPEND: nonexistent packages: >=dev-python/pytest-asyncio-0.24, app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 4.67.1: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 4.67.1: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14, >=dev-python/pytest-asyncio-0.24[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)] ]
- NonsolvableDepsInStable: version 4.67.1: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 4.67.1: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 4.67.1: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/pytest
- MissingRemoteId: missing <remote-id type="github">pytest-dev/pytest</remote-id> (inferred from URI 'https://github.com/pytest-dev/pytest/')
- MissingRemoteId: missing <remote-id type="pypi">pytest</remote-id> (inferred from URI 'https://pypi.org/project/pytest/')
- NonexistentDeps: version 9.0.1: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 9.0.1: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 9.0.1: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 9.0.1: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 9.0.1: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 9.0.1: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/pdm
- MissingRemoteId: missing <remote-id type="github">pdm-project/pdm</remote-id> (inferred from URI 'https://github.com/pdm-project/pdm/')
- MissingRemoteId: missing <remote-id type="pypi">pdm</remote-id> (inferred from URI 'https://pypi.org/project/pdm/')
- NonexistentDeps: version 2.26.1: BDEPEND: nonexistent packages: <dev-python/findpython-1, <dev-python/hishel-1, >=dev-python/dep-logic-0.5, >=dev-python/findpython-0.7.0, >=dev-python/hishel-0.0.32, >=dev-python/id-1.5.0, >=dev-python/pbs-installer-2025.10.07, >=dev-python/unearth-0.17.5, app-lang/python:3.11, app-lang/python:3.12, dev-python/python-dotenv, dev-python/uv
- NonexistentDeps: version 2.26.1: RDEPEND: nonexistent packages: <dev-python/findpython-1, <dev-python/hishel-1, >=dev-python/dep-logic-0.5, >=dev-python/findpython-0.7.0, >=dev-python/hishel-0.0.32, >=dev-python/id-1.5.0, >=dev-python/pbs-installer-2025.10.07, >=dev-python/unearth-0.17.5, app-lang/python:3.11, app-lang/python:3.12, dev-python/python-dotenv
- NonsolvableDepsInStable: version 2.26.1: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14, >=dev-python/dep-logic-0.5[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], <dev-python/findpython-1[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], >=dev-python/findpython-0.7.0[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], <dev-python/hishel-1[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], >=dev-python/hishel-0.0.32[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], >=dev-python/id-1.5.0[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], >=dev-python/pbs-installer-2025.10.07[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], dev-python/python-dotenv[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], >=dev-python/unearth-0.17.5[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], dev-python/uv ]
- NonsolvableDepsInStable: version 2.26.1: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14, >=dev-python/dep-logic-0.5[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], <dev-python/findpython-1[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], >=dev-python/findpython-0.7.0[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], <dev-python/hishel-1[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], >=dev-python/hishel-0.0.32[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], >=dev-python/id-1.5.0[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], >=dev-python/pbs-installer-2025.10.07[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], dev-python/python-dotenv[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], >=dev-python/unearth-0.17.5[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)] ]
- PythonMissingDeps: version 2.26.1: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 2.26.1: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/trio-websocket
- MissingRemoteId: missing <remote-id type="github">python-trio/trio-websocket</remote-id> (inferred from URI 'https://github.com/python-trio/trio-websocket/')
- MissingRemoteId: missing <remote-id type="pypi">trio-websocket</remote-id> (inferred from URI 'https://pypi.org/project/trio-websocket/')
- EPyTestPluginsSuggestion: version 0.12.2: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- NonexistentDeps: version 0.12.2: BDEPEND: nonexistent packages: >=dev-python/pytest-trio-0.5.0, app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 0.12.2: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 0.12.2: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14, >=dev-python/pytest-trio-0.5.0[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)] ]
- NonsolvableDepsInStable: version 0.12.2: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 0.12.2: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 0.12.2: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/scikit-image
- MissingRemoteId: missing <remote-id type="github">scikit-image/scikit-image</remote-id> (inferred from URI 'https://github.com/scikit-image/scikit-image/')
- MissingRemoteId: missing <remote-id type="pypi">scikit-image</remote-id> (inferred from URI 'https://pypi.org/project/scikit-image/')
- EPyTestPluginsSuggestion: version 0.25.2: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- ExcessiveLineLength: version 0.25.2: excessive line length (over 120 characters) on line: 98
- NonexistentDeps: version 0.25.2: BDEPEND: nonexistent packages: >=dev-python/imageio-2.36, >=dev-python/lazy-loader-0.4, >=dev-python/scipy-1.11.4, >=dev-python/tifffile-2022.8.12, dev-python/pytest-localserver, dev-python/pythran
- NonexistentDeps: version 0.25.2: DEPEND: nonexistent packages: >=dev-python/imageio-2.36, >=dev-python/lazy-loader-0.4, >=dev-python/scipy-1.11.4, >=dev-python/tifffile-2022.8.12, dev-python/pythran
- NonexistentDeps: version 0.25.2: RDEPEND: nonexistent packages: >=dev-python/imageio-2.36, >=dev-python/lazy-loader-0.4, >=dev-python/scipy-1.11.4, >=dev-python/tifffile-2022.8.12
- NonsolvableDepsInStable: version 0.25.2: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.14, >=dev-python/imageio-2.36[python_targets_python3_13(-),python_targets_python3_14(-)], >=dev-python/lazy-loader-0.4[python_targets_python3_13(-),python_targets_python3_14(-)], dev-python/pytest-localserver[python_targets_python3_13(-),python_targets_python3_14(-)], dev-python/pythran[python_targets_python3_13(-),python_targets_python3_14(-)], >=dev-python/scipy-1.11.4[python_targets_python3_13(-),python_targets_python3_14(-),sparse(+)], >=dev-python/tifffile-2022.8.12[python_targets_python3_13(-),python_targets_python3_14(-)] ]
- NonsolvableDepsInStable: version 0.25.2: nonsolvable depset(depend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.14, >=dev-python/imageio-2.36[python_targets_python3_13(-),python_targets_python3_14(-)], >=dev-python/lazy-loader-0.4[python_targets_python3_13(-),python_targets_python3_14(-)], dev-python/pythran[python_targets_python3_13(-),python_targets_python3_14(-)], >=dev-python/scipy-1.11.4[python_targets_python3_13(-),python_targets_python3_14(-),sparse(+)], >=dev-python/tifffile-2022.8.12[python_targets_python3_13(-),python_targets_python3_14(-)] ]
- NonsolvableDepsInStable: version 0.25.2: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.14, >=dev-python/imageio-2.36[python_targets_python3_13(-),python_targets_python3_14(-)], >=dev-python/lazy-loader-0.4[python_targets_python3_13(-),python_targets_python3_14(-)], >=dev-python/scipy-1.11.4[python_targets_python3_13(-),python_targets_python3_14(-),sparse(+)], >=dev-python/tifffile-2022.8.12[python_targets_python3_13(-),python_targets_python3_14(-)] ]
- PythonMissingDeps: version 0.25.2: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 0.25.2: unknown USE flags: 'python_targets_python3_13', 'python_targets_python3_14'
- WhitespaceFound: version 0.25.2: ebuild has leading whitespace on lines: 93, 94, 95, 96, 97, 98

## dev-python/tzlocal
- MissingRemoteId: missing <remote-id type="github">regebro/tzlocal</remote-id> (inferred from URI 'https://github.com/regebro/tzlocal/')
- MissingRemoteId: missing <remote-id type="pypi">tzlocal</remote-id> (inferred from URI 'https://pypi.org/project/tzlocal/')
- EPyTestPluginsSuggestion: version 5.3.1: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- NonexistentDeps: version 5.3.1: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12, dev-python/pytest-mock
- NonexistentDeps: version 5.3.1: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 5.3.1: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14, dev-python/pytest-mock[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)] ]
- NonsolvableDepsInStable: version 5.3.1: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 5.3.1: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 5.3.1: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/towncrier
- MissingRemoteId: missing <remote-id type="github">twisted/towncrier</remote-id> (inferred from URI 'https://github.com/twisted/towncrier/')
- MissingRemoteId: missing <remote-id type="pypi">towncrier</remote-id> (inferred from URI 'https://pypi.org/project/towncrier/')
- NonexistentDeps: version 25.8.0: BDEPEND: nonexistent packages: >=dev-python/twisted-16.0.0, app-lang/python:3.11, app-lang/python:3.12, dev-python/click-default-group
- NonexistentDeps: version 25.8.0: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12, dev-python/click-default-group
- NonsolvableDepsInStable: version 25.8.0: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14, dev-python/click-default-group[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], >=dev-python/twisted-16.0.0[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)] ]
- NonsolvableDepsInStable: version 25.8.0: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14, dev-python/click-default-group[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)] ]
- PythonMissingDeps: version 25.8.0: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 25.8.0: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/uri-template
- MissingRemoteId: missing <remote-id type="pypi">uri-template</remote-id> (inferred from URI 'https://pypi.org/project/uri-template/')
- NonexistentDeps: version 1.3.0: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 1.3.0: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 1.3.0: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 1.3.0: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 1.3.0: missing RDEPEND="${PYTHON_DEPS}"
- PythonMissingSCMDependency: version 1.3.0: defines SETUPTOOLS_SCM_PRETEND_VERSION but is missing BDEPEND on setuptools-scm or alike
- UnknownUseFlags: version 1.3.0: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/uc-micro-py
- MissingRemoteId: missing <remote-id type="github">tsutsu3/uc.micro-py</remote-id> (inferred from URI 'https://github.com/tsutsu3/uc.micro-py/')
- MissingRemoteId: missing <remote-id type="pypi">uc-micro-py</remote-id> (inferred from URI 'https://pypi.org/project/uc-micro-py/')
- EPyTestPluginsSuggestion: version 1.0.3: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- NonexistentDeps: version 1.0.3: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 1.0.3: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 1.0.3: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 1.0.3: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 1.0.3: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 1.0.3: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/uritemplate
- MissingRemoteId: missing <remote-id type="github">python-hyper/uritemplate</remote-id> (inferred from URI 'https://github.com/python-hyper/uritemplate/')
- MissingRemoteId: missing <remote-id type="pypi">uritemplate</remote-id> (inferred from URI 'https://pypi.org/project/uritemplate/')
- EPyTestPluginsSuggestion: version 4.2.0: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- NonexistentDeps: version 4.2.0: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 4.2.0: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 4.2.0: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 4.2.0: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 4.2.0: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 4.2.0: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/trustme
- MissingRemoteId: missing <remote-id type="github">python-trio/trustme</remote-id> (inferred from URI 'https://github.com/python-trio/trustme/')
- MissingRemoteId: missing <remote-id type="pypi">trustme</remote-id> (inferred from URI 'https://pypi.org/project/trustme/')
- EPyTestPluginsSuggestion: version 1.2.1: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- NonexistentDeps: version 1.2.1: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12, dev-python/service-identity
- NonexistentDeps: version 1.2.1: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 1.2.1: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14, dev-python/service-identity[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)] ]
- NonsolvableDepsInStable: version 1.2.1: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 1.2.1: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 1.2.1: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/wcwidth
- MissingRemoteId: missing <remote-id type="github">jquast/wcwidth</remote-id> (inferred from URI 'https://github.com/jquast/wcwidth/')
- MissingRemoteId: missing <remote-id type="pypi">wcwidth</remote-id> (inferred from URI 'https://pypi.org/project/wcwidth/')
- NonexistentDeps: version 0.2.14: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 0.2.14: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 0.2.14: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 0.2.14: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 0.2.14: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 0.2.14: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/webcolors
- MissingRemoteId: missing <remote-id type="github">ubernostrum/webcolors</remote-id> (inferred from URI 'https://github.com/ubernostrum/webcolors/')
- MissingRemoteId: missing <remote-id type="pypi">webcolors</remote-id> (inferred from URI 'https://pypi.org/project/webcolors/')
- NonexistentDeps: version 25.10.0: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 25.10.0: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 25.10.0: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 25.10.0: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 25.10.0: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 25.10.0: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/webencodings
- MissingRemoteId: missing <remote-id type="github">gsnedders/python-webencodings</remote-id> (inferred from URI 'https://github.com/gsnedders/python-webencodings/')
- MissingRemoteId: missing <remote-id type="pypi">webencodings</remote-id> (inferred from URI 'https://pypi.org/project/webencodings/')
- EPyTestPluginsSuggestion: version 0.5.1-r2: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- NonexistentDeps: version 0.5.1-r2: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 0.5.1-r2: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 0.5.1-r2: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 0.5.1-r2: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 0.5.1-r2: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 0.5.1-r2: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/scikit-build
- MissingRemoteId: missing <remote-id type="github">scikit-build/scikit-build</remote-id> (inferred from URI 'https://github.com/scikit-build/scikit-build/')
- MissingRemoteId: missing <remote-id type="pypi">scikit-build</remote-id> (inferred from URI 'https://pypi.org/project/scikit-build/')
- NonexistentDeps: version 0.18.1: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12, dev-python/sphinx-issues, dev-python/sphinx-rtd-theme
- NonexistentDeps: version 0.18.1: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 0.18.1: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14, dev-python/sphinx-issues[python_targets_python3_11(-)], dev-python/sphinx-issues[python_targets_python3_12(-)], dev-python/sphinx-issues[python_targets_python3_13(-)], dev-python/sphinx-issues[python_targets_python3_14(-)], dev-python/sphinx-rtd-theme[python_targets_python3_11(-)], dev-python/sphinx-rtd-theme[python_targets_python3_12(-)], dev-python/sphinx-rtd-theme[python_targets_python3_13(-)], dev-python/sphinx-rtd-theme[python_targets_python3_14(-)] ]
- NonsolvableDepsInStable: version 0.18.1: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 0.18.1: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 0.18.1: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/sympy
- MissingRemoteId: missing <remote-id type="github">sympy/sympy</remote-id> (inferred from URI 'https://github.com/sympy/sympy/')
- MissingRemoteId: missing <remote-id type="pypi">sympy</remote-id> (inferred from URI 'https://pypi.org/project/sympy/')
- NonexistentDeps: version 1.14.0-r2: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12, app-text/dvipng, app-text/ghostscript-gpl, dev-python/ipython, dev-python/pyglet, dev-python/symengine, dev-texlive/texlive-fontsextra, virtual/latex-base
- NonexistentDeps: version 1.14.0-r2: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12, app-text/dvipng, app-text/ghostscript-gpl, dev-python/ipython, dev-python/pyglet, dev-python/symengine, dev-texlive/texlive-fontsextra, virtual/latex-base
- NonsolvableDepsInStable: version 1.14.0-r2: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14, app-text/dvipng, app-text/ghostscript-gpl, dev-python/ipython[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], >=dev-python/mpmath-1.1.0[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], dev-python/pyglet[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], dev-python/symengine[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], dev-texlive/texlive-fontsextra, virtual/latex-base ]
- NonsolvableDepsInStable: version 1.14.0-r2: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14, app-text/dvipng, app-text/ghostscript-gpl, dev-python/ipython[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], >=dev-python/mpmath-1.1.0[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], dev-python/pyglet[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], dev-python/symengine[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], dev-texlive/texlive-fontsextra, virtual/latex-base ]
- PythonMissingDeps: version 1.14.0-r2: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 1.14.0-r2: unknown USE flags: 'imaging', 'ipython', 'latex', 'mathml', 'pyglet', 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14', 'symengine'
- WhitespaceFound: version 1.14.0-r2: ebuild has trailing whitespace on line: 8

## dev-rust/cargo-c
- MissingRemoteId: missing <remote-id type="github">lu-zero/cargo-c</remote-id> (inferred from URI 'https://github.com/lu-zero/cargo-c')

## dev-python/traitlets
- MissingRemoteId: missing <remote-id type="github">ipython/traitlets</remote-id> (inferred from URI 'https://github.com/ipython/traitlets/')
- MissingRemoteId: missing <remote-id type="pypi">traitlets</remote-id> (inferred from URI 'https://pypi.org/project/traitlets/')
- EPyTestPluginsSuggestion: version 5.14.3: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- NonexistentDeps: version 5.14.3: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12, dev-python/myst-parser, dev-python/pydata-sphinx-theme, dev-python/pytest-mock
- NonexistentDeps: version 5.14.3: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 5.14.3: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14, dev-python/myst-parser[python_targets_python3_11(-)], dev-python/myst-parser[python_targets_python3_12(-)], dev-python/myst-parser[python_targets_python3_13(-)], dev-python/myst-parser[python_targets_python3_14(-)], dev-python/pydata-sphinx-theme[python_targets_python3_11(-)], dev-python/pydata-sphinx-theme[python_targets_python3_12(-)], dev-python/pydata-sphinx-theme[python_targets_python3_13(-)], dev-python/pydata-sphinx-theme[python_targets_python3_14(-)], dev-python/pytest-mock[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)] ]
- NonsolvableDepsInStable: version 5.14.3: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 5.14.3: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 5.14.3: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-rust/codex
- MissingRemoteId: missing <remote-id type="github">openai/codex</remote-id> (inferred from URI 'https://github.com/openai/codex')
- SizeViolation: 'files/gpt_5_1_prompt.md' exceeds 20.0 KiB in size; 28.8 KiB total
- SizeViolation: 'files/prompt.md' exceeds 20.0 KiB in size; 23.8 KiB total
- TotalSizeViolation: files/ directory exceeds 50.0 KiB in size; 69.7 KiB total

## dev-rust/codeql
- MissingRemoteId: missing <remote-id type="github">github/codeql</remote-id> (inferred from URI 'https://github.com/github/codeql')
- DoubleEmptyLine: version 20251203: ebuild has unneeded empty line on line: 19
- TrailingEmptyLine: version 20251203: ebuild has trailing blank line(s)

## dev-python/websocket-client
- MissingRemoteId: missing <remote-id type="github">websocket-client/websocket-client</remote-id> (inferred from URI 'https://github.com/websocket-client/websocket-client/')
- MissingRemoteId: missing <remote-id type="pypi">websocket-client</remote-id> (inferred from URI 'https://pypi.org/project/websocket-client/')
- NonexistentDeps: version 1.9.0: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12, dev-python/python-socks
- NonexistentDeps: version 1.9.0: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 1.9.0: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14, dev-python/python-socks[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)] ]
- NonsolvableDepsInStable: version 1.9.0: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 1.9.0: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 1.9.0: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-rust/ripgrep
- MissingRemoteId: missing <remote-id type="github">BurntSushi/ripgrep</remote-id> (inferred from URI 'https://github.com/BurntSushi/ripgrep')

## dev-rust/hyperfine
- MissingRemoteId: missing <remote-id type="github">sharkdp/hyperfine</remote-id> (inferred from URI 'https://github.com/sharkdp/hyperfine')

## dev-python/truststore
- MissingRemoteId: missing <remote-id type="github">sethmlarson/truststore</remote-id> (inferred from URI 'https://github.com/sethmlarson/truststore/')
- MissingRemoteId: missing <remote-id type="pypi">truststore</remote-id> (inferred from URI 'https://pypi.org/project/truststore/')
- NonexistentDeps: version 0.10.4: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 0.10.4: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 0.10.4: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 0.10.4: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 0.10.4: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 0.10.4: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/typer
- MissingRemoteId: missing <remote-id type="github">fastapi/typer</remote-id> (inferred from URI 'https://github.com/fastapi/typer/')
- MissingRemoteId: missing <remote-id type="pypi">typer</remote-id> (inferred from URI 'https://pypi.org/project/typer/')
- NonexistentBlocker: version 0.20.0: nonexistent blocker BDEPEND="!dev-lang/erlang": no matches in repo history
- NonexistentBlocker: version 0.20.0: nonexistent blocker RDEPEND="!dev-lang/erlang": no matches in repo history
- NonexistentDeps: version 0.20.0: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 0.20.0: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 0.20.0: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 0.20.0: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 0.20.0: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 0.20.0: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/starlette
- MissingRemoteId: missing <remote-id type="github">Kludex/starlette</remote-id> (inferred from URI 'https://github.com/Kludex/starlette/')
- MissingRemoteId: missing <remote-id type="pypi">starlette</remote-id> (inferred from URI 'https://pypi.org/project/starlette/')
- NonexistentDeps: version 0.50.0: BDEPEND: nonexistent packages: >=dev-python/python-multipart-0.0.18, app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 0.50.0: RDEPEND: nonexistent packages: >=dev-python/python-multipart-0.0.18, app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 0.50.0: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14, >=dev-python/python-multipart-0.0.18[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)] ]
- NonsolvableDepsInStable: version 0.50.0: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14, >=dev-python/python-multipart-0.0.18[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)] ]
- PythonMissingDeps: version 0.50.0: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 0.50.0: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## fonts/encodings
- MissingRemoteId: missing <remote-id type="freedesktop-gitlab">xorg/font/encodings</remote-id> (inferred from URI 'https://gitlab.freedesktop.org/xorg/font/encodings/-/archive/a7e63704951b95351096c1d96808d48d0fb7e0a8/encodings-a7e63704951b95351096c1d96808d48d0fb7e0a8.tar.bz2')
- RedundantUriRename: version 20240302: redundant rename: https://gitlab.freedesktop.org/xorg/font/encodings/-/archive/a7e63704951b95351096c1d96808d48d0fb7e0a8/encodings-a7e63704951b95351096c1d96808d48d0fb7e0a8.tar.bz2 -> encodings-a7e63704951b95351096c1d96808d48d0fb7e0a8.tar.bz2

## fonts/font-util
- MissingRemoteId: missing <remote-id type="freedesktop-gitlab">xorg/font/util</remote-id> (inferred from URI 'https://gitlab.freedesktop.org/xorg/font/util/-/archive/7af30077fc459e7fe3415ffa803583d7465a8a99/util-7af30077fc459e7fe3415ffa803583d7465a8a99.tar.bz2')
- MissingLicense: version 20250831: no license defined
- RedundantUriRename: version 20250831: redundant rename: https://gitlab.freedesktop.org/xorg/font/util/-/archive/7af30077fc459e7fe3415ffa803583d7465a8a99/util-7af30077fc459e7fe3415ffa803583d7465a8a99.tar.bz2 -> util-7af30077fc459e7fe3415ffa803583d7465a8a99.tar.bz2
- UnquotedVariable: version 20250831: unquoted variable EPREFIX on lines: 29, 30

## dev-python/trio
- MissingRemoteId: missing <remote-id type="github">python-trio/trio</remote-id> (inferred from URI 'https://github.com/python-trio/trio/')
- MissingRemoteId: missing <remote-id type="pypi">trio</remote-id> (inferred from URI 'https://pypi.org/project/trio/')
- NonexistentDeps: version 0.32.0: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 0.32.0: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 0.32.0: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 0.32.0: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 0.32.0: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 0.32.0: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-rust/fd
- MissingRemoteId: missing <remote-id type="github">sharkdp/fd</remote-id> (inferred from URI 'https://github.com/sharkdp/fd')

## dev-python/selenium
- MissingRemoteId: missing <remote-id type="github">SeleniumHQ/selenium</remote-id> (inferred from URI 'https://github.com/SeleniumHQ/selenium/tree/trunk/py/')
- MissingRemoteId: missing <remote-id type="pypi">selenium</remote-id> (inferred from URI 'https://pypi.org/project/selenium/')
- NonexistentDeps: version 4.38.0: BDEPEND: nonexistent packages: >=dev-util/selenium-manager-4.38.0, app-lang/python:3.11, app-lang/python:3.12, dev-python/filetype, dev-python/pytest-mock, dev-python/pytest-rerunfailures, net-misc/geckodriver, www-client/firefox, www-client/firefox-bin
- NonexistentDeps: version 4.38.0: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 4.38.0: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14, dev-python/filetype[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], dev-python/pytest-mock[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], dev-python/pytest-rerunfailures[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], >=dev-util/selenium-manager-4.38.0, net-misc/geckodriver, www-client/firefox, www-client/firefox-bin ]
- NonsolvableDepsInStable: version 4.38.0: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 4.38.0: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 4.38.0: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14', 'test-rust'

## dev-python/wsproto
- MissingRemoteId: missing <remote-id type="github">python-hyper/wsproto</remote-id> (inferred from URI 'https://github.com/python-hyper/wsproto/')
- MissingRemoteId: missing <remote-id type="pypi">wsproto</remote-id> (inferred from URI 'https://pypi.org/project/wsproto/')
- NonexistentDeps: version 1.3.1: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 1.3.1: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 1.3.1: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 1.3.1: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 1.3.1: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 1.3.1: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## fonts/fontconfig
- MissingRemoteId: missing <remote-id type="freedesktop-gitlab">fontconfig/fontconfig</remote-id> (inferred from URI 'https://gitlab.freedesktop.org/fontconfig/fontconfig/-/archive/8cf02f984956961fab6cc970e130eb3d29fb1ec0/fontconfig-8cf02f984956961fab6cc970e130eb3d29fb1ec0.tar.bz2')

## fonts/liberation-fonts
- MissingRemoteId: missing <remote-id type="github">liberationfonts/liberation-fonts</remote-id> (inferred from URI 'https://github.com/liberationfonts/liberation-fonts/files/7261482/liberation-fonts-ttf-2.1.5.tar.gz')
- VariableOrderWrong: version 2.1.5: variable LICENSE should occur before SLOT
- VariableOrderWrong: version 2.1.5: variable SLOT should occur before KEYWORDS
- VariableScope: version 2.1.5: variable 'S' used in 'pkg_setup' on line: 20
- VariableScope: version 2.1.5: variable 'WORKDIR' used in 'pkg_setup' on line: 19

## lib-core/bdwgc
- MissingRemoteId: missing <remote-id type="github">ivmai/bdwgc</remote-id> (inferred from URI 'https://github.com/ivmai/bdwgc')

## dev-python/websockets
- MissingRemoteId: missing <remote-id type="github">python-websockets/websockets</remote-id> (inferred from URI 'https://github.com/python-websockets/websockets/')
- MissingRemoteId: missing <remote-id type="pypi">websockets</remote-id> (inferred from URI 'https://pypi.org/project/websockets/')
- EPyTestPluginsSuggestion: version 15.0.1: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- NonexistentDeps: version 15.0.1: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12, dev-python/pytest-rerunfailures
- NonexistentDeps: version 15.0.1: DEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 15.0.1: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 15.0.1: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14, dev-python/pytest-rerunfailures[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)] ]
- NonsolvableDepsInStable: version 15.0.1: nonsolvable depset(depend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 15.0.1: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 15.0.1: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 15.0.1: unknown USE flags: 'native-extensions', 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## dev-python/wheel
- MissingRemoteId: missing <remote-id type="github">pypa/wheel</remote-id> (inferred from URI 'https://github.com/pypa/wheel/')
- MissingRemoteId: missing <remote-id type="pypi">wheel</remote-id> (inferred from URI 'https://pypi.org/project/wheel/')
- NonexistentDeps: version 0.45.1: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 0.45.1: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 0.45.1: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 0.45.1: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 0.45.1: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 0.45.1: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## lib-core/expat
- MissingRemoteId: missing <remote-id type="github">libexpat/libexpat</remote-id> (inferred from URI 'https://github.com/libexpat/libexpat')

## lib-core/jansson
- MissingRemoteId: missing <remote-id type="github">akheron/jansson</remote-id> (inferred from URI 'https://github.com/akheron/jansson')

## dev-python/pip
- MissingRemoteId: missing <remote-id type="github">pypa/pip</remote-id> (inferred from URI 'https://github.com/pypa/pip/')
- MissingRemoteId: missing <remote-id type="pypi">pip</remote-id> (inferred from URI 'https://pypi.org/project/pip/')
- NonexistentDeps: version 25.3: BDEPEND: nonexistent packages: <dev-py/setuptools-80, app-lang/python:3.11, app-lang/python:3.12, dev-python/ensurepip-wheel, dev-python/pytest-rerunfailures
- NonexistentDeps: version 25.3: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 25.3: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11[ssl(+),threads(+)], app-lang/python:3.12[ssl(+),threads(+)], app-lang/python:3.14[ssl(+),threads(+)], <dev-py/setuptools-80[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], dev-python/ensurepip-wheel, dev-python/pytest-rerunfailures[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)] ]
- NonsolvableDepsInStable: version 25.3: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11[ssl(+),threads(+)], app-lang/python:3.12[ssl(+),threads(+)], app-lang/python:3.14[ssl(+),threads(+)] ]
- PythonMissingDeps: version 25.3: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 25.3: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14', 'test-rust'
- WhitespaceFound: version 25.3: ebuild has trailing whitespace on line: 12

## lib-core/iniparser
- MissingRemoteId: missing <remote-id type="github">ndevilla/iniparser</remote-id> (inferred from URI 'https://github.com/ndevilla/iniparser/archive/4bef811283e0ec1658c60e09950bd5a1ddc92e4b.tar.gz')

## lib-core/gdbm
- MissingRemoteId: missing <remote-id type="github">1g4-mirror/gdbm</remote-id> (inferred from URI 'https://github.com/1g4-mirror/gdbm/archive/fb46d987d613e4d56981d30f2b9f34288ef42858.tar.gz')

## lib-core/isl
- InvalidUseFlags: version 20251122: invalid USE flag: 'gdb.py'

## dev-python/xcffib
- MissingRemoteId: missing <remote-id type="github">tych0/xcffib</remote-id> (inferred from URI 'https://github.com/tych0/xcffib/')
- MissingRemoteId: missing <remote-id type="pypi">xcffib</remote-id> (inferred from URI 'https://pypi.org/project/xcffib/')
- NonexistentDeps: version 1.11.2: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12, x11-apps/xeyes, x11-base/xorg-server, x11-libs/libxcb
- NonexistentDeps: version 1.11.2: DEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12, x11-libs/libxcb
- NonexistentDeps: version 1.11.2: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12, x11-libs/libxcb
- NonsolvableDepsInStable: version 1.11.2: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14, x11-apps/xeyes, x11-base/xorg-server[xvfb], x11-libs/libxcb ]
- NonsolvableDepsInStable: version 1.11.2: nonsolvable depset(depend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14, x11-libs/libxcb ]
- NonsolvableDepsInStable: version 1.11.2: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14, x11-libs/libxcb ]
- PythonMissingDeps: version 1.11.2: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 1.11.2: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## lib-core/libassuan
- MissingRemoteId: missing <remote-id type="github">gpg/libassuan</remote-id> (inferred from URI 'https://github.com/gpg/libassuan/archive/563252ade0684fb197c095da2d6272dfc763a852.tar.gz')

## lib-core/libcap-ng
- MissingRemoteId: missing <remote-id type="github">stevegrubb/libcap-ng</remote-id> (inferred from URI 'https://github.com/stevegrubb/libcap-ng/archive/3b6819b057fcd9289886961ea198d822ff26e373.tar.gz')

## lib-core/libapparmor
- MissingRemoteId: missing <remote-id type="gitlab">apparmor/apparmor/wikis/home</remote-id> (inferred from URI 'https://gitlab.com/apparmor/apparmor/wikis/home')
- PythonMissingDeps: version 20251202: missing BDEPEND="${DISTUTILS_DEPS}"
- PythonMissingDeps: version 20251202: missing RDEPEND="${PYTHON_DEPS}"
- RedundantUriRename: version 20251202: redundant rename: https://gitlab.com/apparmor/apparmor/-/archive/a7b4b3c726514f4e8bc21536d73c1fd2dcd44313/apparmor-a7b4b3c726514f4e8bc21536d73c1fd2dcd44313.tar.bz2 -> apparmor-a7b4b3c726514f4e8bc21536d73c1fd2dcd44313.tar.bz2
- UnknownKeywords: version 20251202: unknown KEYWORDS: '~arm', '~ppc64', '~riscv', '~x86'
- UnknownUseFlags: version 20251202: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'
- UnusedInherits: version 20251202: unused eclass: perl-functions

## dev-python/zipp
- MissingRemoteId: missing <remote-id type="github">jaraco/zipp</remote-id> (inferred from URI 'https://github.com/jaraco/zipp/')
- MissingRemoteId: missing <remote-id type="pypi">zipp</remote-id> (inferred from URI 'https://pypi.org/project/zipp/')
- EPyTestPluginsSuggestion: version 3.23.0: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- NonexistentDeps: version 3.23.0: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12, dev-python/jaraco-itertools, dev-python/jaraco-test
- NonexistentDeps: version 3.23.0: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 3.23.0: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14, dev-python/jaraco-itertools[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], dev-python/jaraco-test[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)] ]
- NonsolvableDepsInStable: version 3.23.0: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 3.23.0: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 3.23.0: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## lib-core/libelf
- MissingRemoteId: missing <remote-id type="github">arachsys/libelf</remote-id> (inferred from URI 'https://github.com/arachsys/libelf/archive/f38ceb5a8ae75cb475471092bf76ec9ccad6e0ab.tar.gz')
- IndirectInherits: version 20251027: toolchain-funcs: indirect inherit usage: 'tc-getAR', line 20
- UnusedInherits: version 20251027: unused eclass: flag-o-matic

## dev-python/werkzeug
- MissingRemoteId: missing <remote-id type="github">pallets/werkzeug</remote-id> (inferred from URI 'https://github.com/pallets/werkzeug/')
- MissingRemoteId: missing <remote-id type="pypi">Werkzeug</remote-id> (inferred from URI 'https://pypi.org/project/Werkzeug/')
- EPyTestPluginsSuggestion: version 3.1.3: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- NonexistentDeps: version 3.1.3: BDEPEND: nonexistent packages: >=dev-python/pytest-xprocess-1, >=dev-python/watchdog-2.3, app-lang/python:3.11, app-lang/python:3.12, dev-python/ephemeral-port-reserve
- NonexistentDeps: version 3.1.3: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 3.1.3: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14, dev-python/ephemeral-port-reserve[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], >=dev-python/pytest-xprocess-1[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], >=dev-python/watchdog-2.3[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)] ]
- NonsolvableDepsInStable: version 3.1.3: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 3.1.3: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 3.1.3: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14', 'test-rust'

## dev-python/xmlschema
- MissingRemoteId: missing <remote-id type="github">sissaschool/xmlschema</remote-id> (inferred from URI 'https://github.com/sissaschool/xmlschema/')
- MissingRemoteId: missing <remote-id type="pypi">xmlschema</remote-id> (inferred from URI 'https://pypi.org/project/xmlschema/')
- NonexistentDeps: version 4.2.0: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 4.2.0: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 4.2.0: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 4.2.0: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 4.2.0: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 4.2.0: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## lib-core/libgpg-error
- MissingRemoteId: missing <remote-id type="github">gpg/libgpg-error</remote-id> (inferred from URI 'https://github.com/gpg/libgpg-error/archive/a2a752fe21cce949a7b6b82bd903b46a73cce968.tar.gz')

## lib-core/libffi
- MissingRemoteId: missing <remote-id type="github">libffi/libffi</remote-id> (inferred from URI 'https://github.com/libffi/libffi')

## lib-core/libgcrypt
- MissingRemoteId: missing <remote-id type="github">gpg/libgcrypt</remote-id> (inferred from URI 'https://github.com/gpg/libgcrypt/archive/2b8b483d42b3eb1ac276756ec019725704ed8096.tar.gz')
- UnknownUseFlags: version 1.11.20251127: unknown USE flag: 'o-flag-munging'

## lib-core/gmp
- DoubleEmptyLine: version 6.3.20250618151808: ebuild has unneeded empty line on line: 29
- GlobDistdir: version 6.3.20250618151808: line 26: unsafe filename expansion used with DISTDIR: "${DISTDIR}"/gmp-*.tar.zst
- IndirectInherits: version 6.3.20250618151808: toolchain-funcs: indirect inherit usage: 'tc-export CC', line 48
- UnknownUseFlags: version 6.3.20250618151808: unknown USE flags: 'asm', 'pgo'
- WhitespaceFound: version 6.3.20250618151808: ebuild has leading whitespace on line: 54

## dev-python/transformers
- MissingRemoteId: missing <remote-id type="github">huggingface/transformers</remote-id> (inferred from URI 'https://github.com/huggingface/transformers/archive/refs/tags/v4.57.0.tar.gz')
- MissingRemoteId: missing <remote-id type="pypi">transformers</remote-id> (inferred from URI 'https://pypi.org/project/transformers/')
- NonexistentDeps: version 4.57.0: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12, dev-python/caffe2, dev-python/pytest-import-check, dev-python/pytorch
- NonexistentDeps: version 4.57.0: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12, dev-python/caffe2, dev-python/pytorch
- NonsolvableDepsInStable: version 4.57.0: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14, dev-py/numpy[python_targets_python3_11(-)], dev-py/numpy[python_targets_python3_12(-)], dev-python/caffe2[python_single_target_python3_11(-),python_single_target_python3_12(-),python_single_target_python3_13(-),python_single_target_python3_14(-)], dev-python/pytest-import-check[python_targets_python3_11(-)], dev-python/pytest-import-check[python_targets_python3_12(-)], dev-python/pytest-import-check[python_targets_python3_13(-)], dev-python/pytest-import-check[python_targets_python3_14(-)], dev-python/pytorch[python_single_target_python3_11(-),python_single_target_python3_12(-),python_single_target_python3_13(-),python_single_target_python3_14(-)] ]
- NonsolvableDepsInStable: version 4.57.0: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14, dev-py/numpy[python_targets_python3_11(-)], dev-py/numpy[python_targets_python3_12(-)], dev-python/caffe2[python_single_target_python3_11(-),python_single_target_python3_12(-),python_single_target_python3_13(-),python_single_target_python3_14(-)], dev-python/pytorch[python_single_target_python3_11(-),python_single_target_python3_12(-),python_single_target_python3_13(-),python_single_target_python3_14(-)] ]
- PythonMissingDeps: version 4.57.0: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 4.57.0: unknown USE flags: 'python_single_target_python3_11', 'python_single_target_python3_12', 'python_single_target_python3_13', 'python_single_target_python3_14', 'torch'

## lib-core/elfutils
- MissingRemoteId: missing <remote-id type="github">1g4-mirror/elfutils</remote-id> (inferred from URI 'https://github.com/1g4-mirror/elfutils/archive/a3146e978d2e0f33b9c8106ff288745d31d5f243.tar.gz')
- IndirectInherits: version 20251118: toolchain-funcs: indirect inherit usage: 'tc-getCC', line 91
- MissingTestRestrict: version 20251118: missing RESTRICT="!test? ( test )" with IUSE=test
- UnknownUseFlags: version 20251118: unknown USE flags: 'debuginfod', 'debugpred', 'demangler', 'gcov', 'gnu-ld', 'gprof', 'helgrind', 'largefile', 'libdebuginfod', 'rpath', 'sanitize-address', 'sanitize-memory', 'sanitize-undefined', 'stacktrace', 'symbol-versioning', 'tests-rpath', 'textrelcheck', 'utils', 'valgrind', 'with_valgrind', 'year2038'

## lib-core/libcap
- MissingRemoteId: missing <remote-id type="github">1g4-mirror/libcap</remote-id> (inferred from URI 'https://github.com/1g4-mirror/libcap/archive/542d7d86ecd2129dd5fe7e5b31ba307304f5b319.tar.gz')

## lib-core/libksba
- MissingRemoteId: missing <remote-id type="github">gpg/libksba</remote-id> (inferred from URI 'https://github.com/gpg/libksba/archive/2dd35bef663f5ba89260222299aabffd017c4bbd.tar.gz')

## lib-core/libpipeline
- MissingRemoteId: missing <remote-id type="gitlab">libpipeline/libpipeline</remote-id> (inferred from URI 'https://gitlab.com/libpipeline/libpipeline/-/archive/08844b33bd0c77c7567caf1641f3aa48045f3e3b/libpipeline-08844b33bd0c77c7567caf1641f3aa48045f3e3b.tar.bz2')
- MissingTestRestrict: version 20250515: missing RESTRICT="!test? ( test )" with IUSE=test
- UnusedInherits: version 20250515: unused eclass: autotools
- VariableScope: version 20250515: variable 'EROOT' used in 'src_prepare' on line: 25

## lib-core/libatomic_ops
- MissingRemoteId: missing <remote-id type="github">ivmai/bdwgc</remote-id> (inferred from URI 'https://github.com/ivmai/bdwgc')
- BadDescription: version 20251128: over 80 chars in length

## lib-core/libxcrypt
- MissingRemoteId: missing <remote-id type="github">besser82/libxcrypt</remote-id> (inferred from URI 'https://github.com/besser82/libxcrypt')
- WhitespaceFound: version 20251122: ebuild has leading whitespace on lines: 30, 31

## lib-core/libseccomp
- MissingRemoteId: missing <remote-id type="github">seccomp/libseccomp</remote-id> (inferred from URI 'https://github.com/seccomp/libseccomp')

## lib-core/libxcrypt-compat
- MissingRemoteId: missing <remote-id type="github">besser82/libxcrypt</remote-id> (inferred from URI 'https://github.com/besser82/libxcrypt')

## lib-core/libxslt
- MissingRemoteId: missing <remote-id type="gnome-gitlab">GNOME/libxslt</remote-id> (inferred from URI 'https://gitlab.gnome.org/GNOME/libxslt/-/archive/35323d6a15f6e63c9919ddbc0abe64c90a0dd88a/libxslt-35323d6a15f6e63c9919ddbc0abe64c90a0dd88a.tar.bz2')

## lib-core/libpcre2
- MissingRemoteId: missing <remote-id type="github">zherczeg/sljit</remote-id> (inferred from URI 'https://github.com/zherczeg/sljit/archive/c2598a9c27f3eeb1eba4e4d139fca4643a10c340.tar.gz')
- BadFilename: version 20251203: bad filename: [ c2598a9c27f3eeb1eba4e4d139fca4643a10c340.tar.gz ]
- VariableShadowed: version 20251203: variable 'SRC_URI' may be shadowed, on lines: 12, 13

## lib-core/popt
- MissingRemoteId: missing <remote-id type="github">rpm-software-management/popt</remote-id> (inferred from URI 'https://github.com/rpm-software-management/popt/archive/63f096798125e96a0125faa477350f61901f3570.tar.gz')

## lib-core/musl-bsd
- MissingRemoteId: missing <remote-id type="github">jopamo/musl-bsd</remote-id> (inferred from URI 'https://github.com/jopamo/musl-bsd')
- MisplacedWeakBlocker: version 20251102: DEPEND: misplaced weak blocker: !lib-core/glibc

## lib-core/npth
- MissingRemoteId: missing <remote-id type="github">gpg/npth</remote-id> (inferred from URI 'https://github.com/gpg/npth')
- UnusedInherits: version 20250924: unused eclass: flag-o-matic

## lib-core/ncurses5-compat
- VariableOrderWrong: version 6.5.20251129: variable SRC_URI should occur before S
- VariableShadowed: version 6.5.20251129: variable 'S' may be shadowed, on lines: 11, 16
- VariableShadowed: version 6.5.20251129: variable 'SRC_URI' may be shadowed, on lines: 10, 15
- WhitespaceFound: version 6.5.20251129: ebuild has leading whitespace on lines: 31, 32, 33, 34, 35, 53, 54

## lib-core/netbsd-curses
- MissingRemoteId: missing <remote-id type="github">sabotage-linux/netbsd-curses</remote-id> (inferred from URI 'https://github.com/sabotage-linux/netbsd-curses')
- MisplacedWeakBlocker: version 20240116: DEPEND: misplaced weak blocker: !lib-core/ncurses
- VariableScope: version 20240116: variable 'ED' used in 'src_compile' on lines: 21, 24

## lib-core/ncurses
- VariableOrderWrong: version 6.5.20251129: variable SRC_URI should occur before S
- VariableShadowed: version 6.5.20251129: variable 'S' may be shadowed, on lines: 11, 16
- VariableShadowed: version 6.5.20251129: variable 'SRC_URI' may be shadowed, on lines: 10, 15
- WhitespaceFound: version 6.5.20251129: ebuild has leading whitespace on lines: 27, 30, 34, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 64, 66, 68, 69, 70, 71, 72, 73, 75, 77, 78

## lib-core/nettle
- IndirectInherits: version 3.10.20250626-r9: toolchain-funcs: indirect inherit usage: 'tc-is-static-only', line 35
- MissingTestRestrict: version 3.10.20250626-r9: missing RESTRICT="!test? ( test )" with IUSE=test
- UnusedInherits: version 3.10.20250626-r9: unused eclass: flag-o-matic

## lib-core/musl
- MissingRemoteId: missing <remote-id type="github">1g4-mirror/musl</remote-id> (inferred from URI 'https://github.com/1g4-mirror/musl/archive/1b76ff0767d01df72f692806ee5adee13c67ef88.tar.gz')
- DeprecatedInsinto: version 20251012: deprecated insinto usage (use doenvd or newenvd instead), line 86: insinto /etc/env.d
- UnknownUseFlags: version 20251012: unknown USE flag: 'libxcrypt'
- UnusedInherits: version 20251012: unused eclass: doins
- WhitespaceFound: version 20251012: ebuild has leading whitespace on line: 78

## lib-dev/boost-build
- MissingRemoteId: missing <remote-id type="sourceforge">boost</remote-id> (inferred from URI 'https://downloads.sourceforge.net/project/boost/boost/1.88.0/boost_1_88_0.tar.bz2')
- VariableOrderWrong: version 1.88.0: variable S should occur before KEYWORDS

## lib-core/libxml2
- MissingRemoteId: missing <remote-id type="gnome-gitlab">GNOME/libxml2</remote-id> (inferred from URI 'https://gitlab.gnome.org/GNOME/libxml2/-/archive/22f9d730898d2dfcc03a484e65e1f8fc3675225f/libxml2-22f9d730898d2dfcc03a484e65e1f8fc3675225f.tar.bz2')
- NonexistentDeps: version 20251015: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 20251015: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 20251015: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 20251015: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'
- UnnecessarySlashStrip: version 20251015: ${ROOT%/} unnecessary slash strip on line: 44
- UnquotedVariable: version 20251015: unquoted variable ROOT on line: 44
- VariableScope: version 20251015: variable 'ROOT' used in 'src_configure' on line: 44

## lib-core/zlib
- MissingRemoteId: missing <remote-id type="github">madler/zlib</remote-id> (inferred from URI 'https://github.com/madler/zlib/archive/5a82f71ed1dfc0bec044d9702463dbdf84ea3b71.tar.gz')
- UnknownUseFlags: version 20250218: unknown USE flag: 'minizip'

## lib-core/sqlite
- MissingRemoteId: missing <remote-id type="github">sqlite/sqlite</remote-id> (inferred from URI 'https://github.com/sqlite/sqlite/archive/98f976b21dfdd52b747a2eb607d573463f9b469a.tar.gz')
- UnknownUseFlags: version 3.50.20250922: unknown USE flags: 'editline', 'fts5', 'gcov', 'geopoly', 'json', 'math', 'memsys5', 'rtree', 'session', 'update-limit'
- WhitespaceFound: version 3.50.20250922: ebuild has leading whitespace on lines: 20, 23, 24, 25, 29, 30, 31, 32, 34, 35, 36, 37, 39, 40, 41, 42, 44, 45, 46, 47, 49, 50, 51, 52, 53, 55, 56, 57, 59, 60, 62, 63, 64, 66, 67, 68, 69, 71, 72, 73, 74, 76, 77, 78, 79, 81, 82, 83, 84, 85, 87, 88, 89, 90, 92, 93, 94, 96, 97, 98, 99, 100, 102, 103, 104, 105, 107, 108, 109, 110, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126, 127, 128, 129, 130, 131, 132, 133, 134

## lib-core/mpfr
- RedundantUriRename: version 4.2.20250528: redundant rename: https://gitlab.inria.fr/mpfr/mpfr/-/archive/116d2b3b13fdec2e7eb36359f08a7a88164015e8/mpfr-116d2b3b13fdec2e7eb36359f08a7a88164015e8.tar.bz2 -> mpfr-116d2b3b13fdec2e7eb36359f08a7a88164015e8.tar.bz2
- VariableOrderWrong: version 4.2.20250528: variable SRC_URI should occur before S
- VariableShadowed: version 4.2.20250528: variable 'S' may be shadowed, on lines: 14, 18
- VariableShadowed: version 4.2.20250528: variable 'SNAPSHOT' may be shadowed, on lines: 12, 16
- VariableShadowed: version 4.2.20250528: variable 'SRC_URI' may be shadowed, on lines: 13, 17

## lib-dev/double-conversion
- MissingRemoteId: missing <remote-id type="github">google/double-conversion</remote-id> (inferred from URI 'https://github.com/google/double-conversion')

## lib-core/readline
- MissingRemoteId: missing <remote-id type="github">1g4-mirror/readline</remote-id> (inferred from URI 'https://github.com/1g4-mirror/readline/archive/15970c431517a046099d8294c91d778b1da9b29d.tar.gz')
- DuplicateFunctionDefinition: version 8.3.20250711: multiple definitions of function 'src_configure' were found, on lines: 37, 65
- UnknownUseFlags: version 8.3.20250711: unknown USE flag: 'utils'

## lib-core/pam
- MissingRemoteId: missing <remote-id type="github">linux-pam/linux-pam</remote-id> (inferred from URI 'https://github.com/linux-pam/linux-pam')
- DoubleEmptyLine: version 20250908: ebuild has unneeded empty line on lines: 154, 155
- UnknownUseFlags: version 20250908: unknown USE flag: 'logind'
- UnusedInherits: version 20250908: unused eclass: flag-o-matic
- WhitespaceFound: version 20250908: ebuild has leading whitespace on lines: 30, 31, 33, 34, 36, 37, 39, 40, 42, 43, 45, 46, 48, 49, 51, 52, 54, 55, 57, 58, 60, 61, 63, 64, 66, 67, 69, 70, 72, 73, 75, 76, 78, 79, 81, 82, 84, 85, 87, 88, 90, 91, 93, 94, 96, 97, 99, 100, 102, 103, 105, 106, 108, 109, 111, 112, 114, 115, 117, 118, 120, 121, 123, 124, 126, 127, 129, 130, 132, 133, 135, 136, 138, 139, 141, 142, 144, 145, 147, 148, 150, 151

## lib-dev/eigen
- MissingRemoteId: missing <remote-id type="gitlab">libeigen/eigen</remote-id> (inferred from URI 'https://gitlab.com/libeigen/eigen')
- BadDescription: version 5.0.20251027: over 80 chars in length
- UnusedInherits: version 5.0.20251027: unused eclass: flag-o-matic

## dev-python/uvicorn
- MissingRemoteId: missing <remote-id type="github">Kludex/uvicorn</remote-id> (inferred from URI 'https://github.com/Kludex/uvicorn/')
- MissingRemoteId: missing <remote-id type="pypi">uvicorn</remote-id> (inferred from URI 'https://pypi.org/project/uvicorn/')
- NonexistentDeps: version 0.38.0: BDEPEND: nonexistent packages: >=dev-python/asgiref-3.4.0, >=dev-python/httptools-0.6.3, app-lang/python:3.11, app-lang/python:3.12, dev-python/a2wsgi, dev-python/python-dotenv, dev-python/watchfiles
- NonexistentDeps: version 0.38.0: RDEPEND: nonexistent packages: >=dev-python/asgiref-3.4.0, app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 0.38.0: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14, dev-python/a2wsgi[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], >=dev-python/asgiref-3.4.0[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], >=dev-python/httptools-0.6.3[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], dev-python/python-dotenv[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], dev-python/watchfiles[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)] ]
- NonsolvableDepsInStable: version 0.38.0: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14, >=dev-python/asgiref-3.4.0[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)] ]
- PythonMissingDeps: version 0.38.0: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 0.38.0: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14', 'test-rust'
- WhitespaceFound: version 0.38.0: ebuild has leading whitespace on line: 81

## lib-dev/ell
- MissingRemoteId: missing <remote-id type="github">1g4-mirror/ell</remote-id> (inferred from URI 'https://github.com/1g4-mirror/ell/archive/2e254f51bd82c28f8a2132d58a960fb6b0887f79.tar.gz')

## lib-dev/fast_float
- MissingRemoteId: missing <remote-id type="github">fastfloat/fast_float</remote-id> (inferred from URI 'https://github.com/fastfloat/fast_float')
- NonexistentDeps: version 20251123: BDEPEND: nonexistent package: dev-cpp/doctest
- NonsolvableDepsInStable: version 20251123: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ dev-cpp/doctest ]
- VariableShadowed: version 20251123: variable 'SRC_URI' may be shadowed, on lines: 9, 11

## lib-dev/fribidi
- MissingRemoteId: missing <remote-id type="github">fribidi/fribidi</remote-id> (inferred from URI 'https://github.com/fribidi/fribidi/archive/b28f43bd3e8e31a5967830f721bab218c1aa114c.tar.gz')

## lib-core/tzdb
- MissingRemoteId: missing <remote-id type="github">eggert/tz</remote-id> (inferred from URI 'https://github.com/eggert/tz/archive/7bfdf96c98cc226208ceef3b3b47519c83ad74e8.tar.gz')
- UnknownUseFlags: version 20251114: unknown USE flags: 'africa', 'antarctica', 'asia', 'atlantic', 'australasia', 'australia', 'backward', 'etcetera', 'europe', 'factory', 'indian', 'northamerica', 'pacific', 'southamerica', 'zic-fat'

## lib-dev/json-c
- MissingRemoteId: missing <remote-id type="github">json-c/json-c</remote-id> (inferred from URI 'https://github.com/json-c/json-c/wiki')

## lib-dev/jemalloc
- MissingRemoteId: missing <remote-id type="github">jemalloc/jemalloc</remote-id> (inferred from URI 'https://github.com/jemalloc/jemalloc')
- UnknownUseFlags: version 20250602: unknown USE flags: 'lazy-lock', 'stats', 'xmalloc'

## lib-dev/dbus-glib
- MissingRemoteId: missing <remote-id type="freedesktop-gitlab">dbus/dbus-glib</remote-id> (inferred from URI 'https://gitlab.freedesktop.org/dbus/dbus-glib/-/archive/8c1e96ffcbf4f5d8fb576224ca3abda052131013/dbus-glib-8c1e96ffcbf4f5d8fb576224ca3abda052131013.tar.bz2')
- MissingTestRestrict: version 20250313: missing RESTRICT="!test? ( test )" with IUSE=test
- RedundantUriRename: version 20250313: redundant rename: https://gitlab.freedesktop.org/dbus/dbus-glib/-/archive/8c1e96ffcbf4f5d8fb576224ca3abda052131013/dbus-glib-8c1e96ffcbf4f5d8fb576224ca3abda052131013.tar.bz2 -> dbus-glib-8c1e96ffcbf4f5d8fb576224ca3abda052131013.tar.bz2

## lib-dev/jsoncpp
- MissingRemoteId: missing <remote-id type="github">open-source-parsers/jsoncpp</remote-id> (inferred from URI 'https://github.com/open-source-parsers/jsoncpp')

## lib-dev/libcbor
- MissingRemoteId: missing <remote-id type="github">pjk/libcbor</remote-id> (inferred from URI 'https://github.com/pjk/libcbor')

## lib-dev/libbsd
- MissingRemoteId: missing <remote-id type="github">guillemj/libbsd</remote-id> (inferred from URI 'https://github.com/guillemj/libbsd/archive/22fddb16f8430d64b82a1ea08602be5e61ac203b.tar.gz')

## lib-dev/lapack
- MissingRemoteId: missing <remote-id type="github">Reference-LAPACK/lapack</remote-id> (inferred from URI 'https://github.com/Reference-LAPACK/lapack/archive/67f9279da4d004b3e998d6fb63ef75c4fbbf7355.tar.gz')
- IndirectInherits: version 20251203: flag-o-matic: indirect inherit usage: 'append-flags -ffat-lto-objects', line 18

## lib-dev/icu
- MissingRemoteId: missing <remote-id type="github">unicode-org/icu</remote-id> (inferred from URI 'https://github.com/unicode-org/icu/archive/9f1c57412afbedb180941a3739c5a460beff24f4.tar.gz')

## lib-dev/libmd
- MissingRemoteId: missing <remote-id type="github">guillemj/libmd</remote-id> (inferred from URI 'https://github.com/guillemj/libmd/archive/d5b8e853989a73f8fff9dc4e00dccd0b691b84f9.tar.gz')

## lib-dev/libconfig
- MissingRemoteId: missing <remote-id type="github">hyperrealm/libconfig</remote-id> (inferred from URI 'https://github.com/hyperrealm/libconfig/archive/02d9a6bda1165a3afc2c5571f12404d6d0e73557.tar.gz')
- UnknownUseFlags: version 20251109: unknown USE flag: 'cxx'

## lib-dev/libaio
- MissingRemoteId: missing <remote-id type="github">1g4-mirror/libaio</remote-id> (inferred from URI 'https://github.com/1g4-mirror/libaio/archive/b8eadc9f89e8f7ab0338eacda9f98a6caea76883.tar.gz')
- DoubleEmptyLine: version 20220602: ebuild has unneeded empty line on line: 13
- MissingTestRestrict: version 20220602: missing RESTRICT="!test? ( test )" with IUSE=test

## lib-dev/json-glib
- MissingRemoteId: missing <remote-id type="gnome-gitlab">GNOME/json-glib</remote-id> (inferred from URI 'https://gitlab.gnome.org/GNOME/json-glib/-/archive/65ffd51a364ea21d92705cfb8446bcab5904f2a7/json-glib-65ffd51a364ea21d92705cfb8446bcab5904f2a7.tar.bz2')
- RedundantUriRename: version 20251021: redundant rename: https://gitlab.gnome.org/GNOME/json-glib/-/archive/65ffd51a364ea21d92705cfb8446bcab5904f2a7/json-glib-65ffd51a364ea21d92705cfb8446bcab5904f2a7.tar.bz2 -> json-glib-65ffd51a364ea21d92705cfb8446bcab5904f2a7.tar.bz2

## lib-dev/libtasn1
- MissingRemoteId: missing <remote-id type="gitlab">gnutls/libtasn1</remote-id> (inferred from URI 'https://gitlab.com/gnutls/libtasn1/-/archive/a3d48c2d9845e54e099769242366d47c09c8464e/libtasn1-a3d48c2d9845e54e099769242366d47c09c8464e.tar.bz2')
- UnknownUseFlags: version 20250824: unknown USE flag: 'valgrind'
- VariableScope: version 20250824: variable 'EROOT' used in 'src_prepare' on line: 20

## lib-dev/check
- MissingRemoteId: missing <remote-id type="github">libcheck/check</remote-id> (inferred from URI 'https://github.com/libcheck/check')

## lib-dev/libsass
- MissingRemoteId: missing <remote-id type="github">sass/libsass</remote-id> (inferred from URI 'https://github.com/sass/libsass')

## dev-python/yarl
- MissingRemoteId: missing <remote-id type="github">aio-libs/yarl</remote-id> (inferred from URI 'https://github.com/aio-libs/yarl/')
- MissingRemoteId: missing <remote-id type="pypi">yarl</remote-id> (inferred from URI 'https://pypi.org/project/yarl/')
- IndirectInherits: version 1.22.0: flag-o-matic: indirect inherit usage: 'filter-flags -Wl,-z,defs', line 39
- NonexistentDeps: version 1.22.0: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 1.22.0: DEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 1.22.0: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 1.22.0: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 1.22.0: nonsolvable depset(depend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 1.22.0: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 1.22.0: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 1.22.0: unknown USE flags: 'native-extensions', 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## lib-dev/libtommath
- MissingRemoteId: missing <remote-id type="github">libtom/libtommath</remote-id> (inferred from URI 'https://github.com/libtom/libtommath')
- UnusedInherits: version 20250611: unused eclass: flag-o-matic

## lib-dev/libevent
- MissingRemoteId: missing <remote-id type="github">libevent/libevent</remote-id> (inferred from URI 'https://github.com/libevent/libevent/archive/a994a52d5373d6284b27576efa617aff2baa7bd3.tar.gz')
- NonexistentDeps: version 20251122: DEPEND: nonexistent package: lib-net/mbedtls
- NonsolvableDepsInStable: version 20251122: nonsolvable depset(depend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ lib-net/mbedtls ]
- UnknownUseFlags: version 20251122: unknown USE flag: 'mbedtls'

## lib-dev/libutf8proc
- MissingRemoteId: missing <remote-id type="github">JuliaStrings/utf8proc</remote-id> (inferred from URI 'https://github.com/JuliaStrings/utf8proc')

## lib-dev/libusb
- MissingRemoteId: missing <remote-id type="github">libusb/libusb</remote-id> (inferred from URI 'https://github.com/libusb/libusb')
- MissingTestRestrict: version 20251110: missing RESTRICT="!test? ( test )" with IUSE=test

## lib-dev/tinyxml2
- MissingRemoteId: missing <remote-id type="github">leethomason/tinyxml2</remote-id> (inferred from URI 'https://github.com/leethomason/tinyxml2/')
- MissingTestRestrict: version 11.0.0: missing RESTRICT="!test? ( test )" with IUSE=test

## lib-dev/libunwind
- MissingRemoteId: missing <remote-id type="github">libunwind/libunwind</remote-id> (inferred from URI 'https://github.com/libunwind/libunwind/archive/7bda80a564cddc5b215a84509026030cf16dfd94.tar.gz')
- MissingRemoteId: missing <remote-id type="savannah-nongnu">libunwind</remote-id> (inferred from URI 'https://savannah.nongnu.org/projects/libunwind')
- UnknownUseFlags: version 1.8.20250904: unknown USE flag: 'debug-frame'

## lib-dev/maxminddb
- MissingRemoteId: missing <remote-id type="github">maxmind/libmaxminddb</remote-id> (inferred from URI 'https://github.com/maxmind/libmaxminddb')

## lib-dev/slang
- BadDescription: version 2.3.3: over 80 chars in length
- TrailingEmptyLine: version 2.3.3: ebuild has trailing blank line(s)

## lib-dev/libyaml
- MissingRemoteId: missing <remote-id type="github">yaml/libyaml</remote-id> (inferred from URI 'https://github.com/yaml/libyaml')

## lib-dev/liblinear
- MissingRemoteId: missing <remote-id type="github">cjlin1/liblinear</remote-id> (inferred from URI 'https://github.com/cjlin1/liblinear')
- ExcessiveLineLength: version 20250524: excessive line length (over 120 characters) on line: 22
- TrailingEmptyLine: version 20250524: ebuild has trailing blank line(s)

## lib-dev/boost
- MissingRemoteId: missing <remote-id type="sourceforge">boost</remote-id> (inferred from URI 'https://downloads.sourceforge.net/project/boost/boost/1.88.0/boost_1_88_0.tar.bz2')
- UnknownUseFlags: version 1.88.0: unknown USE flags: 'context', 'tools'
- VariableOrderWrong: version 1.88.0: variable S should occur before IUSE
- VariableScope: version 1.88.0: variable 'ED' used in 'src_configure' on line: 50

## lib-dev/rapidjson
- MissingRemoteId: missing <remote-id type="github">Tencent/rapidjson</remote-id> (inferred from URI 'https://github.com/Tencent/rapidjson/archive/24b5e7a8b27f42fa16b96fc70aade9106cf7102f.tar.gz')
- MissingTestRestrict: version 20250205: missing RESTRICT="!test? ( test )" with IUSE=test
- VariableOrderWrong: version 20250205: variable SLOT should occur before IUSE

## lib-dev/protobuf
- MissingRemoteId: missing <remote-id type="github">protocolbuffers/protobuf</remote-id> (inferred from URI 'https://github.com/protocolbuffers/protobuf/archive/93a4005ce76fa510922fef1fed83e187c6ce2dfd.tar.gz')

## lib-dev/libev
- MissingRemoteId: missing <remote-id type="github">jopamo/libev</remote-id> (inferred from URI 'https://github.com/jopamo/libev')

## lib-dev/uthash
- MissingRemoteId: missing <remote-id type="github">troydhanson/uthash</remote-id> (inferred from URI 'https://github.com/troydhanson/uthash/archive/af6e637f19c102167fb914b9ebcc171389270b48.tar.gz')

## lib-dev/nspr
- UnnecessarySlashStrip: version 20251111: ${ED%/} unnecessary slash strip on lines: 68, 74, 79

## lib-misc/gumbo-parser
- MissingRemoteId: missing <remote-id type="github">google/gumbo-parser</remote-id> (inferred from URI 'https://github.com/google/gumbo-parser')

## lib-misc/http-parser
- MissingRemoteId: missing <remote-id type="github">nodejs/http-parser</remote-id> (inferred from URI 'https://github.com/nodejs/http-parser')

## lib-misc/inih
- MissingRemoteId: missing <remote-id type="github">benhoyt/inih</remote-id> (inferred from URI 'https://github.com/benhoyt/inih')

## lib-dev/libuv
- MissingRemoteId: missing <remote-id type="github">libuv/libuv</remote-id> (inferred from URI 'https://github.com/libuv/libuv')

## lib-misc/cppzmq
- MissingRemoteId: missing <remote-id type="github">zeromq/cppzmq</remote-id> (inferred from URI 'https://github.com/zeromq/cppzmq')
- ExcessiveLineLength: version 20250922: excessive line length (over 120 characters) on line: 24

## lib-misc/libiscsi
- MissingRemoteId: missing <remote-id type="github">sahlberg/libiscsi</remote-id> (inferred from URI 'https://github.com/sahlberg/libiscsi')

## lib-misc/czmq
- MissingRemoteId: missing <remote-id type="github">zeromq/czmq</remote-id> (inferred from URI 'https://github.com/zeromq/czmq/archive/f22f6572fdf63d344e022b956a137ce084fa5d8b.tar.gz')

## lib-misc/libmesode
- MissingRemoteId: missing <remote-id type="github">profanity-im/libmesode</remote-id> (inferred from URI 'https://github.com/profanity-im/libmesode')

## dev-python/sphinx
- MissingRemoteId: missing <remote-id type="github">sphinx-doc/sphinx</remote-id> (inferred from URI 'https://github.com/sphinx-doc/sphinx/')
- MissingRemoteId: missing <remote-id type="pypi">Sphinx</remote-id> (inferred from URI 'https://pypi.org/project/Sphinx/')
- EPyTestPluginsSuggestion: version 8.2.3-r2: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- NonexistentDeps: version 8.2.3-r2: BDEPEND: nonexistent packages: <dev-py/docutils-0.23, >=dev-python/roman-numerals-py-1.0.0, >=dev-python/snowballstemmer-2.2, >=dev-python/sphinxcontrib-applehelp-1.0.7, >=dev-python/sphinxcontrib-devhelp-1.0.6, >=dev-python/sphinxcontrib-htmlhelp-2.0.6, >=dev-python/sphinxcontrib-jsmath-1.0.1, >=dev-python/sphinxcontrib-qthelp-1.0.6, >=dev-python/sphinxcontrib-serializinghtml-1.1.9, app-lang/python:3.11, app-lang/python:3.12, app-text/dvipng, dev-python/pytest-rerunfailures, dev-python/sphinxcontrib-websupport, dev-texlive/texlive-fontsextra, dev-texlive/texlive-latexextra, dev-texlive/texlive-luatex, media-gfx/graphviz, virtual/imagemagick-tools
- NonexistentDeps: version 8.2.3-r2: RDEPEND: nonexistent packages: <dev-py/docutils-0.23, >=dev-python/roman-numerals-py-1.0.0, >=dev-python/snowballstemmer-2.2, >=dev-python/sphinxcontrib-applehelp-1.0.7, >=dev-python/sphinxcontrib-devhelp-1.0.6, >=dev-python/sphinxcontrib-htmlhelp-2.0.6, >=dev-python/sphinxcontrib-jsmath-1.0.1, >=dev-python/sphinxcontrib-qthelp-1.0.6, >=dev-python/sphinxcontrib-serializinghtml-1.1.9, app-lang/python:3.11, app-lang/python:3.12, app-text/dvipng, dev-texlive/texlive-latexextra, dev-texlive/texlive-luatex
- NonsolvableDepsInStable: version 8.2.3-r2: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11[threads(+)], app-lang/python:3.12[threads(+)], app-lang/python:3.14[threads(+)], app-text/dvipng, <dev-py/docutils-0.23[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], dev-python/pytest-rerunfailures[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], >=dev-python/roman-numerals-py-1.0.0[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], >=dev-python/snowballstemmer-2.2[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], >=dev-python/sphinxcontrib-applehelp-1.0.7[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], >=dev-python/sphinxcontrib-devhelp-1.0.6[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], >=dev-python/sphinxcontrib-htmlhelp-2.0.6[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], >=dev-python/sphinxcontrib-jsmath-1.0.1[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], >=dev-python/sphinxcontrib-qthelp-1.0.6[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], >=dev-python/sphinxcontrib-serializinghtml-1.1.9[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], dev-python/sphinxcontrib-websupport[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], dev-texlive/texlive-fontsextra, dev-texlive/texlive-latexextra, dev-texlive/texlive-luatex, media-gfx/graphviz, virtual/imagemagick-tools[jpeg,png,svg] ]
- NonsolvableDepsInStable: version 8.2.3-r2: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11[threads(+)], app-lang/python:3.12[threads(+)], app-lang/python:3.14[threads(+)], app-text/dvipng, <dev-py/docutils-0.23[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], >=dev-python/roman-numerals-py-1.0.0[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], >=dev-python/snowballstemmer-2.2[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], >=dev-python/sphinxcontrib-applehelp-1.0.7[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], >=dev-python/sphinxcontrib-devhelp-1.0.6[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], >=dev-python/sphinxcontrib-htmlhelp-2.0.6[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], >=dev-python/sphinxcontrib-jsmath-1.0.1[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], >=dev-python/sphinxcontrib-qthelp-1.0.6[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], >=dev-python/sphinxcontrib-serializinghtml-1.1.9[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], dev-texlive/texlive-latexextra, dev-texlive/texlive-luatex ]
- PythonMissingDeps: version 8.2.3-r2: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 8.2.3-r2: unknown USE flags: 'latex', 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## lib-misc/rpcsvc-proto
- MissingRemoteId: missing <remote-id type="github">thkukuk/rpcsvc-proto</remote-id> (inferred from URI 'https://github.com/thkukuk/rpcsvc-proto')

## lib-dev/nghttp2
- MissingRemoteId: missing <remote-id type="github">nghttp2/nghttp2</remote-id> (inferred from URI 'https://github.com/nghttp2/nghttp2/archive/0c570c823d85aec0c1724bf5ea78e3df094077dd.tar.gz')
- MissingTestRestrict: version 20251201: missing RESTRICT="!test? ( test )" with IUSE=test
- NonexistentDeps: version 20251201: DEPEND: nonexistent package: >=app-dev/cunit-2.1
- NonsolvableDepsInStable: version 20251201: nonsolvable depset(depend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ >=app-dev/cunit-2.1 ]
- UnknownUseFlags: version 20251201: unknown USE flags: 'hpack-tools', 'jemalloc', 'utils'

## lib-dev/tree-sitter
- MissingRemoteId: missing <remote-id type="github">tree-sitter/tree-sitter</remote-id> (inferred from URI 'https://github.com/tree-sitter/tree-sitter')

## lib-misc/libxdg-base
- MissingRemoteId: missing <remote-id type="github">devnev/libxdg-basedir</remote-id> (inferred from URI 'https://github.com/devnev/libxdg-basedir/archive/b978568d1b3ee04e8197f23ca4e3abdd372f85e1.tar.gz')

## lib-misc/libtorrent
- IndirectInherits: version 2.0.9999: flag-o-matic: indirect inherit usage: 'append-cxxflags -lboost_system', line 26
- VisibleVcsPkg: version 2.0.9999: VCS version visible for KEYWORDS="amd64", profile core/amd64/glibc (16 total)

## lib-dev/gobject-introspection
- MissingRemoteId: missing <remote-id type="gnome-gitlab">GNOME/gobject-introspection</remote-id> (inferred from URI 'https://gitlab.gnome.org/GNOME/gobject-introspection/-/archive/b8c3ff23b6c121433faca19ddf61fe8dc72a8930/gobject-introspection-b8c3ff23b6c121433faca19ddf61fe8dc72a8930.tar.bz2')
- NonexistentDeps: version 9999: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 9999: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 9999: missing RDEPEND="${PYTHON_DEPS}"
- PythonMissingRequiredUse: version 9999: missing REQUIRED_USE="${PYTHON_REQUIRED_USE}"
- UnknownUseFlags: version 9999: unknown USE flags: 'python_single_target_python3_11', 'python_single_target_python3_12', 'python_single_target_python3_13', 'python_single_target_python3_14'
- VisibleVcsPkg: version 9999: VCS version visible for KEYWORDS="amd64", profile core/amd64/glibc (16 total)
- NonexistentDeps: version 20230916-r9: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- PythonMissingDeps: version 20230916-r9: missing RDEPEND="${PYTHON_DEPS}"
- PythonMissingRequiredUse: version 20230916-r9: missing REQUIRED_USE="${PYTHON_REQUIRED_USE}"
- RedundantUriRename: version 20230916-r9: redundant rename: https://gitlab.gnome.org/GNOME/gobject-introspection/-/archive/b8c3ff23b6c121433faca19ddf61fe8dc72a8930/gobject-introspection-b8c3ff23b6c121433faca19ddf61fe8dc72a8930.tar.bz2 -> gobject-introspection-b8c3ff23b6c121433faca19ddf61fe8dc72a8930.tar.bz2
- UnknownUseFlags: version 20230916-r9: unknown USE flags: 'python_single_target_python3_11', 'python_single_target_python3_12', 'python_single_target_python3_13', 'python_single_target_python3_14'

## lib-misc/mbedtls
- VisibleVcsPkg: version 3.6.9999: VCS version visible for KEYWORDS="amd64", profile core/amd64/glibc (16 total)

## lib-misc/xxhash
- MissingRemoteId: missing <remote-id type="github">Cyan4973/xxHash</remote-id> (inferred from URI 'https://github.com/Cyan4973/xxHash/archive/7b2c67f3d1d940aca00a4df895b7f97062dd8cc4.tar.gz')

## lib-net/avahi
- MissingRemoteId: missing <remote-id type="github">avahi/avahi</remote-id> (inferred from URI 'https://github.com/avahi/avahi/archive/f8e6e7c74f9e08c8446fc827be674298328d2d2c.tar.gz')
- DoubleEmptyLine: version 20251203: ebuild has unneeded empty line on line: 44

## lib-net/c-ares
- MissingRemoteId: missing <remote-id type="github">c-ares/c-ares</remote-id> (inferred from URI 'https://github.com/c-ares/c-ares/archive/3df013511b4bc6e85763c3d5a06ecfa6fc8782a8.tar.gz')

## lib-misc/libssh2
- MissingRemoteId: missing <remote-id type="github">libssh2/libssh2</remote-id> (inferred from URI 'https://github.com/libssh2/libssh2/archive/c10cb2449c82c4cd8ae519cf1b34b56396eafa96.tar.gz')
- MissingTestRestrict: version 20251203: missing RESTRICT="!test? ( test )" with IUSE=test
- UnknownUseFlags: version 20251203: unknown USE flag: 'gcrypt'

## lib-misc/libzmq
- MissingRemoteId: missing <remote-id type="github">zeromq/libzmq</remote-id> (inferred from URI 'https://github.com/zeromq/libzmq/archive/7a7bfa10e6b0e99210ed9397369b59f9e69cef8e.tar.gz')
- MissingTestRestrict: version 20250910: missing RESTRICT="!test? ( test )" with IUSE=test
- NonexistentDeps: version 20250910: DEPEND: nonexistent package: lib-util/libunwind
- NonsolvableDepsInStable: version 20250910: nonsolvable depset(depend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ lib-util/libunwind ]
- UnknownUseFlags: version 20250910: unknown USE flags: 'libunwind', 'sodium'

## lib-misc/zmqpp
- MissingRemoteId: missing <remote-id type="github">zeromq/zmqpp</remote-id> (inferred from URI 'https://github.com/zeromq/zmqpp')
- VariableScope: version 20210709: variable 'ED' used in 'src_configure' on line: 31

## lib-core/glibc
- MissingRemoteId: missing <remote-id type="github">1g4-mirror/glibc</remote-id> (inferred from URI 'https://github.com/1g4-mirror/glibc/archive/f8cdc03e1e416ab16717b47f946c033de2d9494f.tar.gz')
- DeprecatedInsinto: version 2.40.20251121: deprecated insinto usage (use systemd_dounit or systemd_newunit from systemd.eclass instead), line 256: insinto /usr/lib/systemd/system
- MissingInherits: version 2.40.20251121: doins: missing inherit usage: 'newtmpfiles nscd/nscd.tmpfiles nscd.conf', line 261
- TrailingEmptyLine: version 2.40.20251121: ebuild has trailing blank line(s)
- UnknownUseFlags: version 2.40.20251121: unknown USE flags: 'nscd', 'profile', 'static-pie'
- WhitespaceFound: version 2.40.20251121: ebuild has leading whitespace on line: 161
- DeprecatedInsinto: version 2.41.20251121: deprecated insinto usage (use systemd_dounit or systemd_newunit from systemd.eclass instead), line 208: insinto /usr/lib/systemd/system
- MissingInherits: version 2.41.20251121: doins: missing inherit usage: 'newtmpfiles nscd/nscd.tmpfiles nscd.conf', line 213
- UnknownUseFlags: version 2.41.20251121: unknown USE flags: 'nscd', 'profile', 'static-pie'

## lib-net/libidn2
- MissingRemoteId: missing <remote-id type="github">jopamo/libidn2</remote-id> (inferred from URI 'https://github.com/jopamo/libidn2/archive/192e61180a0446e2066a6cc550afd934e79ba8b8.tar.gz')

## lib-net/libbpf
- MissingRemoteId: missing <remote-id type="github">libbpf/libbpf</remote-id> (inferred from URI 'https://github.com/libbpf/libbpf')

## lib-net/libgit2
- MissingRemoteId: missing <remote-id type="github">libgit2/libgit2</remote-id> (inferred from URI 'https://github.com/libgit2/libgit2/archive/58d9363f02f1fa39e46d49b604f27008e75b72f2.tar.gz')

## lib-net/libmnl
- MissingRemoteId: missing <remote-id type="github">1g4-mirror/libmnl</remote-id> (inferred from URI 'https://github.com/1g4-mirror/libmnl/archive/54dea548d796653534645c6e3c8577eaf7d77411.tar.gz')

## lib-dev/nss
- MissingRemoteId: missing <remote-id type="github">nss-dev/nss</remote-id> (inferred from URI 'https://github.com/nss-dev/nss/archive/8c7bdebef8325c782fc5e1cce9a1940d326f1fb0.tar.gz')
- UnknownUseFlags: version 20251203: unknown USE flag: 'utils'
- UnnecessarySlashStrip: version 20251203: ${ED%/} unnecessary slash strip on lines: 199, 202, 211, 213, 219, 253

## lib-net/libnetfilter_log
- MissingRemoteId: missing <remote-id type="github">1g4-mirror/libnetfilter_log</remote-id> (inferred from URI 'https://github.com/1g4-mirror/libnetfilter_log/archive/248401076c063473314a589e16fcadaa294848a5.tar.gz')

## lib-net/libpsl
- MissingRemoteId: missing <remote-id type="github">jopamo/libpsl</remote-id> (inferred from URI 'https://github.com/jopamo/libpsl')

## lib-net/libnftnl
- MissingRemoteId: missing <remote-id type="github">1g4-mirror/libnftnl</remote-id> (inferred from URI 'https://github.com/1g4-mirror/libnftnl/archive/5a54b99859fd52d8c7e866b57f6d8fac3e20a78f.tar.gz')

## lib-net/gnutls
- MissingTestRestrict: version 3.8.10: missing RESTRICT="!test? ( test )" with IUSE=test
- NonexistentDeps: version 3.8.10: DEPEND: nonexistent package: lib-net/unbound
- NonsolvableDepsInStable: version 3.8.10: nonsolvable depset(depend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ lib-net/unbound ]
- UnknownUseFlags: version 3.8.10: unknown USE flags: 'brotli', 'cxx', 'dane', 'tools', 'valgrind'
- VariableShadowed: version 3.8.10: variable 'SRC_URI' may be shadowed, on lines: 7, 8

## dev-python/virtualenv
- MissingRemoteId: missing <remote-id type="github">pypa/virtualenv</remote-id> (inferred from URI 'https://github.com/pypa/virtualenv/')
- MissingRemoteId: missing <remote-id type="pypi">virtualenv</remote-id> (inferred from URI 'https://pypi.org/project/virtualenv/')
- NonexistentDeps: version 20.35.4-r1: BDEPEND: nonexistent packages: >=dev-python/pytest-mock-3.6.1, app-lang/python:3.11, app-lang/python:3.12, dev-python/ensurepip-wheel, dev-python/pytest-rerunfailures, dev-python/time-machine
- NonexistentDeps: version 20.35.4-r1: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12, dev-python/ensurepip-wheel
- NonsolvableDepsInStable: version 20.35.4-r1: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14, dev-python/ensurepip-wheel, >=dev-python/pytest-mock-3.6.1[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], dev-python/pytest-rerunfailures[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], dev-python/time-machine[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)] ]
- NonsolvableDepsInStable: version 20.35.4-r1: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14, dev-python/ensurepip-wheel ]
- PythonMissingDeps: version 20.35.4-r1: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 20.35.4-r1: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## lib-dev/libsigc++
- MissingRemoteId: missing <remote-id type="github">libsigcplusplus/libsigcplusplus</remote-id> (inferred from URI 'https://github.com/libsigcplusplus/libsigcplusplus/archive/94f1b9f48d845323501e82a5c787fbe2beccb01c.tar.gz')

## lib-net/libtirpc
- MissingRemoteId: missing <remote-id type="github">1g4-mirror/libtirpc</remote-id> (inferred from URI 'https://github.com/1g4-mirror/libtirpc/archive/240ee6c774729c9c24812aa8912f1fcf8996b162.tar.gz')

## lib-dev/tree-sitter-bash
- MissingRemoteId: missing <remote-id type="github">tree-sitter/tree-sitter-bash</remote-id> (inferred from URI 'https://github.com/tree-sitter/tree-sitter-bash')
- NonexistentDeps: version 20251202: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12, dev-util/tree-sitter-cli
- NonexistentDeps: version 20251202: DEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 20251202: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 20251202: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14, dev-util/tree-sitter-cli ]
- NonsolvableDepsInStable: version 20251202: nonsolvable depset(depend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 20251202: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 20251202: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 20251202: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## lib-net/userspace-rcu
- MissingRemoteId: missing <remote-id type="github">urcu/userspace-rcu</remote-id> (inferred from URI 'https://github.com/urcu/userspace-rcu/archive/91b6c67ef0478f7193485a02e4d5064413aa3029.tar.gz')

## lib-net/libnsl
- MissingRemoteId: missing <remote-id type="github">thkukuk/libnsl</remote-id> (inferred from URI 'https://github.com/thkukuk/libnsl')
- VariableOrderWrong: version 2.0.1: variable LICENSE should occur before SLOT

## lib-print/cups-filters
- MissingRemoteId: missing <remote-id type="github">OpenPrinting/cups-filters</remote-id> (inferred from URI 'https://github.com/OpenPrinting/cups-filters/releases/download/2.0.1/cups-filters-2.0.1.tar.xz')
- UnknownUseFlags: version 2.0.1: unknown USE flag: 'foomatic'

## lib-net/slirp
- MissingRemoteId: missing <remote-id type="freedesktop-gitlab">slirp/libslirp</remote-id> (inferred from URI 'https://gitlab.freedesktop.org/slirp/libslirp')
- RedundantUriRename: version 4.7.0: redundant rename: https://gitlab.freedesktop.org/slirp/libslirp/-/archive/129077f9870426d1b7b3a8239d8b5a50bee017b4/libslirp-129077f9870426d1b7b3a8239d8b5a50bee017b4.tar.bz2 -> libslirp-129077f9870426d1b7b3a8239d8b5a50bee017b4.tar.bz2
- UnknownUseFlags: version 4.7.0: unknown USE flag: 'valgrind'

## lib-util/libevdev
- MissingRemoteId: missing <remote-id type="freedesktop-gitlab">libevdev/libevdev</remote-id> (inferred from URI 'https://gitlab.freedesktop.org/libevdev/libevdev/-/archive/139b58e135184f66a35c2401771f3d8134f097ad/libevdev-139b58e135184f66a35c2401771f3d8134f097ad.tar.bz2')
- RedundantUriRename: version 20251201: redundant rename: https://gitlab.freedesktop.org/libevdev/libevdev/-/archive/139b58e135184f66a35c2401771f3d8134f097ad/libevdev-139b58e135184f66a35c2401771f3d8134f097ad.tar.bz2 -> libevdev-139b58e135184f66a35c2401771f3d8134f097ad.tar.bz2

## lib-util/libverto
- MissingRemoteId: missing <remote-id type="github">latchset/libverto</remote-id> (inferred from URI 'https://github.com/latchset/libverto')

## lib-util/libsodium
- MissingRemoteId: missing <remote-id type="github">jedisct1/libsodium</remote-id> (inferred from URI 'https://github.com/jedisct1/libsodium')
- UnknownUseFlags: version 20251126: unknown USE flags: 'asm', 'minimal', 'urandom'

## lib-net/libnetfilter_conntrack
- MissingRemoteId: missing <remote-id type="github">1g4-mirror/libnetfilter_conntrack</remote-id> (inferred from URI 'https://github.com/1g4-mirror/libnetfilter_conntrack/archive/7e416f3c6217687ab35f07e14bd268109d5be4c3.tar.gz')

## lib-net/openssl
- MissingRemoteId: missing <remote-id type="github">openssl/openssl</remote-id> (inferred from URI 'https://github.com/openssl/openssl/archive/3f8a5a4fdd28654dfe981ebd43d3dc1128a198c9.tar.gz')
- DoubleEmptyLine: version 3.0.20251203: ebuild has unneeded empty line on line: 58
- WhitespaceFound: version 3.0.20251203: ebuild has leading whitespace on lines: 51, 52, 53, 54, 55, 56

## lib-util/libb2
- MissingRemoteId: missing <remote-id type="github">BLAKE2/libb2</remote-id> (inferred from URI 'https://github.com/BLAKE2/libb2')
- UnknownUseFlags: version 20230514: unknown USE flag: 'native-cflags'

## lib-print/libppd
- MissingRemoteId: missing <remote-id type="github">OpenPrinting/libppd</remote-id> (inferred from URI 'https://github.com/OpenPrinting/libppd')
- RequiredUseDefaults: version 2.1.1: profile: 'core/amd64/glibc' (8 total) failed REQUIRED_USE: ( postscript || poppler )
- UnknownKeywords: version 2.1.1: unknown KEYWORDS: 'arm', 'ppc', 'ppc64', 'sparc', 'x86', '~hppa', '~ia64', '~loong', '~riscv'
- UnknownUseFlags: version 2.1.1: unknown USE flags: 'poppler', 'postscript'
- VariableOrderWrong: version 2.1.1: variable KEYWORDS should occur before IUSE

## lib-net/libpcap
- MissingRemoteId: missing <remote-id type="github">the-tcpdump-group/libpcap</remote-id> (inferred from URI 'https://github.com/the-tcpdump-group/libpcap/archive/052ccdceda45906622dd9881ada87fc1587eeb00.tar.gz')
- UnknownUseFlags: version 1.10.20251119: unknown USE flag: 'netlink'

## virtual/ssl
- NonexistentDeps: version 0: RDEPEND: nonexistent package: lib-net/libressl
- NonsolvableDepsInStable: version 0: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ lib-net/libressl ]
- UnknownUseFlags: version 0: unknown USE flag: 'libressl'

## virtual/curses
- UnknownUseFlags: version 0: unknown USE flag: 'netbsd-curses'

## xgui-app/alacritty
- MissingRemoteId: missing <remote-id type="github">alacritty/alacritty</remote-id> (inferred from URI 'https://github.com/alacritty/alacritty')

## xgui-app/1t
- MissingRemoteId: missing <remote-id type="github">jopamo/1t</remote-id> (inferred from URI 'https://github.com/jopamo/1t')
- NonexistentDeps: version 9999: IDEPEND: nonexistent package: app-dev/desktop-file-utils
- NonsolvableDepsInStable: version 9999: nonsolvable depset(idepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-dev/desktop-file-utils ]
- VisibleVcsPkg: version 9999: VCS version visible for KEYWORDS="amd64", profile core/amd64/glibc (16 total)

## lib-net/libnl
- MissingRemoteId: missing <remote-id type="github">thom311/libnl</remote-id> (inferred from URI 'https://github.com/thom311/libnl')
- DistutilsNonPEP517Build: version 20251103: uses deprecated non-PEP517 build mode, please switch to DISTUTILS_USE_PEP517=...
- NonexistentDeps: version 20251103: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 20251103: DEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 20251103: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 20251103: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 20251103: nonsolvable depset(depend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 20251103: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 20251103: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 20251103: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14', 'utils'

## lib-util/glib
- UnknownUseFlags: version 2.86.9999: unknown USE flag: 'introspection'
- VisibleVcsPkg: version 2.86.9999: VCS version visible for KEYWORDS="amd64", profile core/amd64/glibc (16 total)
- WhitespaceFound: version 2.86.9999: ebuild has leading whitespace on lines: 33, 34, 35

## xgui-app/libdisplay-info
- MissingRemoteId: missing <remote-id type="freedesktop-gitlab">emersion/libdisplay-info</remote-id> (inferred from URI 'https://gitlab.freedesktop.org/emersion/libdisplay-info/')
- VisibleVcsPkg: version 9999: VCS version visible for KEYWORDS="amd64", profile core/amd64/glibc (16 total)

## xgui-app/lxappearance
- MissingRemoteId: missing <remote-id type="github">lxde/lxappearance</remote-id> (inferred from URI 'https://github.com/lxde/lxappearance')
- NonexistentDeps: version 20250324: IDEPEND: nonexistent package: app-dev/desktop-file-utils
- NonsolvableDepsInStable: version 20250324: nonsolvable depset(idepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-dev/desktop-file-utils ]

## lib-net/xdp-tools
- MissingRemoteId: missing <remote-id type="github">xdp-project/xdp-tools</remote-id> (inferred from URI 'https://github.com/xdp-project/xdp-tools')
- EbuildReservedName: version 20251129: line 61: variable name "DYNAMIC_LIBXDP" is disallowed because "dyn" is a reserved prefix
- UnknownUseFlags: version 20251129: unknown USE flag: 'tools'
- UnusedInherits: version 20251129: unused eclass: autotools

## xgui-app/cbatticon
- MissingRemoteId: missing <remote-id type="github">valr/cbatticon</remote-id> (inferred from URI 'https://github.com/valr/cbatticon')

## lib-print/libcupsfilters
- MissingRemoteId: missing <remote-id type="github">OpenPrinting/libcupsfilters</remote-id> (inferred from URI 'https://github.com/OpenPrinting/libcupsfilters')
- UnknownUseFlags: version 20250710-r9: unknown USE flags: 'exif', 'poppler', 'postscript'
- UnusedInherits: version 20250710-r9: unused eclass: libtool

## xgui-app/pcmanfm
- MissingRemoteId: missing <remote-id type="github">lxde/pcmanfm</remote-id> (inferred from URI 'https://github.com/lxde/pcmanfm')
- NonexistentDeps: version 20250330: IDEPEND: nonexistent package: app-dev/desktop-file-utils
- NonsolvableDepsInStable: version 20250330: nonsolvable depset(idepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-dev/desktop-file-utils ]
- UnquotedVariable: version 20250330: unquoted variable FILESDIR on line: 40

## xgui-app/swaybg
- MissingRemoteId: missing <remote-id type="github">swaywm/swaybg</remote-id> (inferred from URI 'https://github.com/swaywm/swaybg')

## xgui-app/firefox
- AbsoluteSymlink: version 144.0.2: dosym called with absolute path on line 248: dosym "/usr/bin/${PN}"
- MissingInherits: version 144.0.2: desktop: missing inherit usage: 'newicon -s "${i}" "browser/branding/${theme}/default${i}.png" "${PN}.png"', line 229
- UnknownUseFlags: version 144.0.2: unknown USE flag: 'wasm'
- VariableOrderWrong: version 144.0.2: variable S should occur before RESTRICT

## xgui-app/swayidle
- MissingRemoteId: missing <remote-id type="github">swaywm/swayidle</remote-id> (inferred from URI 'https://github.com/swaywm/swayidle')

## xgui-app/xdotool
- MissingRemoteId: missing <remote-id type="github">jordansissel/xdotool</remote-id> (inferred from URI 'https://github.com/jordansissel/xdotool/archive/b8e19878356fb3763c069abd42ee0911b83eb445.tar.gz')

## xgui-app/swaylock
- MissingRemoteId: missing <remote-id type="github">swaywm/swaylock</remote-id> (inferred from URI 'https://github.com/swaywm/swaylock')

## xgui-desktop/fvwm3
- MissingRemoteId: missing <remote-id type="github">fvwmorg/fvwm3</remote-id> (inferred from URI 'https://github.com/fvwmorg/fvwm3')

## xgui-app/xmrig
- MissingRemoteId: missing <remote-id type="github">xmrig/xmrig</remote-id> (inferred from URI 'https://github.com/xmrig/xmrig/archive/6e4a5a6d94b33d6ed93890126c699b62f9553f50.tar.gz')
- UnknownUseFlags: version 20250622: unknown USE flag: 'http'
- UnquotedVariable: version 20250622: unquoted variable WORKDIR on line: 39

## xgui-app/x11perf
- MissingRemoteId: missing <remote-id type="freedesktop-gitlab">xorg/app/x11perf</remote-id> (inferred from URI 'https://gitlab.freedesktop.org/xorg/app/x11perf')
- BadFilename: version 20250805: bad filename: [ bce7af0ca6ab04249c8dda6bcfedca1da421aa4d.tar.bz2 ]

## xgui-app/ladybird
- ExcessiveLineLength: version 9999: excessive line length (over 120 characters) on line: 47
- IndirectInherits: version 9999: flag-o-matic: indirect inherit usage: 'filter-flags -fgraphite-identity -floop-nest-optimize -ftree-loop-distribution -fdevirtualize-at-ltrans -fipa-pta -fuse-linker-plugin', line 47
- NonexistentDeps: version 9999: IDEPEND: nonexistent package: app-dev/desktop-file-utils
- NonsolvableDepsInStable: version 9999: nonsolvable depset(idepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-dev/desktop-file-utils ]
- VisibleVcsPkg: version 9999: VCS version visible for KEYWORDS="amd64", profile core/amd64/glibc (16 total)

## xgui-app/xclip
- MissingRemoteId: missing <remote-id type="github">astrand/xclip</remote-id> (inferred from URI 'https://github.com/astrand/xclip')
- VariableShadowed: version 20250109: variable 'SRC_URI' may be shadowed, on lines: 9, 12

## xgui-desktop/labwc
- MissingRemoteId: missing <remote-id type="github">labwc/labwc</remote-id> (inferred from URI 'https://github.com/labwc/labwc')

## xgui-desktop/i3wm
- MissingRemoteId: missing <remote-id type="github">i3/i3</remote-id> (inferred from URI 'https://github.com/i3/i3/archive/b1e99d8ff0f5bd78625dfc740bd07e22b6904b36.tar.gz')

## lib-print/cups
- BannedCharacter: filename 'files/org.cups.cups-lpd@.service' character outside allowed set: '@'
- MissingRemoteId: missing <remote-id type="github">apple/cups</remote-id> (inferred from URI 'https://github.com/apple/cups/archive/a8968fc4257322b1e4e191c4bccedea98d7b053e.tar.gz')
- VariableOrderWrong: version 20231027: variable LICENSE should occur before KEYWORDS

## xgui-icontheme/hicolor-icon-theme
- MissingRemoteId: missing <remote-id type="freedesktop-gitlab">xdg/default-icon-theme.git</remote-id> (inferred from URI 'https://gitlab.freedesktop.org/xdg/default-icon-theme.git')
- NonexistentDeps: version 20250709: IDEPEND: nonexistent package: app-dev/desktop-file-utils
- NonsolvableDepsInStable: version 20250709: nonsolvable depset(idepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-dev/desktop-file-utils ]
- RedundantUriRename: version 20250709: redundant rename: https://gitlab.freedesktop.org/xdg/default-icon-theme/-/archive/4dc168322b8b0bc06c521e9e90d66a4fa09816d4/default-icon-theme-4dc168322b8b0bc06c521e9e90d66a4fa09816d4.tar.bz2 -> default-icon-theme-4dc168322b8b0bc06c521e9e90d66a4fa09816d4.tar.bz2

## xgui-desktop/polybar
- MissingRemoteId: missing <remote-id type="github">polybar/polybar</remote-id> (inferred from URI 'https://github.com/polybar/polybar')
- UnknownUseFlags: version 20250924: unknown USE flags: 'i3wm', 'mpd', 'network', 'pulseaudio'

## xgui-icontheme/adwaita-icon-theme
- MissingRemoteId: missing <remote-id type="gnome-gitlab">GNOME/adwaita-icon-theme</remote-id> (inferred from URI 'https://gitlab.gnome.org/GNOME/adwaita-icon-theme/-/archive/ed465372143ed17640a0bbdb4c856cb5b3773d8e/adwaita-icon-theme-ed465372143ed17640a0bbdb4c856cb5b3773d8e.tar.gz')
- BetterCompressionUri: version 48.20250624: line 12: better compression URI using extension '.tar.bz2' for 'https://gitlab.gnome.org/GNOME/adwaita-icon-theme/-/archive/${SNAPSHOT}/adwaita-icon-theme-${SNAPSHOT}.tar.gz'
- NonexistentDeps: version 48.20250624: IDEPEND: nonexistent package: app-dev/desktop-file-utils
- NonsolvableDepsInStable: version 48.20250624: nonsolvable depset(idepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-dev/desktop-file-utils ]

## xgui-lib/babl
- MissingRemoteId: missing <remote-id type="gnome-gitlab">GNOME/babl</remote-id> (inferred from URI 'https://gitlab.gnome.org/GNOME/babl/-/archive/4fb2cafe115908ef3d3ae4b1cde162efd9f4e06d/babl-4fb2cafe115908ef3d3ae4b1cde162efd9f4e06d.tar.bz2')

## xgui-desktop/jwm
- MissingRemoteId: missing <remote-id type="github">joewing/jwm</remote-id> (inferred from URI 'https://github.com/joewing/jwm/archive/032455cc0e08cab4b18c094170de79fbf00efe42.tar.gz')
- PythonMissingDeps: version 20250928: missing RDEPEND="${PYTHON_DEPS}"
- PythonMissingRequiredUse: version 20250928: missing REQUIRED_USE="${PYTHON_REQUIRED_USE}"
- UnknownUseFlags: version 20250928: unknown USE flags: 'bidi', 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14', 'xinerama', 'xpm'
- UnusedInherits: version 20250928: unused eclass: python-r1

## xgui-lib/gegl
- MissingRemoteId: missing <remote-id type="gnome-gitlab">GNOME/gegl</remote-id> (inferred from URI 'https://gitlab.gnome.org/GNOME/gegl/-/archive/eb404866c8984b29fb604fa3dced8ea00e9ed3c6/gegl-eb404866c8984b29fb604fa3dced8ea00e9ed3c6.tar.bz2')

## xgui-app/keepassxc
- MissingRemoteId: missing <remote-id type="github">keepassxreboot/keepassxc</remote-id> (inferred from URI 'https://github.com/keepassxreboot/keepassxc/releases/download/2.7.10/keepassxc-2.7.10-src.tar.xz')
- MissingTestRestrict: version 2.7.10: missing RESTRICT="!test? ( test )" with IUSE=test
- NonexistentDeps: version 2.7.10: IDEPEND: nonexistent package: app-dev/desktop-file-utils
- NonsolvableDepsInStable: version 2.7.10: nonsolvable depset(idepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-dev/desktop-file-utils ]
- UnknownUseFlags: version 2.7.10: unknown USE flag: 'autotype'
- MissingTestRestrict: version 9999: missing RESTRICT="!test? ( test )" with IUSE=test
- NonexistentDeps: version 9999: IDEPEND: nonexistent package: app-dev/desktop-file-utils
- NonsolvableDepsInStable: version 9999: nonsolvable depset(idepend) keyword(~amd64) stable profile (core/amd64/glibc) (8 total): solutions: [ app-dev/desktop-file-utils ]
- UnknownUseFlags: version 9999: unknown USE flag: 'autotype'
- VisibleVcsPkg: version 9999: VCS version visible for KEYWORDS="~amd64", profile core/amd64/glibc (8 total)

## xgui-lib/at-spi2-core
- MissingRemoteId: missing <remote-id type="gnome-gitlab">GNOME/at-spi2-core</remote-id> (inferred from URI 'https://gitlab.gnome.org/GNOME/at-spi2-core/-/archive/9ace8dc0f0b5aac85d2486da89ccd63a496a92ab/at-spi2-core-9ace8dc0f0b5aac85d2486da89ccd63a496a92ab.tar.bz2')
- RedundantUriRename: version 20251125: redundant rename: https://gitlab.gnome.org/GNOME/at-spi2-core/-/archive/9ace8dc0f0b5aac85d2486da89ccd63a496a92ab/at-spi2-core-9ace8dc0f0b5aac85d2486da89ccd63a496a92ab.tar.bz2 -> at-spi2-core-9ace8dc0f0b5aac85d2486da89ccd63a496a92ab.tar.bz2

## xgui-lib/glibmm
- MissingRemoteId: missing <remote-id type="github">GNOME/glibmm</remote-id> (inferred from URI 'https://github.com/GNOME/glibmm')
- MissingTestRestrict: version 9999: missing RESTRICT="!test? ( test )" with IUSE=test
- VisibleVcsPkg: version 9999: VCS version visible for KEYWORDS="amd64", profile core/amd64/glibc (16 total)

## xgui-lib/gtksourceview
- MissingRemoteId: missing <remote-id type="gnome-gitlab">GNOME/gtksourceview</remote-id> (inferred from URI 'https://gitlab.gnome.org/GNOME/gtksourceview/-/archive/23307d8a785ab74f0a59eb3c1f2f28ce9452eff2/gtksourceview-23307d8a785ab74f0a59eb3c1f2f28ce9452eff2.tar.bz2')
- NonexistentDeps: version 20251114: IDEPEND: nonexistent package: app-dev/desktop-file-utils
- NonsolvableDepsInStable: version 20251114: nonsolvable depset(idepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-dev/desktop-file-utils ]
- UnknownUseFlags: version 20251114: unknown USE flag: 'introspection'

## xgui-lib/cairo
- MissingRemoteId: missing <remote-id type="freedesktop-gitlab">cairo/cairo</remote-id> (inferred from URI 'https://gitlab.freedesktop.org/cairo/cairo/-/archive/04656d7450e229622546fd2b11496aa58c44181d/cairo-04656d7450e229622546fd2b11496aa58c44181d.tar.bz2')
- DoubleEmptyLine: version 20250717: ebuild has unneeded empty line on line: 45
- RedundantUriRename: version 20250717: redundant rename: https://gitlab.freedesktop.org/cairo/cairo/-/archive/04656d7450e229622546fd2b11496aa58c44181d/cairo-04656d7450e229622546fd2b11496aa58c44181d.tar.bz2 -> cairo-04656d7450e229622546fd2b11496aa58c44181d.tar.bz2
- UnknownUseFlags: version 20250717: unknown USE flag: 'valgrind'

## xgui-lib/freeglut
- MissingRemoteId: missing <remote-id type="github">freeglut/freeglut</remote-id> (inferred from URI 'https://github.com/freeglut/freeglut/archive/f7f91ab036af418e4c9a5790270041fb5cf472b3.tar.gz')
- BadDescription: version 20251203: over 80 chars in length
- TrailingEmptyLine: version 20251203: ebuild has trailing blank line(s)

## xgui-lib/lcms
- MissingRemoteId: missing <remote-id type="github">ImageMagick/lcms</remote-id> (inferred from URI 'https://github.com/ImageMagick/lcms/archive/015c30082877271f155896b76f512d4d50945b28.tar.gz')
- MissingTestRestrict: version 20250929: missing RESTRICT="!test? ( test )" with IUSE=test

## xgui-lib/libICE
- MissingRemoteId: missing <remote-id type="freedesktop-gitlab">xorg/lib/libICE</remote-id> (inferred from URI 'https://gitlab.freedesktop.org/xorg/lib/libICE/-/archive/513399df5206f52db92bb88970f38dc8a3ea1645/libICE-513399df5206f52db92bb88970f38dc8a3ea1645.tar.bz2')
- RedundantUriRename: version 20250524: redundant rename: https://gitlab.freedesktop.org/xorg/lib/libICE/-/archive/513399df5206f52db92bb88970f38dc8a3ea1645/libICE-513399df5206f52db92bb88970f38dc8a3ea1645.tar.bz2 -> libICE-513399df5206f52db92bb88970f38dc8a3ea1645.tar.bz2

## xgui-lib/gnome-common
- MissingRemoteId: missing <remote-id type="gnome-gitlab">GNOME/gnome-common</remote-id> (inferred from URI 'https://gitlab.gnome.org/GNOME/gnome-common/-/archive/eb124d02f3da574f40360ae64d4fc21af9a2c148/gnome-common-eb124d02f3da574f40360ae64d4fc21af9a2c148.tar.bz2')
- RedundantUriRename: version 20240317: redundant rename: https://gitlab.gnome.org/GNOME/gnome-common/-/archive/eb124d02f3da574f40360ae64d4fc21af9a2c148/gnome-common-eb124d02f3da574f40360ae64d4fc21af9a2c148.tar.bz2 -> gnome-common-eb124d02f3da574f40360ae64d4fc21af9a2c148.tar.bz2

## xgui-lib/libXScrnSaver
- MissingRemoteId: missing <remote-id type="freedesktop-gitlab">xorg/lib/libXScrnSaver</remote-id> (inferred from URI 'https://gitlab.freedesktop.org/xorg/lib/libXScrnSaver/-/archive/60c957ba8a727d01b376da0142aef7e18aa86fe1/libXScrnSaver-60c957ba8a727d01b376da0142aef7e18aa86fe1.tar.bz2')
- RedundantUriRename: version 20250907: redundant rename: https://gitlab.freedesktop.org/xorg/lib/libXScrnSaver/-/archive/60c957ba8a727d01b376da0142aef7e18aa86fe1/libXScrnSaver-60c957ba8a727d01b376da0142aef7e18aa86fe1.tar.bz2 -> libXScrnSaver-60c957ba8a727d01b376da0142aef7e18aa86fe1.tar.bz2

## xgui-lib/libXaw
- MissingRemoteId: missing <remote-id type="freedesktop-gitlab">xorg/lib/libXaw</remote-id> (inferred from URI 'https://gitlab.freedesktop.org/xorg/lib/libXaw/-/archive/12e81cd8ade629256488782a2e7ae0322d84da53/libXaw-12e81cd8ade629256488782a2e7ae0322d84da53.tar.bz2')
- RedundantUriRename: version 20250713: redundant rename: https://gitlab.freedesktop.org/xorg/lib/libXaw/-/archive/12e81cd8ade629256488782a2e7ae0322d84da53/libXaw-12e81cd8ade629256488782a2e7ae0322d84da53.tar.bz2 -> libXaw-12e81cd8ade629256488782a2e7ae0322d84da53.tar.bz2

## xgui-lib/libX11
- MissingRemoteId: missing <remote-id type="freedesktop-gitlab">xorg/lib/libX11</remote-id> (inferred from URI 'https://gitlab.freedesktop.org/xorg/lib/libX11/-/archive/369c6a806554429798b531cbf4267d8c8fcf6ed1/libX11-369c6a806554429798b531cbf4267d8c8fcf6ed1.tar.bz2')
- RedundantUriRename: version 20251017: redundant rename: https://gitlab.freedesktop.org/xorg/lib/libX11/-/archive/369c6a806554429798b531cbf4267d8c8fcf6ed1/libX11-369c6a806554429798b531cbf4267d8c8fcf6ed1.tar.bz2 -> libX11-369c6a806554429798b531cbf4267d8c8fcf6ed1.tar.bz2

## dev-python/urllib3
- MissingRemoteId: missing <remote-id type="github">urllib3/urllib3</remote-id> (inferred from URI 'https://github.com/urllib3/urllib3/')
- MissingRemoteId: missing <remote-id type="pypi">urllib3</remote-id> (inferred from URI 'https://pypi.org/project/urllib3/')
- NonexistentDeps: version 2.5.0: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12, dev-python/pytest-rerunfailures, dev-python/quart-trio
- NonexistentDeps: version 2.5.0: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 2.5.0: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11[ssl(+)], app-lang/python:3.12[ssl(+)], app-lang/python:3.14[ssl(+)], dev-python/pytest-rerunfailures[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], dev-python/quart-trio[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)] ]
- NonsolvableDepsInStable: version 2.5.0: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11[ssl(+)], app-lang/python:3.12[ssl(+)], app-lang/python:3.14[ssl(+)] ]
- PythonMissingDeps: version 2.5.0: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 2.5.0: unknown USE flags: 'brotli', 'http2', 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## xgui-lib/libSM
- MissingRemoteId: missing <remote-id type="freedesktop-gitlab">xorg/lib/libSM</remote-id> (inferred from URI 'https://gitlab.freedesktop.org/xorg/lib/libSM/-/archive/5f6da959a34bcefc425b6e37462553acf44369a3/libSM-5f6da959a34bcefc425b6e37462553acf44369a3.tar.bz2')
- RedundantUriRename: version 20250308: redundant rename: https://gitlab.freedesktop.org/xorg/lib/libSM/-/archive/5f6da959a34bcefc425b6e37462553acf44369a3/libSM-5f6da959a34bcefc425b6e37462553acf44369a3.tar.bz2 -> libSM-5f6da959a34bcefc425b6e37462553acf44369a3.tar.bz2
- UnknownUseFlags: version 20250308: unknown USE flag: 'uuid'

## xgui-lib/glew
- MissingRemoteId: missing <remote-id type="github">nigels-com/glew</remote-id> (inferred from URI 'https://github.com/nigels-com/glew/archive/ba71151c6af7435127c54b890808fec2a4aad41f.tar.gz')

## xgui-lib/harfbuzz
- MissingRemoteId: missing <remote-id type="github">harfbuzz/harfbuzz</remote-id> (inferred from URI 'https://github.com/harfbuzz/harfbuzz/releases/download/12.1.0/harfbuzz-12.1.0.tar.xz')
- MissingTestRestrict: version 12.1.0: missing RESTRICT="!test? ( test )" with IUSE=test
- PythonMissingDeps: version 12.1.0: missing DEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 12.1.0: unknown USE flag: 'introspection'

## xgui-lib/libXau
- MissingRemoteId: missing <remote-id type="freedesktop-gitlab">xorg/lib/libXau</remote-id> (inferred from URI 'https://gitlab.freedesktop.org/xorg/lib/libXau/-/archive/962b015d498b1f186aea8e3b0b46fb9791831552/libXau-962b015d498b1f186aea8e3b0b46fb9791831552.tar.bz2')
- RedundantUriRename: version 20250713: redundant rename: https://gitlab.freedesktop.org/xorg/lib/libXau/-/archive/962b015d498b1f186aea8e3b0b46fb9791831552/libXau-962b015d498b1f186aea8e3b0b46fb9791831552.tar.bz2 -> libXau-962b015d498b1f186aea8e3b0b46fb9791831552.tar.bz2

## xgui-lib/libXcomposite
- MissingRemoteId: missing <remote-id type="freedesktop-gitlab">xorg/lib/libXcomposite</remote-id> (inferred from URI 'https://gitlab.freedesktop.org/xorg/lib/libXcomposite/-/archive/f796f0a862849765ac5b6b5e861ea548b421b8f0/libXcomposite-f796f0a862849765ac5b6b5e861ea548b421b8f0.tar.bz2')
- RedundantUriRename: version 20250221: redundant rename: https://gitlab.freedesktop.org/xorg/lib/libXcomposite/-/archive/f796f0a862849765ac5b6b5e861ea548b421b8f0/libXcomposite-f796f0a862849765ac5b6b5e861ea548b421b8f0.tar.bz2 -> libXcomposite-f796f0a862849765ac5b6b5e861ea548b421b8f0.tar.bz2

## xgui-lib/gtkmm
- MissingRemoteId: missing <remote-id type="github">GNOME/gtkmm</remote-id> (inferred from URI 'https://github.com/GNOME/gtkmm')

## xgui-lib/libXdmcp
- MissingRemoteId: missing <remote-id type="freedesktop-gitlab">xorg/lib/libXdmcp</remote-id> (inferred from URI 'https://gitlab.freedesktop.org/xorg/lib/libXdmcp/-/archive/8f3408f3936bacd08f76d5ee22cbc86e6b627287/libXdmcp-8f3408f3936bacd08f76d5ee22cbc86e6b627287.tar.bz2')
- RedundantUriRename: version 20250118: redundant rename: https://gitlab.freedesktop.org/xorg/lib/libXdmcp/-/archive/8f3408f3936bacd08f76d5ee22cbc86e6b627287/libXdmcp-8f3408f3936bacd08f76d5ee22cbc86e6b627287.tar.bz2 -> libXdmcp-8f3408f3936bacd08f76d5ee22cbc86e6b627287.tar.bz2

## xgui-lib/layer-shell-qt
- BadDescription: version 6.3.9999: over 80 chars in length
- VisibleVcsPkg: version 6.3.9999: VCS version visible for KEYWORDS="amd64", profile core/amd64/glibc (16 total)
- BadDescription: version 6.9.9999: over 80 chars in length
- VisibleVcsPkg: version 6.9.9999: VCS version visible for KEYWORDS="amd64", profile core/amd64/glibc (16 total)

## xgui-lib/imlib2
- MissingRemoteId: missing <remote-id type="github">1g4-mirror/legacy-imlib2</remote-id> (inferred from URI 'https://github.com/1g4-mirror/legacy-imlib2/archive/51f3ffc3da149318a5353e4761df0a74b838b64c.tar.gz')
- UnknownLicense: version 20250915: unknown license: Imlib2
- UnknownUseFlags: version 20250915: unknown USE flag: 'webp'

## xgui-lib/libXdamage
- MissingRemoteId: missing <remote-id type="freedesktop-gitlab">xorg/lib/libXdamage</remote-id> (inferred from URI 'https://gitlab.freedesktop.org/xorg/lib/libXdamage/-/archive/1319ae5cfbde5b75e23383baa5e00cc23513448c/libXdamage-1319ae5cfbde5b75e23383baa5e00cc23513448c.tar.bz2')
- RedundantUriRename: version 20250216: redundant rename: https://gitlab.freedesktop.org/xorg/lib/libXdamage/-/archive/1319ae5cfbde5b75e23383baa5e00cc23513448c/libXdamage-1319ae5cfbde5b75e23383baa5e00cc23513448c.tar.bz2 -> libXdamage-1319ae5cfbde5b75e23383baa5e00cc23513448c.tar.bz2

## xgui-lib/libXfixes
- MissingRemoteId: missing <remote-id type="freedesktop-gitlab">xorg/lib/libXfixes</remote-id> (inferred from URI 'https://gitlab.freedesktop.org/xorg/lib/libXfixes/-/archive/70d5b0e37f8a759f3dbc218f22954347ceed094a/libXfixes-70d5b0e37f8a759f3dbc218f22954347ceed094a.tar.bz2')
- RedundantUriRename: version 20250901: redundant rename: https://gitlab.freedesktop.org/xorg/lib/libXfixes/-/archive/70d5b0e37f8a759f3dbc218f22954347ceed094a/libXfixes-70d5b0e37f8a759f3dbc218f22954347ceed094a.tar.bz2 -> libXfixes-70d5b0e37f8a759f3dbc218f22954347ceed094a.tar.bz2

## xgui-lib/gdk-pixbuf
- MissingRemoteId: missing <remote-id type="gnome-gitlab">GNOME/gdk-pixbuf</remote-id> (inferred from URI 'https://gitlab.gnome.org/GNOME/gdk-pixbuf/-/archive/7bfb948a3f10e3d7aaecf0bbb9aa5a0934acf5b4/gdk-pixbuf-7bfb948a3f10e3d7aaecf0bbb9aa5a0934acf5b4.tar.bz2')
- RedundantUriRename: version 20250612-r9: redundant rename: https://gitlab.gnome.org/GNOME/gdk-pixbuf/-/archive/312aab46bfb8041357bf097c820a09429316a7df/gdk-pixbuf-312aab46bfb8041357bf097c820a09429316a7df.tar.bz2 -> gdk-pixbuf-312aab46bfb8041357bf097c820a09429316a7df.tar.bz2
- UnknownUseFlags: version 20250612-r9: unknown USE flag: 'introspection'
- RedundantUriRename: version 20251109: redundant rename: https://gitlab.gnome.org/GNOME/gdk-pixbuf/-/archive/7bfb948a3f10e3d7aaecf0bbb9aa5a0934acf5b4/gdk-pixbuf-7bfb948a3f10e3d7aaecf0bbb9aa5a0934acf5b4.tar.bz2 -> gdk-pixbuf-7bfb948a3f10e3d7aaecf0bbb9aa5a0934acf5b4.tar.bz2
- UnknownUseFlags: version 20251109: unknown USE flag: 'introspection'

## dev-python/nbformat
- MissingRemoteId: missing <remote-id type="github">jupyter/nbformat</remote-id> (inferred from URI 'https://github.com/jupyter/nbformat/')
- MissingRemoteId: missing <remote-id type="pypi">nbformat</remote-id> (inferred from URI 'https://pypi.org/project/nbformat/')
- EPyTestPluginsSuggestion: version 5.10.4: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- NonexistentDeps: version 5.10.4: BDEPEND: nonexistent packages: >=dev-python/jupyter-core-5.1, app-lang/python:3.11, app-lang/python:3.12, dev-python/hatch-nodejs-version, dev-python/myst-parser, dev-python/pydata-sphinx-theme, dev-python/sphinxcontrib-github-alt, dev-python/sphinxcontrib-spelling
- NonexistentDeps: version 5.10.4: RDEPEND: nonexistent packages: >=dev-python/jupyter-core-5.1, app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 5.10.4: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11[sqlite], app-lang/python:3.12[sqlite], app-lang/python:3.14[sqlite], dev-python/hatch-nodejs-version[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], >=dev-python/jupyter-core-5.1[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)], dev-python/myst-parser[python_targets_python3_11(-)], dev-python/myst-parser[python_targets_python3_12(-)], dev-python/myst-parser[python_targets_python3_13(-)], dev-python/myst-parser[python_targets_python3_14(-)], dev-python/pydata-sphinx-theme[python_targets_python3_11(-)], dev-python/pydata-sphinx-theme[python_targets_python3_12(-)], dev-python/pydata-sphinx-theme[python_targets_python3_13(-)], dev-python/pydata-sphinx-theme[python_targets_python3_14(-)], dev-python/sphinxcontrib-github-alt[python_targets_python3_11(-)], dev-python/sphinxcontrib-github-alt[python_targets_python3_12(-)], dev-python/sphinxcontrib-github-alt[python_targets_python3_13(-)], dev-python/sphinxcontrib-github-alt[python_targets_python3_14(-)], dev-python/sphinxcontrib-spelling[python_targets_python3_11(-)], dev-python/sphinxcontrib-spelling[python_targets_python3_12(-)], dev-python/sphinxcontrib-spelling[python_targets_python3_13(-)], dev-python/sphinxcontrib-spelling[python_targets_python3_14(-)] ]
- NonsolvableDepsInStable: version 5.10.4: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11[sqlite], app-lang/python:3.12[sqlite], app-lang/python:3.14[sqlite], >=dev-python/jupyter-core-5.1[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)] ]
- PythonMissingDeps: version 5.10.4: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 5.10.4: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## xgui-lib/libXpm
- MissingRemoteId: missing <remote-id type="freedesktop-gitlab">xorg/lib/libXpm</remote-id> (inferred from URI 'https://gitlab.freedesktop.org/xorg/lib/libXpm/-/archive/10070a4e998c1a223dec437847c38dc27dbe85d4/libXpm-10070a4e998c1a223dec437847c38dc27dbe85d4.tar.bz2')
- RedundantUriRename: version 20250830: redundant rename: https://gitlab.freedesktop.org/xorg/lib/libXpm/-/archive/10070a4e998c1a223dec437847c38dc27dbe85d4/libXpm-10070a4e998c1a223dec437847c38dc27dbe85d4.tar.bz2 -> libXpm-10070a4e998c1a223dec437847c38dc27dbe85d4.tar.bz2

## xgui-lib/libXinerama
- MissingRemoteId: missing <remote-id type="freedesktop-gitlab">xorg/lib/libXinerama</remote-id> (inferred from URI 'https://gitlab.freedesktop.org/xorg/lib/libXinerama/-/archive/cc22c2f60c3862482562955116d5455263b443dc/libXinerama-cc22c2f60c3862482562955116d5455263b443dc.tar.bz2')
- RedundantUriRename: version 20250714: redundant rename: https://gitlab.freedesktop.org/xorg/lib/libXinerama/-/archive/cc22c2f60c3862482562955116d5455263b443dc/libXinerama-cc22c2f60c3862482562955116d5455263b443dc.tar.bz2 -> libXinerama-cc22c2f60c3862482562955116d5455263b443dc.tar.bz2

## xgui-lib/libXft
- MissingRemoteId: missing <remote-id type="freedesktop-gitlab">xorg/lib/libXft</remote-id> (inferred from URI 'https://gitlab.freedesktop.org/xorg/lib/libXft/-/archive/69edd320e23b00d9aef240ce9b50f7bf482a12ef/libXft-69edd320e23b00d9aef240ce9b50f7bf482a12ef.tar.bz2')
- RedundantUriRename: version 20251021: redundant rename: https://gitlab.freedesktop.org/xorg/lib/libXft/-/archive/69edd320e23b00d9aef240ce9b50f7bf482a12ef/libXft-69edd320e23b00d9aef240ce9b50f7bf482a12ef.tar.bz2 -> libXft-69edd320e23b00d9aef240ce9b50f7bf482a12ef.tar.bz2

## xgui-lib/libXpresent
- MissingRemoteId: missing <remote-id type="freedesktop-gitlab">xorg/lib/libXpresent</remote-id> (inferred from URI 'https://gitlab.freedesktop.org/xorg/lib/libXpresent/-/archive/4d92149372461bf575e8a09b1064a2884c38c3aa/libXpresent-4d92149372461bf575e8a09b1064a2884c38c3aa.tar.bz2')
- RedundantUriRename: version 20250907: redundant rename: https://gitlab.freedesktop.org/xorg/lib/libXpresent/-/archive/4d92149372461bf575e8a09b1064a2884c38c3aa/libXpresent-4d92149372461bf575e8a09b1064a2884c38c3aa.tar.bz2 -> libXpresent-4d92149372461bf575e8a09b1064a2884c38c3aa.tar.bz2

## xgui-lib/libXxf86vm
- MissingRemoteId: missing <remote-id type="freedesktop-gitlab">xorg/lib/libxxf86vm</remote-id> (inferred from URI 'https://gitlab.freedesktop.org/xorg/lib/libxxf86vm/-/archive/63134ba6acf046099fc112e08942ff6549f2286a/libxxf86vm-63134ba6acf046099fc112e08942ff6549f2286a.tar.bz2')
- RedundantUriRename: version 20250715: redundant rename: https://gitlab.freedesktop.org/xorg/lib/libxxf86vm/-/archive/63134ba6acf046099fc112e08942ff6549f2286a/libxxf86vm-63134ba6acf046099fc112e08942ff6549f2286a.tar.bz2 -> libxxf86vm-63134ba6acf046099fc112e08942ff6549f2286a.tar.bz2

## xgui-lib/libXcursor
- MissingRemoteId: missing <remote-id type="freedesktop-gitlab">xorg/lib/libXcursor</remote-id> (inferred from URI 'https://gitlab.freedesktop.org/xorg/lib/libXcursor/-/archive/2197ca8cbb743d2fcc43c155396a724cad8f26f3/libXcursor-2197ca8cbb743d2fcc43c155396a724cad8f26f3.tar.bz2')
- RedundantUriRename: version 20250713: redundant rename: https://gitlab.freedesktop.org/xorg/lib/libXcursor/-/archive/2197ca8cbb743d2fcc43c155396a724cad8f26f3/libXcursor-2197ca8cbb743d2fcc43c155396a724cad8f26f3.tar.bz2 -> libXcursor-2197ca8cbb743d2fcc43c155396a724cad8f26f3.tar.bz2

## xgui-lib/libXrender
- MissingRemoteId: missing <remote-id type="freedesktop-gitlab">xorg/lib/libXrender</remote-id> (inferred from URI 'https://gitlab.freedesktop.org/xorg/lib/libXrender/-/archive/01c4bb5b30bbb09921ca4042da369a60a73faefa/libXrender-01c4bb5b30bbb09921ca4042da369a60a73faefa.tar.bz2')
- RedundantUriRename: version 20250216: redundant rename: https://gitlab.freedesktop.org/xorg/lib/libXrender/-/archive/01c4bb5b30bbb09921ca4042da369a60a73faefa/libXrender-01c4bb5b30bbb09921ca4042da369a60a73faefa.tar.bz2 -> libXrender-01c4bb5b30bbb09921ca4042da369a60a73faefa.tar.bz2

## xgui-lib/libXv
- MissingRemoteId: missing <remote-id type="freedesktop-gitlab">xorg/lib/libXv</remote-id> (inferred from URI 'https://gitlab.freedesktop.org/xorg/lib/libXv/-/archive/d709b8efab4e28b3ad324ca30acdb81a527f69a4/libXv-d709b8efab4e28b3ad324ca30acdb81a527f69a4.tar.bz2')
- RedundantUriRename: version 20250715: redundant rename: https://gitlab.freedesktop.org/xorg/lib/libXv/-/archive/d709b8efab4e28b3ad324ca30acdb81a527f69a4/libXv-d709b8efab4e28b3ad324ca30acdb81a527f69a4.tar.bz2 -> libXv-d709b8efab4e28b3ad324ca30acdb81a527f69a4.tar.bz2

## xgui-lib/libpciaccess
- MissingRemoteId: missing <remote-id type="freedesktop-gitlab">xorg/lib/libpciaccess</remote-id> (inferred from URI 'https://gitlab.freedesktop.org/xorg/lib/libpciaccess/-/archive/191dfe0707e2a93c08e4b3e99454b6146c5bfca2/libpciaccess-191dfe0707e2a93c08e4b3e99454b6146c5bfca2.tar.bz2')
- RedundantUriRename: version 20250719: redundant rename: https://gitlab.freedesktop.org/xorg/lib/libpciaccess/-/archive/191dfe0707e2a93c08e4b3e99454b6146c5bfca2/libpciaccess-191dfe0707e2a93c08e4b3e99454b6146c5bfca2.tar.bz2 -> libpciaccess-191dfe0707e2a93c08e4b3e99454b6146c5bfca2.tar.bz2

## xgui-app/pillow
- MissingRemoteId: missing <remote-id type="github">python-pillow/Pillow</remote-id> (inferred from URI 'https://github.com/python-pillow/Pillow/archive/339bc5db93bd95decf65a59fab273f300db6594d.tar.gz')
- EPyTestPluginsSuggestion: version 11.2.20250412: EPYTEST_PLUGINS can be used to control pytest plugins loaded
- IndirectInherits: version 11.2.20250412: flag-o-matic: indirect inherit usage: 'filter-flags -Wl,-z,defs', line 61
- NonexistentDeps: version 11.2.20250412: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 11.2.20250412: DEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 11.2.20250412: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 11.2.20250412: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 11.2.20250412: nonsolvable depset(depend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 11.2.20250412: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 11.2.20250412: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 11.2.20250412: unknown USE flags: 'imagequant', 'jpeg2k', 'lcms', 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14', 'tk', 'webp'
- WhitespaceFound: version 11.2.20250412: ebuild has leading whitespace on lines: 55, 56

## xgui-lib/libXt
- MissingRemoteId: missing <remote-id type="freedesktop-gitlab">xorg/lib/libXt</remote-id> (inferred from URI 'https://gitlab.freedesktop.org/xorg/lib/libXt/-/archive/170a4edb3189810810ffbf2543bfb8ab96e1898c/libXt-170a4edb3189810810ffbf2543bfb8ab96e1898c.tar.bz2')
- MissingTestRestrict: version 20250907: missing RESTRICT="!test? ( test )" with IUSE=test
- RedundantUriRename: version 20250907: redundant rename: https://gitlab.freedesktop.org/xorg/lib/libXt/-/archive/170a4edb3189810810ffbf2543bfb8ab96e1898c/libXt-170a4edb3189810810ffbf2543bfb8ab96e1898c.tar.bz2 -> libXt-170a4edb3189810810ffbf2543bfb8ab96e1898c.tar.bz2

## xgui-lib/libXrandr
- MissingRemoteId: missing <remote-id type="freedesktop-gitlab">xorg/lib/libXrandr</remote-id> (inferred from URI 'https://gitlab.freedesktop.org/xorg/lib/libXrandr/-/archive/242fae8378b213f8e477bde1c4be2fb654201b3d/libXrandr-242fae8378b213f8e477bde1c4be2fb654201b3d.tar.bz2')
- RedundantUriRename: version 20250715: redundant rename: https://gitlab.freedesktop.org/xorg/lib/libXrandr/-/archive/242fae8378b213f8e477bde1c4be2fb654201b3d/libXrandr-242fae8378b213f8e477bde1c4be2fb654201b3d.tar.bz2 -> libXrandr-242fae8378b213f8e477bde1c4be2fb654201b3d.tar.bz2

## xgui-lib/libXext
- MissingRemoteId: missing <remote-id type="freedesktop-gitlab">xorg/lib/libXext</remote-id> (inferred from URI 'https://gitlab.freedesktop.org/xorg/lib/libXext/-/archive/5ce2a6127889834082147dbcdd47731b7986961b/libXext-5ce2a6127889834082147dbcdd47731b7986961b.tar.bz2')
- RedundantUriRename: version 20250917: redundant rename: https://gitlab.freedesktop.org/xorg/lib/libXext/-/archive/5ce2a6127889834082147dbcdd47731b7986961b/libXext-5ce2a6127889834082147dbcdd47731b7986961b.tar.bz2 -> libXext-5ce2a6127889834082147dbcdd47731b7986961b.tar.bz2

## xgui-lib/libcroco
- MissingTestRestrict: version 9999: missing RESTRICT="!test? ( test )" with IUSE=test
- UnquotedVariable: version 9999: unquoted variable S on line: 23
- VisibleVcsPkg: version 9999: VCS version visible for KEYWORDS="amd64", profile core/amd64/glibc (16 total)

## xgui-lib/libXi
- MissingRemoteId: missing <remote-id type="freedesktop-gitlab">xorg/lib/libXi</remote-id> (inferred from URI 'https://gitlab.freedesktop.org/xorg/lib/libXi/-/archive/3c2d5aedd7708c75710b39268631762de904c304/libXi-3c2d5aedd7708c75710b39268631762de904c304.tar.bz2')
- MultipleKeywordsLines: version 20240904: KEYWORDS specified on lines: 13, 17
- RedundantUriRename: version 20240904: redundant rename: https://gitlab.freedesktop.org/xorg/lib/libXi/-/archive/3c2d5aedd7708c75710b39268631762de904c304/libXi-3c2d5aedd7708c75710b39268631762de904c304.tar.bz2 -> libXi-3c2d5aedd7708c75710b39268631762de904c304.tar.bz2
- VariableOrderWrong: version 20240904: variable LICENSE should occur before KEYWORDS
- VariableShadowed: version 20240904: variable 'KEYWORDS' may be shadowed, on lines: 13, 17

## xgui-lib/libqalculate
- MissingRemoteId: missing <remote-id type="github">Qalculate/libqalculate</remote-id> (inferred from URI 'https://github.com/Qalculate/libqalculate/archive/5bcff6d26537301cb39f1ac8f42a633fb8e9fe02.tar.gz')
- UnknownUseFlags: version 20251130: unknown USE flag: 'gnuplot'

## xgui-lib/libXtst
- MissingRemoteId: missing <remote-id type="freedesktop-gitlab">xorg/lib/libXtst</remote-id> (inferred from URI 'https://gitlab.freedesktop.org/xorg/lib/libXtst/-/archive/abf3ff74b97c4231d2324d66318bfa1d22e44913/libXtst-abf3ff74b97c4231d2324d66318bfa1d22e44913.tar.bz2')
- RedundantUriRename: version 20240801: redundant rename: https://gitlab.freedesktop.org/xorg/lib/libXtst/-/archive/abf3ff74b97c4231d2324d66318bfa1d22e44913/libXtst-abf3ff74b97c4231d2324d66318bfa1d22e44913.tar.bz2 -> libXtst-abf3ff74b97c4231d2324d66318bfa1d22e44913.tar.bz2

## xgui-lib/libXfont2
- MissingRemoteId: missing <remote-id type="freedesktop-gitlab">xorg/lib/libxfont</remote-id> (inferred from URI 'https://gitlab.freedesktop.org/xorg/lib/libxfont/-/archive/2c2e44c94ef17ecd5003a173237b57b315e28d93/libxfont-2c2e44c94ef17ecd5003a173237b57b315e28d93.tar.bz2')
- RedundantUriRename: version 20240801: redundant rename: https://gitlab.freedesktop.org/xorg/lib/libxfont/-/archive/2c2e44c94ef17ecd5003a173237b57b315e28d93/libxfont-2c2e44c94ef17ecd5003a173237b57b315e28d93.tar.bz2 -> libxfont-2c2e44c94ef17ecd5003a173237b57b315e28d93.tar.bz2

## xgui-lib/libdrm
- MissingRemoteId: missing <remote-id type="freedesktop-gitlab">mesa/drm</remote-id> (inferred from URI 'https://gitlab.freedesktop.org/mesa/drm/-/archive/d72d7c6eef64ad2e200b0f1fa8cd2447b9a6c660/drm-d72d7c6eef64ad2e200b0f1fa8cd2447b9a6c660.tar.bz2')
- RedundantUriRename: version 20251203: redundant rename: https://gitlab.freedesktop.org/mesa/drm/-/archive/d72d7c6eef64ad2e200b0f1fa8cd2447b9a6c660/drm-d72d7c6eef64ad2e200b0f1fa8cd2447b9a6c660.tar.bz2 -> drm-d72d7c6eef64ad2e200b0f1fa8cd2447b9a6c660.tar.bz2
- UnknownUseFlags: version 20251203: unknown USE flags: 'amdgpu', 'exynos', 'intel', 'libkms', 'nouveau', 'omap', 'radeon', 'valgrind'

## xgui-lib/libfontenc
- MissingRemoteId: missing <remote-id type="freedesktop-gitlab">xorg/lib/libfontenc</remote-id> (inferred from URI 'https://gitlab.freedesktop.org/xorg/lib/libfontenc/-/archive/dcdbcce903ee49200040c0da092b45253c20c6df/libfontenc-dcdbcce903ee49200040c0da092b45253c20c6df.tar.bz2')
- RedundantUriRename: version 20250216: redundant rename: https://gitlab.freedesktop.org/xorg/lib/libfontenc/-/archive/dcdbcce903ee49200040c0da092b45253c20c6df/libfontenc-dcdbcce903ee49200040c0da092b45253c20c6df.tar.bz2 -> libfontenc-dcdbcce903ee49200040c0da092b45253c20c6df.tar.bz2

## xgui-lib/libfm-extra
- MissingRemoteId: missing <remote-id type="github">lxde/libfm</remote-id> (inferred from URI 'https://github.com/lxde/libfm/archive/3289abf583030c664babae64a73d1981afcbe8ed.tar.gz')

## xgui-lib/libXmu
- MissingRemoteId: missing <remote-id type="freedesktop-gitlab">xorg/lib/libXmu</remote-id> (inferred from URI 'https://gitlab.freedesktop.org/xorg/lib/libXmu/-/archive/bd64e44c0f76e7d01543060501bbd39561062996/libXmu-bd64e44c0f76e7d01543060501bbd39561062996.tar.bz2')
- RedundantUriRename: version 20250711: redundant rename: https://gitlab.freedesktop.org/xorg/lib/libXmu/-/archive/bd64e44c0f76e7d01543060501bbd39561062996/libXmu-bd64e44c0f76e7d01543060501bbd39561062996.tar.bz2 -> libXmu-bd64e44c0f76e7d01543060501bbd39561062996.tar.bz2

## xgui-lib/freetype
- MissingRemoteId: missing <remote-id type="github">freetype/freetype</remote-id> (inferred from URI 'https://github.com/freetype/freetype/archive/f75ae3d06d0d5f483a81c1e155b9b91e564c5145.tar.gz')
- UnknownUseFlags: version 2.14.1: unknown USE flags: 'brotli', 'harfbuzz'
- VariableOrderWrong: version 2.14.1: variable LICENSE should occur before KEYWORDS
- VariableOrderWrong: version 2.14.1: variable SRC_URI should occur before IUSE
- UnknownUseFlags: version 9999: unknown USE flags: 'brotli', 'harfbuzz'
- VariableOrderWrong: version 9999: variable LICENSE should occur before IUSE
- UnknownUseFlags: version 20251204: unknown USE flags: 'brotli', 'harfbuzz'
- VariableOrderWrong: version 20251204: variable LICENSE should occur before IUSE

## xgui-lib/libsndfile
- MissingRemoteId: missing <remote-id type="github">libsndfile/libsndfile</remote-id> (inferred from URI 'https://github.com/libsndfile/libsndfile/archive/d9a35ea0d5c64c19dd635ae578e0028df8f66d6a.tar.gz')
- PythonMissingDeps: version 20251020: missing DEPEND="${PYTHON_DEPS}"

## xgui-lib/libfm
- MissingRemoteId: missing <remote-id type="github">lxde/libfm</remote-id> (inferred from URI 'https://github.com/lxde/libfm')
- NonexistentDeps: version 20250316: IDEPEND: nonexistent package: app-dev/desktop-file-utils
- NonsolvableDepsInStable: version 20250316: nonsolvable depset(idepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-dev/desktop-file-utils ]
- UnknownUseFlags: version 20250316: unknown USE flag: 'exif'

## xgui-lib/libxshmfence
- MissingRemoteId: missing <remote-id type="freedesktop-gitlab">xorg/lib/libxshmfence</remote-id> (inferred from URI 'https://gitlab.freedesktop.org/xorg/lib/libxshmfence/-/archive/2c3d85cf655f4c9a605f0353cc742f186af52835/libxshmfence-2c3d85cf655f4c9a605f0353cc742f186af52835.tar.bz2')
- RedundantUriRename: version 20250223: redundant rename: https://gitlab.freedesktop.org/xorg/lib/libxshmfence/-/archive/2c3d85cf655f4c9a605f0353cc742f186af52835/libxshmfence-2c3d85cf655f4c9a605f0353cc742f186af52835.tar.bz2 -> libxshmfence-2c3d85cf655f4c9a605f0353cc742f186af52835.tar.bz2

## xgui-lib/gtk3
- MissingRemoteId: missing <remote-id type="gnome-gitlab">GNOME/gtk</remote-id> (inferred from URI 'https://gitlab.gnome.org/GNOME/gtk/-/archive/8723146fca06edd5584d0a9e16668356af6ce308/gtk-8723146fca06edd5584d0a9e16668356af6ce308.tar.bz2')
- NonexistentDeps: version 3.24.20251202: IDEPEND: nonexistent package: app-dev/desktop-file-utils
- NonsolvableDepsInStable: version 3.24.20251202: nonsolvable depset(idepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-dev/desktop-file-utils ]
- RequiredUseDefaults: version 3.24.20251202: profile: 'core/amd64/glibc' (8 total) failed REQUIRED_USE: ( wayland || X )
- UnknownUseFlags: version 3.24.20251202: unknown USE flags: 'introspection', 'xinerama'

## xgui-lib/pixman
- MissingRemoteId: missing <remote-id type="freedesktop-gitlab">pixman/pixman</remote-id> (inferred from URI 'https://gitlab.freedesktop.org/pixman/pixman/-/archive/f824cac6478971c0f71e4dfe8a60ebf70224076a/pixman-f824cac6478971c0f71e4dfe8a60ebf70224076a.tar.bz2')
- RedundantUriRename: version 20251122: redundant rename: https://gitlab.freedesktop.org/pixman/pixman/-/archive/f824cac6478971c0f71e4dfe8a60ebf70224076a/pixman-f824cac6478971c0f71e4dfe8a60ebf70224076a.tar.bz2 -> pixman-f824cac6478971c0f71e4dfe8a60ebf70224076a.tar.bz2

## xgui-lib/mtdev
- MissingRemoteId: missing <remote-id type="github">1g4-mirror/mtdev</remote-id> (inferred from URI 'https://github.com/1g4-mirror/mtdev/archive/9035c2225494b80b02e985fc7ee77880e0bd6993.tar.gz')

## xgui-lib/libxcb
- MissingRemoteId: missing <remote-id type="freedesktop-gitlab">xorg/lib/libxcb</remote-id> (inferred from URI 'https://gitlab.freedesktop.org/xorg/lib/libxcb/-/archive/93ee2ac73c32dcb567259fb83c564a424cd9fef7/libxcb-93ee2ac73c32dcb567259fb83c564a424cd9fef7.tar.bz2')
- MissingTestRestrict: version 20251105: missing RESTRICT="!test? ( test )" with IUSE=test
- RedundantUriRename: version 20251105: redundant rename: https://gitlab.freedesktop.org/xorg/lib/libxcb/-/archive/93ee2ac73c32dcb567259fb83c564a424cd9fef7/libxcb-93ee2ac73c32dcb567259fb83c564a424cd9fef7.tar.bz2 -> libxcb-93ee2ac73c32dcb567259fb83c564a424cd9fef7.tar.bz2
- UnknownUseFlags: version 20251105: unknown USE flags: 'keep-la', 'xkb'
- UnusedInherits: version 20251105: unused eclass: flag-o-matic

## xgui-lib/gtk2
- MissingRemoteId: missing <remote-id type="gnome-gitlab">GNOME/gtk</remote-id> (inferred from URI 'https://gitlab.gnome.org/GNOME/gtk/-/archive/68631945733158f164427db84f01301d7e875763/gtk-68631945733158f164427db84f01301d7e875763.tar.gz')
- BetterCompressionUri: version 2.24.20201220: line 13: better compression URI using extension '.tar.bz2' for 'https://gitlab.gnome.org/GNOME/gtk/-/archive/${SNAPSHOT}/gtk-${SNAPSHOT}.tar.gz'
- MissingInherits: version 2.24.20201220: xdg: missing inherit usage: 'xdg_pkg_preinst', line 90
- MissingSlash: version 2.24.20201220: ${EROOT} missing trailing slash on line: 106
- NonexistentDeps: version 2.24.20201220: PDEPEND: nonexistent package: app-tex/gtk-syntax
- NonsolvableDepsInStable: version 2.24.20201220: nonsolvable depset(pdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-tex/gtk-syntax ]
- UnknownUseFlags: version 2.24.20201220: unknown USE flags: 'introspection', 'vim-syntax', 'xinerama'
- VariableScope: version 2.24.20201220: variable 'EROOT' used in 'src_configure' on line: 80

## xgui-lib/qt5compat
- VisibleVcsPkg: version 6.10.9999: VCS version visible for KEYWORDS="amd64", profile core/amd64/glibc (16 total)

## xgui-lib/libva
- MissingRemoteId: missing <remote-id type="github">intel/libva</remote-id> (inferred from URI 'https://github.com/intel/libva/archive/271bd76ee6ada51e49236622049254e4a0550ab3.tar.gz')
- RequiredUseDefaults: version 20251127: profile: 'core/amd64/glibc' (8 total) failed REQUIRED_USE: ( drm || wayland || X )
- UnknownUseFlags: version 20251127: unknown USE flags: 'drm', 'utils'

## xgui-lib/libvdpau
- MissingRemoteId: missing <remote-id type="freedesktop-gitlab">vdpau/libvdpau</remote-id> (inferred from URI 'https://gitlab.freedesktop.org/vdpau/libvdpau/-/archive/2afa3f989af24a922692ac719fae23c321776cdb/libvdpau-2afa3f989af24a922692ac719fae23c321776cdb.tar.bz2')
- RedundantUriRename: version 20220603: redundant rename: https://gitlab.freedesktop.org/vdpau/libvdpau/-/archive/2afa3f989af24a922692ac719fae23c321776cdb/libvdpau-2afa3f989af24a922692ac719fae23c321776cdb.tar.bz2 -> libvdpau-2afa3f989af24a922692ac719fae23c321776cdb.tar.bz2
- UnknownUseFlags: version 20220603: unknown USE flag: 'dri'

## xgui-lib/xbitmaps
- MissingRemoteId: missing <remote-id type="freedesktop-gitlab">xorg/data/bitmaps</remote-id> (inferred from URI 'https://gitlab.freedesktop.org/xorg/data/bitmaps/-/archive/35307f27a4554f47534fe235be12128157888a7b/bitmaps-35307f27a4554f47534fe235be12128157888a7b.tar.bz2')
- RedundantUriRename: version 20250309: redundant rename: https://gitlab.freedesktop.org/xorg/data/bitmaps/-/archive/35307f27a4554f47534fe235be12128157888a7b/bitmaps-35307f27a4554f47534fe235be12128157888a7b.tar.bz2 -> bitmaps-35307f27a4554f47534fe235be12128157888a7b.tar.bz2

## xgui-lib/libxkbcommon
- MissingRemoteId: missing <remote-id type="github">xkbcommon/libxkbcommon</remote-id> (inferred from URI 'https://github.com/xkbcommon/libxkbcommon/archive/78de7906968db3065ab238abe9b0a523987c2eaf.tar.gz')

## xgui-lib/libxcvt
- MissingRemoteId: missing <remote-id type="freedesktop-gitlab">xorg/lib/libxcvt</remote-id> (inferred from URI 'https://gitlab.freedesktop.org/xorg/lib/libxcvt/-/archive/40de74eb5d7c402f82fe1f61beea515d17bcdd2a/libxcvt-40de74eb5d7c402f82fe1f61beea515d17bcdd2a.tar.bz2')
- RedundantUriRename: version 20251001: redundant rename: https://gitlab.freedesktop.org/xorg/lib/libxcvt/-/archive/40de74eb5d7c402f82fe1f61beea515d17bcdd2a/libxcvt-40de74eb5d7c402f82fe1f61beea515d17bcdd2a.tar.bz2 -> libxcvt-40de74eb5d7c402f82fe1f61beea515d17bcdd2a.tar.bz2

## xgui-lib/sbc
- MissingRemoteId: missing <remote-id type="github">1g4-mirror/sbc</remote-id> (inferred from URI 'https://github.com/1g4-mirror/sbc/archive/9b6c775f02b1ea944c8a203452ce23d7854e9187.tar.gz')
- WhitespaceFound: version 20250321: ebuild has leading whitespace on lines: 28, 29, 30, 31

## xgui-lib/qtx11extras
- VisibleVcsPkg: version 5.15.9999: VCS version visible for KEYWORDS="amd64", profile core/amd64/glibc (16 total)

## xgui-lib/wayland-protocols
- MissingRemoteId: missing <remote-id type="freedesktop-gitlab">wayland/wayland-protocols</remote-id> (inferred from URI 'https://gitlab.freedesktop.org/wayland/wayland-protocols/-/archive/6141e1154303dadd5c3e480bc4a16e26f1dcb2af/wayland-protocols-6141e1154303dadd5c3e480bc4a16e26f1dcb2af.tar.bz2')
- RedundantUriRename: version 20251123: redundant rename: https://gitlab.freedesktop.org/wayland/wayland-protocols/-/archive/6141e1154303dadd5c3e480bc4a16e26f1dcb2af/wayland-protocols-6141e1154303dadd5c3e480bc4a16e26f1dcb2af.tar.bz2 -> wayland-protocols-6141e1154303dadd5c3e480bc4a16e26f1dcb2af.tar.bz2

## xgui-lib/librsvg
- UnknownUseFlags: version 2.60.9999: unknown USE flag: 'introspection'
- VisibleVcsPkg: version 2.60.9999: VCS version visible for KEYWORDS="amd64", profile core/amd64/glibc (16 total)

## xgui-lib/qtshadertools
- VisibleVcsPkg: version 6.10.9999: VCS version visible for KEYWORDS="amd64", profile core/amd64/glibc (16 total)

## xgui-lib/pango
- MissingRemoteId: missing <remote-id type="gnome-gitlab">GNOME/pango</remote-id> (inferred from URI 'https://gitlab.gnome.org/GNOME/pango/-/archive/2fb8d7782ec0e166aeeb961402db8afae521d574/pango-2fb8d7782ec0e166aeeb961402db8afae521d574.tar.bz2')
- MissingTestRestrict: version 20251111: missing RESTRICT="!test? ( test )" with IUSE=test
- RedundantUriRename: version 20251111: redundant rename: https://gitlab.gnome.org/GNOME/pango/-/archive/2fb8d7782ec0e166aeeb961402db8afae521d574/pango-2fb8d7782ec0e166aeeb961402db8afae521d574.tar.bz2 -> pango-2fb8d7782ec0e166aeeb961402db8afae521d574.tar.bz2
- UnknownUseFlags: version 20251111: unknown USE flag: 'introspection'

## xgui-lib/wayland
- MissingRemoteId: missing <remote-id type="freedesktop-gitlab">wayland/wayland</remote-id> (inferred from URI 'https://gitlab.freedesktop.org/wayland/wayland')
- RedundantUriRename: version 1.24.20250706: redundant rename: https://gitlab.freedesktop.org/wayland/wayland/-/archive/736d12ac67c20c60dc406dc49bb06be878501f86/wayland-736d12ac67c20c60dc406dc49bb06be878501f86.tar.bz2 -> wayland-736d12ac67c20c60dc406dc49bb06be878501f86.tar.bz2

## xgui-lib/vte
- MissingRemoteId: missing <remote-id type="github">GNOME/vte</remote-id> (inferred from URI 'https://github.com/GNOME/vte')

## xgui-lib/xcb-util-m4
- MissingRemoteId: missing <remote-id type="freedesktop-gitlab">xorg/util/xcb-util-m4</remote-id> (inferred from URI 'https://gitlab.freedesktop.org/xorg/util/xcb-util-m4/-/archive/c617eee22ae5c285e79e81ec39ce96862fd3262f/xcb-util-m4-c617eee22ae5c285e79e81ec39ce96862fd3262f.tar.bz2')
- RedundantUriRename: version 20220701: redundant rename: https://gitlab.freedesktop.org/xorg/util/xcb-util-m4/-/archive/c617eee22ae5c285e79e81ec39ce96862fd3262f/xcb-util-m4-c617eee22ae5c285e79e81ec39ce96862fd3262f.tar.bz2 -> xcb-util-m4-c617eee22ae5c285e79e81ec39ce96862fd3262f.tar.bz2

## xgui-lib/libxkbfile
- MissingRemoteId: missing <remote-id type="freedesktop-gitlab">xorg/lib/libxkbfile</remote-id> (inferred from URI 'https://gitlab.freedesktop.org/xorg/lib/libxkbfile/-/archive/cb177c4d0e6d24dd868d28d4c35f3af007e7023e/libxkbfile-cb177c4d0e6d24dd868d28d4c35f3af007e7023e.tar.bz2')
- RedundantUriRename: version 20250913: redundant rename: https://gitlab.freedesktop.org/xorg/lib/libxkbfile/-/archive/cb177c4d0e6d24dd868d28d4c35f3af007e7023e/libxkbfile-cb177c4d0e6d24dd868d28d4c35f3af007e7023e.tar.bz2 -> libxkbfile-cb177c4d0e6d24dd868d28d4c35f3af007e7023e.tar.bz2

## xgui-lib/rgb
- MissingRemoteId: missing <remote-id type="freedesktop-gitlab">xorg/app/rgb</remote-id> (inferred from URI 'https://gitlab.freedesktop.org/xorg/app/rgb/-/archive/205369bca73f8bfe1476741f19ab9564ea538469/rgb-205369bca73f8bfe1476741f19ab9564ea538469.tar.bz2')
- RedundantUriRename: version 20250803: redundant rename: https://gitlab.freedesktop.org/xorg/app/rgb/-/archive/205369bca73f8bfe1476741f19ab9564ea538469/rgb-205369bca73f8bfe1476741f19ab9564ea538469.tar.bz2 -> rgb-205369bca73f8bfe1476741f19ab9564ea538469.tar.bz2

## xgui-lib/xdg-user-dirs
- MissingRemoteId: missing <remote-id type="freedesktop-gitlab">xdg/xdg-user-dirs</remote-id> (inferred from URI 'https://gitlab.freedesktop.org/xdg/xdg-user-dirs/-/archive/52e0e422d918062bae5feb39b7af038e9b1e5c0e/xdg-user-dirs-52e0e422d918062bae5feb39b7af038e9b1e5c0e.tar.bz2')
- DoubleEmptyLine: version 20250926: ebuild has unneeded empty line on lines: 33, 34
- RedundantUriRename: version 20250926: redundant rename: https://gitlab.freedesktop.org/xdg/xdg-user-dirs/-/archive/52e0e422d918062bae5feb39b7af038e9b1e5c0e/xdg-user-dirs-52e0e422d918062bae5feb39b7af038e9b1e5c0e.tar.bz2 -> xdg-user-dirs-52e0e422d918062bae5feb39b7af038e9b1e5c0e.tar.bz2

## xgui-lib/qtsvg
- VisibleVcsPkg: version 5.15.9999: VCS version visible for KEYWORDS="amd64", profile core/amd64/glibc (16 total)
- VisibleVcsPkg: version 6.10.9999: VCS version visible for KEYWORDS="amd64", profile core/amd64/glibc (16 total)

## xgui-lib/yajl
- MissingRemoteId: missing <remote-id type="github">lloyd/yajl</remote-id> (inferred from URI 'https://github.com/lloyd/yajl')

## xgui-lib/xdg-utils
- MissingRemoteId: missing <remote-id type="freedesktop-gitlab">xdg/xdg-utils</remote-id> (inferred from URI 'https://gitlab.freedesktop.org/xdg/xdg-utils/-/archive/73ca30c05b31f9309d94da3f239f4ce4a8efe210/xdg-utils-73ca30c05b31f9309d94da3f239f4ce4a8efe210.tar.bz2')
- RedundantUriRename: version 20251025: redundant rename: https://gitlab.freedesktop.org/xdg/xdg-utils/-/archive/73ca30c05b31f9309d94da3f239f4ce4a8efe210/xdg-utils-73ca30c05b31f9309d94da3f239f4ce4a8efe210.tar.bz2 -> xdg-utils-73ca30c05b31f9309d94da3f239f4ce4a8efe210.tar.bz2
- WhitespaceFound: version 20251025: ebuild has leading whitespace on lines: 35, 36

## xgui-lib/qtimageformats
- UnusedInherits: version 5.15.9999: unused eclass: flag-o-matic
- VisibleVcsPkg: version 5.15.9999: VCS version visible for KEYWORDS="amd64", profile core/amd64/glibc (16 total)
- VisibleVcsPkg: version 6.10.9999: VCS version visible for KEYWORDS="amd64", profile core/amd64/glibc (16 total)

## xgui-lib/wlroots
- MissingRemoteId: missing <remote-id type="freedesktop-gitlab">wlroots/wlroots</remote-id> (inferred from URI 'https://gitlab.freedesktop.org/wlroots/wlroots/-/archive/8c9e6b7c9f3c5344f456e97dc29dcd8d8a5f015b/wlroots-8c9e6b7c9f3c5344f456e97dc29dcd8d8a5f015b.tar.bz2')
- MissingRemoteId: missing <remote-id type="github">swaywm/wlroots</remote-id> (inferred from URI 'https://github.com/swaywm/wlroots')

## xgui-lib/xtrans
- MissingRemoteId: missing <remote-id type="freedesktop-gitlab">xorg/lib/libxtrans</remote-id> (inferred from URI 'https://gitlab.freedesktop.org/xorg/lib/libxtrans/-/archive/cf05ba4a10c90da2c63805a5375e983b174e28b0/libxtrans-cf05ba4a10c90da2c63805a5375e983b174e28b0.tar.bz2')
- RedundantUriRename: version 20250308: redundant rename: https://gitlab.freedesktop.org/xorg/lib/libxtrans/-/archive/cf05ba4a10c90da2c63805a5375e983b174e28b0/libxtrans-cf05ba4a10c90da2c63805a5375e983b174e28b0.tar.bz2 -> libxtrans-cf05ba4a10c90da2c63805a5375e983b174e28b0.tar.bz2

## xgui-lib/xcb-util-keysyms
- MissingRemoteId: missing <remote-id type="freedesktop-gitlab">xorg/lib/libxcb-keysyms</remote-id> (inferred from URI 'https://gitlab.freedesktop.org/xorg/lib/libxcb-keysyms/-/archive/72e9fc14ba16f9e1830d2f35919862abc53abcf3/libxcb-keysyms-72e9fc14ba16f9e1830d2f35919862abc53abcf3.tar.bz2')
- MissingTestRestrict: version 20250802: missing RESTRICT="!test? ( test )" with IUSE=test
- RedundantUriRename: version 20250802: redundant rename: https://gitlab.freedesktop.org/xorg/lib/libxcb-keysyms/-/archive/72e9fc14ba16f9e1830d2f35919862abc53abcf3/libxcb-keysyms-72e9fc14ba16f9e1830d2f35919862abc53abcf3.tar.bz2 -> libxcb-keysyms-72e9fc14ba16f9e1830d2f35919862abc53abcf3.tar.bz2
- VariableScope: version 20250802: variable 'EROOT' used in 'src_prepare' on line: 29

## xgui-lib/gtk4
- MissingRemoteId: missing <remote-id type="github">GNOME/gtk</remote-id> (inferred from URI 'https://github.com/GNOME/gtk/archive/68df8c35f5eb4f9348cd2d87d4b62454c3a69b34.tar.gz')
- ExcessiveLineLength: version 4.18.20250911: excessive line length (over 120 characters) on lines: 86, 87
- MissingTestRestrict: version 4.18.20250911: missing RESTRICT="!test? ( test )" with IUSE=test
- NonexistentDeps: version 4.18.20250911: IDEPEND: nonexistent package: app-dev/desktop-file-utils
- NonexistentDeps: version 4.18.20250911: PDEPEND: nonexistent package: app-tex/gtk-syntax
- NonsolvableDepsInStable: version 4.18.20250911: nonsolvable depset(idepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-dev/desktop-file-utils ]
- NonsolvableDepsInStable: version 4.18.20250911: nonsolvable depset(pdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-tex/gtk-syntax ]
- PythonMissingDeps: version 4.18.20250911: missing DEPEND="${PYTHON_DEPS}"
- RequiredUseDefaults: version 4.18.20250911: profile: 'core/amd64/glibc' (8 total) failed REQUIRED_USE: ( wayland || X )
- UnknownUseFlags: version 4.18.20250911: unknown USE flags: 'broadway', 'build-examples', 'build-tests', 'colord', 'demos', 'ffmpeg', 'introspection', 'sysprof', 'vim-syntax', 'vulkan', 'xinerama'

## xgui-lib/qtdeclarative
- VisibleVcsPkg: version 5.15.9999: VCS version visible for KEYWORDS="amd64", profile core/amd64/glibc (16 total)
- VisibleVcsPkg: version 6.10.9999: VCS version visible for KEYWORDS="amd64", profile core/amd64/glibc (16 total)

## xgui-lib/zimg
- MissingRemoteId: missing <remote-id type="github">sekrit-twc/zimg</remote-id> (inferred from URI 'https://github.com/sekrit-twc/zimg')

## xgui-lib/xcb-util-image
- MissingRemoteId: missing <remote-id type="freedesktop-gitlab">xorg/lib/libxcb-image</remote-id> (inferred from URI 'https://gitlab.freedesktop.org/xorg/lib/libxcb-image/-/archive/5ce46a7f14b88f6c69cdb5cba4cc106fbfd69402/libxcb-image-5ce46a7f14b88f6c69cdb5cba4cc106fbfd69402.tar.bz2')
- MissingTestRestrict: version 20250802: missing RESTRICT="!test? ( test )" with IUSE=test
- RedundantUriRename: version 20250802: redundant rename: https://gitlab.freedesktop.org/xorg/lib/libxcb-image/-/archive/5ce46a7f14b88f6c69cdb5cba4cc106fbfd69402/libxcb-image-5ce46a7f14b88f6c69cdb5cba4cc106fbfd69402.tar.bz2 -> libxcb-image-5ce46a7f14b88f6c69cdb5cba4cc106fbfd69402.tar.bz2
- VariableScope: version 20250802: variable 'EROOT' used in 'src_prepare' on line: 29

## xgui-lib/qtwayland
- UnusedInherits: version 5.15.9999: unused eclass: flag-o-matic
- VisibleVcsPkg: version 5.15.9999: VCS version visible for KEYWORDS="amd64", profile core/amd64/glibc (16 total)
- VisibleVcsPkg: version 6.10.9999: VCS version visible for KEYWORDS="amd64", profile core/amd64/glibc (16 total)

## xgui-misc/plasma-wayland-protocols
- MissingRemoteId: missing <remote-id type="github">KDE/plasma-wayland-protocols</remote-id> (inferred from URI 'https://github.com/KDE/plasma-wayland-protocols/archive/839e9590cd803b53a21c4ec08ca67ffd7b83641b.tar.gz')
- MissingRemoteId: missing <remote-id type="kde-invent">frameworks/plasma-wayland-protocols</remote-id> (inferred from URI 'https://invent.kde.org/frameworks/plasma-wayland-protocols')

## xgui-lib/qttools
- VisibleVcsPkg: version 5.15.9999: VCS version visible for KEYWORDS="amd64", profile core/amd64/glibc (16 total)
- VisibleVcsPkg: version 6.10.9999: VCS version visible for KEYWORDS="amd64", profile core/amd64/glibc (16 total)

## xgui-lib/xcb-util-renderutil
- MissingRemoteId: missing <remote-id type="freedesktop-gitlab">xorg/lib/libxcb-render-util</remote-id> (inferred from URI 'https://gitlab.freedesktop.org/xorg/lib/libxcb-render-util/-/archive/fb1c2524b9ac4e70930aa4dd94dde827e2a7c13f/libxcb-render-util-fb1c2524b9ac4e70930aa4dd94dde827e2a7c13f.tar.bz2')
- MissingTestRestrict: version 20250802: missing RESTRICT="!test? ( test )" with IUSE=test
- RedundantUriRename: version 20250802: redundant rename: https://gitlab.freedesktop.org/xorg/lib/libxcb-render-util/-/archive/fb1c2524b9ac4e70930aa4dd94dde827e2a7c13f/libxcb-render-util-fb1c2524b9ac4e70930aa4dd94dde827e2a7c13f.tar.bz2 -> libxcb-render-util-fb1c2524b9ac4e70930aa4dd94dde827e2a7c13f.tar.bz2
- VariableScope: version 20250802: variable 'EROOT' used in 'src_prepare' on line: 31

## xgui-lib/xcb-util-cursor
- MissingRemoteId: missing <remote-id type="freedesktop-gitlab">xorg/lib/libxcb-cursor</remote-id> (inferred from URI 'https://gitlab.freedesktop.org/xorg/lib/libxcb-cursor/-/archive/7b0fa99aa13084a9bf7be4180066f6a74b0adef1/libxcb-cursor-7b0fa99aa13084a9bf7be4180066f6a74b0adef1.tar.bz2')
- MissingTestRestrict: version 20250901: missing RESTRICT="!test? ( test )" with IUSE=test
- RedundantUriRename: version 20250901: redundant rename: https://gitlab.freedesktop.org/xorg/lib/libxcb-cursor/-/archive/7b0fa99aa13084a9bf7be4180066f6a74b0adef1/libxcb-cursor-7b0fa99aa13084a9bf7be4180066f6a74b0adef1.tar.bz2 -> libxcb-cursor-7b0fa99aa13084a9bf7be4180066f6a74b0adef1.tar.bz2
- VariableScope: version 20250901: variable 'EROOT' used in 'src_prepare' on line: 32

## xgui-lib/xcb-util-wm
- MissingRemoteId: missing <remote-id type="freedesktop-gitlab">xorg/lib/libxcb-wm</remote-id> (inferred from URI 'https://gitlab.freedesktop.org/xorg/lib/libxcb-wm/-/archive/53d99b9b942c8248e1f63299069c6a2bedb92b41/libxcb-wm-53d99b9b942c8248e1f63299069c6a2bedb92b41.tar.bz2')
- MissingTestRestrict: version 20250906: missing RESTRICT="!test? ( test )" with IUSE=test
- RedundantUriRename: version 20250906: redundant rename: https://gitlab.freedesktop.org/xorg/lib/libxcb-wm/-/archive/53d99b9b942c8248e1f63299069c6a2bedb92b41/libxcb-wm-53d99b9b942c8248e1f63299069c6a2bedb92b41.tar.bz2 -> libxcb-wm-53d99b9b942c8248e1f63299069c6a2bedb92b41.tar.bz2
- VariableScope: version 20250906: variable 'EROOT' used in 'src_prepare' on line: 29

## xgui-misc/shared-mime-info
- MissingRemoteId: missing <remote-id type="freedesktop-gitlab">xdg/shared-mime-info</remote-id> (inferred from URI 'https://gitlab.freedesktop.org/xdg/shared-mime-info/-/archive/381dba8e91427336b993e976ab1c785e6ece78f5/shared-mime-info-381dba8e91427336b993e976ab1c785e6ece78f5.tar.bz2')
- DoubleEmptyLine: version 20251029: ebuild has unneeded empty line on line: 13
- NonexistentDeps: version 20251029: IDEPEND: nonexistent package: app-dev/desktop-file-utils
- NonsolvableDepsInStable: version 20251029: nonsolvable depset(idepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-dev/desktop-file-utils ]
- RedundantUriRename: version 20251029: redundant rename: https://gitlab.freedesktop.org/xdg/shared-mime-info/-/archive/381dba8e91427336b993e976ab1c785e6ece78f5/shared-mime-info-381dba8e91427336b993e976ab1c785e6ece78f5.tar.bz2 -> shared-mime-info-381dba8e91427336b993e976ab1c785e6ece78f5.tar.bz2

## xgui-lib/qtmultimedia
- UnusedInherits: version 5.15.9999: unused eclass: flag-o-matic
- VisibleVcsPkg: version 5.15.9999: VCS version visible for KEYWORDS="amd64", profile core/amd64/glibc (16 total)
- VisibleVcsPkg: version 6.10.9999: VCS version visible for KEYWORDS="amd64", profile core/amd64/glibc (16 total)

## xgui-misc/wireplumber
- MissingRemoteId: missing <remote-id type="freedesktop-gitlab">pipewire/wireplumber</remote-id> (inferred from URI 'https://gitlab.freedesktop.org/pipewire/wireplumber')
- MissingRemoteId: missing <remote-id type="github">PipeWire/wireplumber</remote-id> (inferred from URI 'https://github.com/PipeWire/wireplumber/archive/beded0214d6d0b199e069a6b54b7f57994937b16.tar.gz')
- MissingTestRestrict: version 20251202: missing RESTRICT="!test? ( test )" with IUSE=test
- UnknownUseFlags: version 20251202: unknown USE flag: 'system-service'
- UnsortedKeywords: version 20251202: unsorted KEYWORDS: arm64, amd64

## xgui-misc/xkeyboard-config
- MissingRemoteId: missing <remote-id type="freedesktop-gitlab">xkeyboard-config/xkeyboard-config</remote-id> (inferred from URI 'https://gitlab.freedesktop.org/xkeyboard-config/xkeyboard-config/-/archive/8aa73d2c9a5a7391538c932e265f89c416b53138/xkeyboard-config-8aa73d2c9a5a7391538c932e265f89c416b53138.tar.bz2')
- RedundantUriRename: version 20251104: redundant rename: https://gitlab.freedesktop.org/xkeyboard-config/xkeyboard-config/-/archive/8aa73d2c9a5a7391538c932e265f89c416b53138/xkeyboard-config-8aa73d2c9a5a7391538c932e265f89c416b53138.tar.bz2 -> xkeyboard-config-8aa73d2c9a5a7391538c932e265f89c416b53138.tar.bz2

## xgui-lib/xcb-util
- MissingRemoteId: missing <remote-id type="freedesktop-gitlab">xorg/lib/libxcb-util</remote-id> (inferred from URI 'https://gitlab.freedesktop.org/xorg/lib/libxcb-util/-/archive/bdba930aaac6ee6f271133674b40f1a9d895c6d4/libxcb-util-bdba930aaac6ee6f271133674b40f1a9d895c6d4.tar.bz2')
- MissingTestRestrict: version 20250802: missing RESTRICT="!test? ( test )" with IUSE=test
- RedundantUriRename: version 20250802: redundant rename: https://gitlab.freedesktop.org/xorg/lib/libxcb-util/-/archive/bdba930aaac6ee6f271133674b40f1a9d895c6d4/libxcb-util-bdba930aaac6ee6f271133674b40f1a9d895c6d4.tar.bz2 -> libxcb-util-bdba930aaac6ee6f271133674b40f1a9d895c6d4.tar.bz2
- VariableScope: version 20250802: variable 'EROOT' used in 'src_prepare' on line: 37

## xgui-misc/xf86-input-libinput
- MissingRemoteId: missing <remote-id type="github">X11Libre/xf86-input-libinput</remote-id> (inferred from URI 'https://github.com/X11Libre/xf86-input-libinput/archive/1d7b5c81963b2e4fa5b12fc95f3a62dd69f1ec66.tar.gz')

## xgui-tools/extra-cmake-modules
- MissingRemoteId: missing <remote-id type="github">KDE/extra-cmake-modules</remote-id> (inferred from URI 'https://github.com/KDE/extra-cmake-modules/archive/f8447eb308c27724be2bcd3a0e8c2f4bd5d9f52f.tar.gz')

## xgui-lib/wxGTK
- MissingRemoteId: missing <remote-id type="github">wxWidgets/wxWidgets</remote-id> (inferred from URI 'https://github.com/wxWidgets/wxWidgets/archive/30e340f6dfdbe73a654b9b5e595e9654af7f094e.tar.gz')
- MissingUseDepDefault: version 3.2.20251203: DEPEND="xgui-lib/gtk3[aqua]": USE flag 'aqua' missing from package: [ xgui-lib/gtk3-3.24.20251202 ]
- MissingUseDepDefault: version 3.2.20251203: RDEPEND="xgui-lib/gtk3[aqua]": USE flag 'aqua' missing from package: [ xgui-lib/gtk3-3.24.20251202 ]
- NonexistentDeps: version 3.2.20251203: DEPEND: nonexistent package: xmedia-live-lib/libsdl
- NonexistentDeps: version 3.2.20251203: RDEPEND: nonexistent package: xmedia-live-lib/libsdl
- NonsolvableDepsInStable: version 3.2.20251203: nonsolvable depset(depend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ xgui-lib/gtk3[aqua], xmedia-live-lib/libsdl ]
- NonsolvableDepsInStable: version 3.2.20251203: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ xgui-lib/gtk3[aqua], xmedia-live-lib/libsdl ]
- UnknownUseFlags: version 3.2.20251203: unknown USE flag: 'aqua'

## xgui-tools/startup-notification
- MissingRemoteId: missing <remote-id type="freedesktop-gitlab">xdg/startup-notification</remote-id> (inferred from URI 'https://gitlab.freedesktop.org/xdg/startup-notification/-/archive/64eb585315cfb1fb4fe68c8f705956e9fed46545/startup-notification-64eb585315cfb1fb4fe68c8f705956e9fed46545.tar.bz2')
- RedundantUriRename: version 20240711: redundant rename: https://gitlab.freedesktop.org/xdg/startup-notification/-/archive/64eb585315cfb1fb4fe68c8f705956e9fed46545/startup-notification-64eb585315cfb1fb4fe68c8f705956e9fed46545.tar.bz2 -> startup-notification-64eb585315cfb1fb4fe68c8f705956e9fed46545.tar.bz2

## xgui-tools/util-macros
- MissingRemoteId: missing <remote-id type="freedesktop-gitlab">xorg/util/macros</remote-id> (inferred from URI 'https://gitlab.freedesktop.org/xorg/util/macros/-/archive/a9d71e3fd8e6758b70be31c586921bbbcd2a8449/macros-a9d71e3fd8e6758b70be31c586921bbbcd2a8449.tar.bz2')
- RedundantUriRename: version 20241113: redundant rename: https://gitlab.freedesktop.org/xorg/util/macros/-/archive/a9d71e3fd8e6758b70be31c586921bbbcd2a8449/macros-a9d71e3fd8e6758b70be31c586921bbbcd2a8449.tar.bz2 -> macros-a9d71e3fd8e6758b70be31c586921bbbcd2a8449.tar.bz2

## xgui-tools/xcb-util-xrm
- MissingRemoteId: missing <remote-id type="github">jopamo/xcb-util-xrm</remote-id> (inferred from URI 'https://github.com/jopamo/xcb-util-xrm/archive/15c9d4592b82e1b9bb84543644ca959c8361a18c.tar.gz')

## xgui-tools/iceauth
- MissingRemoteId: missing <remote-id type="freedesktop-gitlab">xorg/app/iceauth</remote-id> (inferred from URI 'https://gitlab.freedesktop.org/xorg/app/iceauth/-/archive/802964acbc6f04c738029eab4fd775b0d5aed765/iceauth-802964acbc6f04c738029eab4fd775b0d5aed765.tar.bz2')
- RedundantUriRename: version 20250426: redundant rename: https://gitlab.freedesktop.org/xorg/app/iceauth/-/archive/802964acbc6f04c738029eab4fd775b0d5aed765/iceauth-802964acbc6f04c738029eab4fd775b0d5aed765.tar.bz2 -> iceauth-802964acbc6f04c738029eab4fd775b0d5aed765.tar.bz2

## xgui-tools/mm-common
- MissingRemoteId: missing <remote-id type="gnome-gitlab">GNOME/mm-common</remote-id> (inferred from URI 'https://gitlab.gnome.org/GNOME/mm-common')
- PythonMissingDeps: version 9999: missing DEPEND="${PYTHON_DEPS}"
- VisibleVcsPkg: version 9999: VCS version visible for KEYWORDS="amd64", profile core/amd64/glibc (16 total)

## xgui-misc/sway
- MissingRemoteId: missing <remote-id type="github">swaywm/sway</remote-id> (inferred from URI 'https://github.com/swaywm/sway/archive/f4aba22582184c9a4a20fd7a9ffd70c63b4b393d.tar.gz')
- NonexistentDeps: version 20251128: DEPEND: nonexistent package: lib-core/libpcre
- NonsolvableDepsInStable: version 20251128: nonsolvable depset(depend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ lib-core/libpcre ]
- UnknownUseFlags: version 20251128: unknown USE flags: 'swaybg', 'swayidle', 'swaylock', 'tray', 'wallpapers'

## xgui-tools/alsa-plugins
- MissingRemoteId: missing <remote-id type="github">alsa-project/alsa-plugins</remote-id> (inferred from URI 'https://github.com/alsa-project/alsa-plugins/archive/52574cb5ccbb8b546df2759e4b341a20332269b6.tar.gz')
- UnknownUseFlags: version 20240610: unknown USE flags: 'ffmpeg', 'libsamplerate', 'pulseaudio'

## xgui-tools/xinit
- MissingRemoteId: missing <remote-id type="freedesktop-gitlab">xorg/app/xinit</remote-id> (inferred from URI 'https://gitlab.freedesktop.org/xorg/app/xinit/-/archive/e039b40052b66839d3df51cf3f129a399f2ada0f/xinit-e039b40052b66839d3df51cf3f129a399f2ada0f.tar.bz2')
- RedundantUriRename: version 20250422: redundant rename: https://gitlab.freedesktop.org/xorg/app/xinit/-/archive/e039b40052b66839d3df51cf3f129a399f2ada0f/xinit-e039b40052b66839d3df51cf3f129a399f2ada0f.tar.bz2 -> xinit-e039b40052b66839d3df51cf3f129a399f2ada0f.tar.bz2

## xgui-tools/kguiaddons
- MissingRemoteId: missing <remote-id type="github">KDE/kguiaddons</remote-id> (inferred from URI 'https://github.com/KDE/kguiaddons/archive/195ad7e81b3d6bca72faf975873d0ae18920408e.tar.gz')
- MissingRemoteId: missing <remote-id type="kde-invent">frameworks/kguiaddons</remote-id> (inferred from URI 'https://invent.kde.org/frameworks/kguiaddons')
- NonexistentDeps: version 5.20250907: IDEPEND: nonexistent package: app-dev/desktop-file-utils
- NonsolvableDepsInStable: version 5.20250907: nonsolvable depset(idepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-dev/desktop-file-utils ]

## xgui-tools/menu-cache
- MissingRemoteId: missing <remote-id type="github">lxde/menu-cache</remote-id> (inferred from URI 'https://github.com/lxde/menu-cache/archive/014ed4ce881fc3154c08e98e8d59c1b13c3f2f06.tar.gz')

## xgui-tools/xauth
- MissingRemoteId: missing <remote-id type="freedesktop-gitlab">xorg/app/xauth</remote-id> (inferred from URI 'https://gitlab.freedesktop.org/xorg/app/xauth/-/archive/1cb1d8e0284870a03970a0a45d1c8cfe7ec6a696/xauth-1cb1d8e0284870a03970a0a45d1c8cfe7ec6a696.tar.bz2')
- RedundantUriRename: version 20250518: redundant rename: https://gitlab.freedesktop.org/xorg/app/xauth/-/archive/1cb1d8e0284870a03970a0a45d1c8cfe7ec6a696/xauth-1cb1d8e0284870a03970a0a45d1c8cfe7ec6a696.tar.bz2 -> xauth-1cb1d8e0284870a03970a0a45d1c8cfe7ec6a696.tar.bz2

## xgui-tools/mkfontscale
- MissingRemoteId: missing <remote-id type="freedesktop-gitlab">xorg/app/mkfontscale</remote-id> (inferred from URI 'https://gitlab.freedesktop.org/xorg/app/mkfontscale/-/archive/9c9c8834dc4ce17d0e878a28d36ff5e736bddb9b/mkfontscale-9c9c8834dc4ce17d0e878a28d36ff5e736bddb9b.tar.bz2')
- RedundantUriRename: version 20250329: redundant rename: https://gitlab.freedesktop.org/xorg/app/mkfontscale/-/archive/9c9c8834dc4ce17d0e878a28d36ff5e736bddb9b/mkfontscale-9c9c8834dc4ce17d0e878a28d36ff5e736bddb9b.tar.bz2 -> mkfontscale-9c9c8834dc4ce17d0e878a28d36ff5e736bddb9b.tar.bz2

## xgui-tools/xcb-proto
- MissingRemoteId: missing <remote-id type="freedesktop-gitlab">xorg/proto/xcbproto</remote-id> (inferred from URI 'https://gitlab.freedesktop.org/xorg/proto/xcbproto/-/archive/283ead0904eb8c6350cef67dd638bb4a6b014c3a/xcbproto-283ead0904eb8c6350cef67dd638bb4a6b014c3a.tar.bz2')
- PythonMissingDeps: version 20251123: missing RDEPEND="${PYTHON_DEPS}"
- PythonMissingRequiredUse: version 20251123: missing REQUIRED_USE="${PYTHON_REQUIRED_USE}"
- RedundantUriRename: version 20251123: redundant rename: https://gitlab.freedesktop.org/xorg/proto/xcbproto/-/archive/283ead0904eb8c6350cef67dd638bb4a6b014c3a/xcbproto-283ead0904eb8c6350cef67dd638bb4a6b014c3a.tar.bz2 -> xcbproto-283ead0904eb8c6350cef67dd638bb4a6b014c3a.tar.bz2
- UnknownUseFlags: version 20251123: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## xgui-tools/xhost
- MissingRemoteId: missing <remote-id type="freedesktop-gitlab">xorg/app/xhost</remote-id> (inferred from URI 'https://gitlab.freedesktop.org/xorg/app/xhost/-/archive/1bf855ea7819c80f6cacacdedfac99c1a0c067ba/xhost-1bf855ea7819c80f6cacacdedfac99c1a0c067ba.tar.bz2')
- RedundantUriRename: version 20250415: redundant rename: https://gitlab.freedesktop.org/xorg/app/xhost/-/archive/1bf855ea7819c80f6cacacdedfac99c1a0c067ba/xhost-1bf855ea7819c80f6cacacdedfac99c1a0c067ba.tar.bz2 -> xhost-1bf855ea7819c80f6cacacdedfac99c1a0c067ba.tar.bz2

## xgui-tools/spirv-llvm-translator
- MissingRemoteId: missing <remote-id type="github">KhronosGroup/SPIRV-LLVM-Translator</remote-id> (inferred from URI 'https://github.com/KhronosGroup/SPIRV-LLVM-Translator')
- TrailingEmptyLine: version 21.20251120: ebuild has trailing blank line(s)
- UnusedInherits: version 21.20251120: unused eclass: multiprocessing

## xgui-tools/xkbcomp
- MissingRemoteId: missing <remote-id type="freedesktop-gitlab">xorg/app/xkbcomp</remote-id> (inferred from URI 'https://gitlab.freedesktop.org/xorg/app/xkbcomp/-/archive/2c7789785981ad1fce3858c726615b49293f7de0/xkbcomp-2c7789785981ad1fce3858c726615b49293f7de0.tar.bz2')
- RedundantUriRename: version 20251202: redundant rename: https://gitlab.freedesktop.org/xorg/app/xkbcomp/-/archive/2c7789785981ad1fce3858c726615b49293f7de0/xkbcomp-2c7789785981ad1fce3858c726615b49293f7de0.tar.bz2 -> xkbcomp-2c7789785981ad1fce3858c726615b49293f7de0.tar.bz2
- WhitespaceFound: version 20251202: ebuild has leading whitespace on line: 24

## xgui-tools/makedepend
- MissingRemoteId: missing <remote-id type="freedesktop-gitlab">xorg/util/makedepend</remote-id> (inferred from URI 'https://gitlab.freedesktop.org/xorg/util/makedepend/-/archive/9b71c14eb7e95ca550ecb9cad00147515dccbf1d/makedepend-9b71c14eb7e95ca550ecb9cad00147515dccbf1d.tar.bz2')
- RedundantUriRename: version 20250426: redundant rename: https://gitlab.freedesktop.org/xorg/util/makedepend/-/archive/9b71c14eb7e95ca550ecb9cad00147515dccbf1d/makedepend-9b71c14eb7e95ca550ecb9cad00147515dccbf1d.tar.bz2 -> makedepend-9b71c14eb7e95ca550ecb9cad00147515dccbf1d.tar.bz2

## xgui-tools/xrdb
- MissingRemoteId: missing <remote-id type="freedesktop-gitlab">xorg/app/xrdb</remote-id> (inferred from URI 'https://gitlab.freedesktop.org/xorg/app/xrdb/-/archive/20fc79a257ecaba0df3af8485dbf64fd73003a73/xrdb-20fc79a257ecaba0df3af8485dbf64fd73003a73.tar.bz2')
- RedundantUriRename: version 20250531: redundant rename: https://gitlab.freedesktop.org/xorg/app/xrdb/-/archive/20fc79a257ecaba0df3af8485dbf64fd73003a73/xrdb-20fc79a257ecaba0df3af8485dbf64fd73003a73.tar.bz2 -> xrdb-20fc79a257ecaba0df3af8485dbf64fd73003a73.tar.bz2

## xgui-tools/xorgproto
- MissingRemoteId: missing <remote-id type="freedesktop-gitlab">xorg/proto/xorgproto</remote-id> (inferred from URI 'https://gitlab.freedesktop.org/xorg/proto/xorgproto/-/archive/f973f7db89571f61e96cb0a55f416d3e67a75663/xorgproto-f973f7db89571f61e96cb0a55f416d3e67a75663.tar.bz2')
- RedundantUriRename: version 20251103: redundant rename: https://gitlab.freedesktop.org/xorg/proto/xorgproto/-/archive/f973f7db89571f61e96cb0a55f416d3e67a75663/xorgproto-f973f7db89571f61e96cb0a55f416d3e67a75663.tar.bz2 -> xorgproto-f973f7db89571f61e96cb0a55f416d3e67a75663.tar.bz2

## xgui-misc/pipewire
- MissingRemoteId: missing <remote-id type="github">PipeWire/pipewire</remote-id> (inferred from URI 'https://github.com/PipeWire/pipewire/archive/b68698a08618a684b5bf4a0bb4eb88162ec44dcd.tar.gz')
- NonexistentDeps: version 20251202: DEPEND: nonexistent package: media-libs/webrtc-audio-processing:0
- NonexistentDeps: version 20251202: RDEPEND: nonexistent package: media-libs/webrtc-audio-processing:0
- NonsolvableDepsInStable: version 20251202: nonsolvable depset(depend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ media-libs/webrtc-audio-processing:0 ]
- NonsolvableDepsInStable: version 20251202: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ media-libs/webrtc-audio-processing:0 ]
- PythonMissingDeps: version 20251202: missing DEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 20251202: unknown USE flags: 'bluez', 'echo-cancel', 'extra'
- UnsortedKeywords: version 20251202: unsorted KEYWORDS: arm64, amd64

## xmedia-app/alsa-ucm-conf
- MissingRemoteId: missing <remote-id type="github">alsa-project/alsa-ucm-conf</remote-id> (inferred from URI 'https://github.com/alsa-project/alsa-ucm-conf/archive/6ec48318d8b3afdc87f9fdd0ed9c6d9788868793.tar.gz')

## xgui-tools/acpid
- MissingRemoteId: missing <remote-id type="sourceforge">acpid2</remote-id> (inferred from URI 'https://downloads.sourceforge.net/acpid2/acpid-2.0.34.tar.xz')

## xgui-misc/pulseaudio
- MissingRemoteId: missing <remote-id type="github">pulseaudio/pulseaudio</remote-id> (inferred from URI 'https://github.com/pulseaudio/pulseaudio/archive/be2efb69b97ee49ba81094d49a1b8d7be0c588c2.tar.gz')
- ExcessiveLineLength: version 20251103: excessive line length (over 120 characters) on line: 51
- NonexistentDeps: version 20251103: DEPEND: nonexistent package: virtual/jack
- NonsolvableDepsInStable: version 20251103: nonsolvable depset(depend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ virtual/jack ]
- UnknownUseFlags: version 20251103: unknown USE flags: 'alsa-plugin', 'asyncns', 'bluez', 'fftw', 'jack', 'native-headset', 'samplerate'

## xgui-tools/alsa-lib
- MissingRemoteId: missing <remote-id type="github">alsa-project/alsa-lib</remote-id> (inferred from URI 'https://github.com/alsa-project/alsa-lib/archive/ebfc29110c3785a2656f2543e369ee1f41a34b5a.tar.gz')
- UnknownUseFlags: version 20251112: unknown USE flag: 'ucm'

## xgui-tools/xset
- MissingRemoteId: missing <remote-id type="freedesktop-gitlab">xorg/app/xset</remote-id> (inferred from URI 'https://gitlab.freedesktop.org/xorg/app/xset/-/archive/3fadaad29df656b69a64c463dd68dc35d09274b3/xset-3fadaad29df656b69a64c463dd68dc35d09274b3.tar.bz2')
- RedundantUriRename: version 20250531: redundant rename: https://gitlab.freedesktop.org/xorg/app/xset/-/archive/3fadaad29df656b69a64c463dd68dc35d09274b3/xset-3fadaad29df656b69a64c463dd68dc35d09274b3.tar.bz2 -> xset-3fadaad29df656b69a64c463dd68dc35d09274b3.tar.bz2

## xgui-tools/kwindowsystem
- MissingRemoteId: missing <remote-id type="github">KDE/kwindowsystem</remote-id> (inferred from URI 'https://github.com/KDE/kwindowsystem/archive/48ec9f56965d95ec429704d6a4b98865d8c7c39a.tar.gz')
- MissingRemoteId: missing <remote-id type="kde-invent">frameworks/kwindowsystem</remote-id> (inferred from URI 'https://invent.kde.org/frameworks/kwindowsystem')
- DoubleEmptyLine: version 6.20251115: ebuild has unneeded empty line on line: 34

## xmedia-app/exif
- MissingRemoteId: missing <remote-id type="github">libexif/exif</remote-id> (inferred from URI 'https://github.com/libexif/exif/archive/db941c5f1dd515dddb7f73af2235e2fb037d3c36.tar.gz')

## xmedia-app/jpegoptim
- MissingRemoteId: missing <remote-id type="github">tjko/jpegoptim</remote-id> (inferred from URI 'https://github.com/tjko/jpegoptim')

## xgui-tools/xdpyinfo
- MissingRemoteId: missing <remote-id type="freedesktop-gitlab">xorg/app/xdpyinfo</remote-id> (inferred from URI 'https://gitlab.freedesktop.org/xorg/app/xdpyinfo/-/archive/7fe49a22498b9438a15d5d9fdef55d5d832b1672/xdpyinfo-7fe49a22498b9438a15d5d9fdef55d5d832b1672.tar.bz2')
- NonexistentDeps: version 20250726: DEPEND: nonexistent packages: xgui-live-lib/libXxf86dga, xgui-live-lib/libdmx
- NonexistentDeps: version 20250726: RDEPEND: nonexistent packages: xgui-live-lib/libXxf86dga, xgui-live-lib/libdmx
- NonsolvableDepsInStable: version 20250726: nonsolvable depset(depend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ xgui-live-lib/libXxf86dga, xgui-live-lib/libdmx ]
- NonsolvableDepsInStable: version 20250726: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ xgui-live-lib/libXxf86dga, xgui-live-lib/libdmx ]
- RedundantUriRename: version 20250726: redundant rename: https://gitlab.freedesktop.org/xorg/app/xdpyinfo/-/archive/7fe49a22498b9438a15d5d9fdef55d5d832b1672/xdpyinfo-7fe49a22498b9438a15d5d9fdef55d5d832b1672.tar.bz2 -> xdpyinfo-7fe49a22498b9438a15d5d9fdef55d5d832b1672.tar.bz2
- UnknownUseFlags: version 20250726: unknown USE flags: 'dga', 'dmx', 'xinerama'

## xgui-tools/mesa
- MissingRemoteId: missing <remote-id type="freedesktop-gitlab">mesa/mesa</remote-id> (inferred from URI 'https://gitlab.freedesktop.org/mesa/mesa/-/archive/837dfb8d62cb95ca04ee3e26e953ee7068ea06db/mesa-837dfb8d62cb95ca04ee3e26e953ee7068ea06db.tar.gz')
- BetterCompressionUri: version 25.3.20251204: line 12: better compression URI using extension '.tar.bz2' for 'https://gitlab.freedesktop.org/mesa/mesa/-/archive/${SNAPSHOT}/mesa-${SNAPSHOT}.tar.gz'
- UnusedInherits: version 25.3.20251204: unused eclass: flag-o-matic

## xmedia-app/mp4box
- MissingRemoteId: missing <remote-id type="github">gpac/gpac</remote-id> (inferred from URI 'https://github.com/gpac/gpac/archive/a7de76e920737ce91a27f9794203030eed58159c.tar.gz')
- UnknownLicense: version 20251203: unknown license: LGPL
- UnknownUseFlags: version 20251203: unknown USE flags: 'static-bin', 'static-build', 'static-modules'

## xgui-lib/weston
- MissingRemoteId: missing <remote-id type="freedesktop-gitlab">wayland/weston</remote-id> (inferred from URI 'https://gitlab.freedesktop.org/wayland/weston')
- MissingTestRestrict: version 20251202: missing RESTRICT="!test? ( test )" with IUSE=test
- NonexistentDeps: version 20251202: DEPEND: nonexistent packages: >=app-net/freerdp-2.0.0_rc2:=, >=x11-misc/colord-0.1.27, x11-misc/xorg-server, xmedia-live-lib/gst-plugins-base:1.0, xmedia-live-lib/gstreamer:1.0
- NonexistentDeps: version 20251202: IDEPEND: nonexistent package: app-dev/desktop-file-utils
- NonexistentDeps: version 20251202: RDEPEND: nonexistent packages: >=app-net/freerdp-2.0.0_rc2:=, >=x11-misc/colord-0.1.27, x11-misc/xorg-server, xmedia-live-lib/gst-plugins-base:1.0, xmedia-live-lib/gstreamer:1.0
- NonsolvableDepsInStable: version 20251202: nonsolvable depset(depend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ >=app-net/freerdp-2.0.0_rc2:=, >=x11-misc/colord-0.1.27, x11-misc/xorg-server[wayland], xmedia-live-lib/gst-plugins-base:1.0, xmedia-live-lib/gstreamer:1.0 ]
- NonsolvableDepsInStable: version 20251202: nonsolvable depset(idepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-dev/desktop-file-utils ]
- NonsolvableDepsInStable: version 20251202: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ >=app-net/freerdp-2.0.0_rc2:=, >=x11-misc/colord-0.1.27, x11-misc/xorg-server[wayland], xmedia-live-lib/gst-plugins-base:1.0, xmedia-live-lib/gstreamer:1.0 ]
- RedundantUriRename: version 20251202: redundant rename: https://gitlab.freedesktop.org/wayland/weston/-/archive/cfb459c2c9788f4e706d72b7e724f1346335b1d4/weston-cfb459c2c9788f4e706d72b7e724f1346335b1d4.tar.bz2 -> weston-cfb459c2c9788f4e706d72b7e724f1346335b1d4.tar.bz2
- RequiredUseDefaults: version 20251202: profile: 'core/amd64/glibc' (8 total) failed REQUIRED_USE: ( drm || fbdev || headless || rdp || wayland-compositor || X )
- UnknownUseFlags: version 20251202: unknown USE flags: 'colord', 'desktop', 'drm', 'editor', 'fbdev', 'fullscreen', 'gles2', 'headless', 'ivi', 'launch', 'lcms', 'pipewire', 'rdp', 'remoting', 'resize-optimization', 'screen-sharing', 'suid', 'wayland-compositor', 'webp', 'xwayland'
- UnusedInherits: version 20251202: unused eclass: toolchain-funcs

## xgui-tools/xprop
- MissingRemoteId: missing <remote-id type="freedesktop-gitlab">xorg/app/xprop</remote-id> (inferred from URI 'https://gitlab.freedesktop.org/xorg/app/xprop/-/archive/55a51e08787035786abc27b170beb0faacb6cd47/xprop-55a51e08787035786abc27b170beb0faacb6cd47.tar.bz2')
- RedundantUriRename: version 20250809: redundant rename: https://gitlab.freedesktop.org/xorg/app/xprop/-/archive/55a51e08787035786abc27b170beb0faacb6cd47/xprop-55a51e08787035786abc27b170beb0faacb6cd47.tar.bz2 -> xprop-55a51e08787035786abc27b170beb0faacb6cd47.tar.bz2

## xgui-tools/xwininfo
- MissingRemoteId: missing <remote-id type="freedesktop-gitlab">xorg/app/xwininfo</remote-id> (inferred from URI 'https://gitlab.freedesktop.org/xorg/app/xwininfo/-/archive/af244681d8da641c06e4c1676630ebfdef86b288/xwininfo-af244681d8da641c06e4c1676630ebfdef86b288.tar.bz2')
- RedundantUriRename: version 20250724: redundant rename: https://gitlab.freedesktop.org/xorg/app/xwininfo/-/archive/af244681d8da641c06e4c1676630ebfdef86b288/xwininfo-af244681d8da641c06e4c1676630ebfdef86b288.tar.bz2 -> xwininfo-af244681d8da641c06e4c1676630ebfdef86b288.tar.bz2

## xmedia-lib/avisynth
- MissingRemoteId: missing <remote-id type="github">AviSynth/AviSynthPlus</remote-id> (inferred from URI 'https://github.com/AviSynth/AviSynthPlus/archive/bc81fb7ca4d32dcccfebe5cd772682c138f84e13.tar.gz')

## xmedia-app/audacious-plugins
- MissingRemoteId: missing <remote-id type="github">audacious-media-player/audacious-plugins</remote-id> (inferred from URI 'https://github.com/audacious-media-player/audacious-plugins/archive/b921fefc4cf757714222f166ebfae80f9de6224d.tar.gz')
- NonexistentDeps: version 20251130: DEPEND: nonexistent packages: app-var/lirc, lib-dev/libcdio-paranoia, virtual/jack, xmedia-live-app/fluidsynth, xmedia-live-app/wavpack, xmedia-live-lib/bio2jack, xmedia-live-lib/faad2, xmedia-live-lib/libcddb, xmedia-live-lib/libcue, xmedia-live-lib/libmms, xmedia-live-lib/libmodplug, xmedia-live-lib/libsdl2, xmedia-live-lib/libsidplayfp, xmedia-live-lib/soxr
- NonsolvableDepsInStable: version 20251130: nonsolvable depset(depend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-var/lirc, lib-dev/libcdio-paranoia, virtual/jack, xmedia-live-app/fluidsynth, xmedia-live-app/wavpack, xmedia-live-lib/bio2jack, xmedia-live-lib/faad2, xmedia-live-lib/libcddb, xmedia-live-lib/libcue, xmedia-live-lib/libmms, xmedia-live-lib/libmodplug, xmedia-live-lib/libsdl2[sound], xmedia-live-lib/libsidplayfp, xmedia-live-lib/soxr ]
- UnknownUseFlags: version 20251130: unknown USE flags: 'aac', 'aosd', 'cdda', 'cue', 'filewriter', 'flac', 'fluidsynth', 'gme', 'hotkeys', 'jack', 'libsamplerate', 'lirc', 'mms', 'modplug', 'opus', 'pipewire', 'pulseaudio', 'qt', 'scrobbler', 'sid', 'sndfile', 'soxr', 'speedpitch', 'vorbis', 'wavpack'

## xmedia-app/pngquant
- MissingRemoteId: missing <remote-id type="github">kornelski/pngquant</remote-id> (inferred from URI 'https://github.com/kornelski/pngquant')
- VisibleVcsPkg: version 9999: VCS version visible for KEYWORDS="amd64", profile core/amd64/glibc (16 total)

## xmedia-lib/fdk-aac
- MissingRemoteId: missing <remote-id type="github">mstorsjo/fdk-aac</remote-id> (inferred from URI 'https://github.com/mstorsjo/fdk-aac/archive/d8e6b1a3aa606c450241632b64b703f21ea31ce3.tar.gz')
- MissingRemoteId: missing <remote-id type="sourceforge">opencore-amr</remote-id> (inferred from URI 'https://sourceforge.net/projects/opencore-amr/')
- MissingLicenseRestricts: version 20250821: EULA license 'FraunhoferFDK' requires RESTRICT="bindist mirror"
- UnsortedKeywords: version 20250821: unsorted KEYWORDS: arm64, amd64

## xmedia-app/phototonic
- MissingRemoteId: missing <remote-id type="github">oferkv/phototonic</remote-id> (inferred from URI 'https://github.com/oferkv/phototonic')
- NonexistentDeps: version 20250113: IDEPEND: nonexistent package: app-dev/desktop-file-utils
- NonsolvableDepsInStable: version 20250113: nonsolvable depset(idepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-dev/desktop-file-utils ]

## xmedia-lib/flac
- MissingRemoteId: missing <remote-id type="github">xiph/flac</remote-id> (inferred from URI 'https://github.com/xiph/flac/archive/9547dbc2ddfca06a70ea937dbb605bbe78ea5f90.tar.gz')
- UnknownUseFlags: version 20250820: unknown USE flags: 'cpplibs', 'ogg'

## xmedia-lib/giflib
- MissingRemoteId: missing <remote-id type="github">bitbank2/giflib-turbo</remote-id> (inferred from URI 'https://github.com/bitbank2/giflib-turbo')

## xmedia-lib/ffmpegsource
- MissingRemoteId: missing <remote-id type="github">FFMS/ffms2</remote-id> (inferred from URI 'https://github.com/FFMS/ffms2')
- BadDescription: version 20251028: over 80 chars in length

## xmedia-lib/exiv2
- MissingRemoteId: missing <remote-id type="github">Exiv2/exiv2</remote-id> (inferred from URI 'https://github.com/Exiv2/exiv2/archive/afcb7a8ba84a7de36d2f1ee7689394e078697956.tar.gz')
- UnknownUseFlags: version 0.28.20250831: unknown USE flags: 'webready', 'xmp'

## xmedia-app/yt-dlp
- MissingRemoteId: missing <remote-id type="github">yt-dlp/yt-dlp</remote-id> (inferred from URI 'https://github.com/yt-dlp/yt-dlp')
- MisplacedEclassVar: version 9999: invalid pre-inherit placement, line 7: 'DISTUTILS_USE_PEP517=hatchling'
- NonexistentDeps: version 9999: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 9999: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 9999: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 9999: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 9999: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 9999: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'
- VisibleVcsPkg: version 9999: VCS version visible for KEYWORDS="amd64", profile core/amd64/glibc (16 total)

## xmedia-lib/ladspa-sdk
- UnusedInherits: version 1.17: unused eclass: flag-o-matic
- VariableOrderWrong: version 1.17: variable S should occur before KEYWORDS

## xmedia-app/ffmpeg-normalize
- MissingRemoteId: missing <remote-id type="github">slhck/ffmpeg-normalize</remote-id> (inferred from URI 'https://github.com/slhck/ffmpeg-normalize')
- DistutilsNonPEP517Build: version 20251109: uses deprecated non-PEP517 build mode, please switch to DISTUTILS_USE_PEP517=...
- NonexistentDeps: version 20251109: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 20251109: DEPEND: nonexistent package: dev-python/ffmpeg-progress-yield
- NonexistentDeps: version 20251109: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 20251109: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 20251109: nonsolvable depset(depend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ dev-python/ffmpeg-progress-yield[python_targets_python3_11(-),python_targets_python3_12(-),python_targets_python3_13(-),python_targets_python3_14(-)] ]
- NonsolvableDepsInStable: version 20251109: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 20251109: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 20251109: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'

## xmedia-lib/libfreeaptx
- MissingRemoteId: missing <remote-id type="github">regularhunter/libfreeaptx</remote-id> (inferred from URI 'https://github.com/regularhunter/libfreeaptx')
- UnsortedKeywords: version 20250305: unsorted KEYWORDS: arm64, amd64

## xmedia-lib/graphene
- MissingRemoteId: missing <remote-id type="github">ebassi/graphene</remote-id> (inferred from URI 'https://github.com/ebassi/graphene/archive/47b503d6086900057ceefab785546ad524caa735.tar.gz')
- PythonMissingDeps: version 20250122: missing DEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 20250122: unknown USE flag: 'introspection'
- UnusedInherits: version 20250122: unused eclass: xdg-utils

## xmedia-lib/libdav1d
- VisibleVcsPkg: version 9999: VCS version visible for KEYWORDS="amd64", profile core/amd64/glibc (16 total)

## xmedia-app/singleapplication
- MissingRemoteId: missing <remote-id type="github">itay-grudev/SingleApplication</remote-id> (inferred from URI 'https://github.com/itay-grudev/SingleApplication')
- NonexistentDeps: version 9999: IDEPEND: nonexistent package: app-dev/desktop-file-utils
- NonsolvableDepsInStable: version 9999: nonsolvable depset(idepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-dev/desktop-file-utils ]
- UnknownLicense: version 9999: unknown license: FreeArt
- VisibleVcsPkg: version 9999: VCS version visible for KEYWORDS="amd64", profile core/amd64/glibc (16 total)
- NonexistentDeps: version 9999-r9: IDEPEND: nonexistent package: app-dev/desktop-file-utils
- NonsolvableDepsInStable: version 9999-r9: nonsolvable depset(idepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-dev/desktop-file-utils ]
- UnknownLicense: version 9999-r9: unknown license: FreeArt
- VisibleVcsPkg: version 9999-r9: VCS version visible for KEYWORDS="amd64", profile core/amd64/glibc (16 total)

## xgui-tools/xorg-server
- MissingRemoteId: missing <remote-id type="github">X11Libre/xserver</remote-id> (inferred from URI 'https://github.com/X11Libre/xserver/archive/90f05e76c4dda782673eb473438e62464b804660.tar.gz')
- UnknownUseFlags: version 25.20251201: unknown USE flags: 'glamor', 'minimal', 'suid_wrapper', 'xcsecurity', 'xephyr', 'xvfb'
- WhitespaceFound: version 25.20251201: ebuild has leading whitespace on lines: 62, 63, 65, 66, 67, 68, 69, 70, 71, 72, 73, 75, 76, 77, 78, 79, 80, 82, 83, 84, 85, 86, 87, 89, 90, 91, 92, 93, 95, 96, 97, 98, 99, 100, 101, 102, 103, 104, 105, 107, 108, 109, 111, 112, 113, 114, 116, 117, 118, 119, 121, 122, 123, 124, 125, 126, 127, 129, 133

## xmedia-lib/libepoxy
- MissingRemoteId: missing <remote-id type="github">anholt/libepoxy</remote-id> (inferred from URI 'https://github.com/anholt/libepoxy')

## xmedia-lib/lame
- MissingUnpackerDep: version 3.6531: missing BDEPEND="app-arch/unzip" for SRC_URI archive: [ lame-svn-r6531-trunk.zip ]

## xmedia-lib/glu
- MissingRemoteId: missing <remote-id type="freedesktop-gitlab">mesa/glu</remote-id> (inferred from URI 'https://gitlab.freedesktop.org/mesa/glu/-/archive/a2b96c7bba8db8fec3e02fb4227a7f7b02cabad1/glu-a2b96c7bba8db8fec3e02fb4227a7f7b02cabad1.tar.bz2')
- RedundantUriRename: version 20230721: redundant rename: https://gitlab.freedesktop.org/mesa/glu/-/archive/a2b96c7bba8db8fec3e02fb4227a7f7b02cabad1/glu-a2b96c7bba8db8fec3e02fb4227a7f7b02cabad1.tar.bz2 -> glu-a2b96c7bba8db8fec3e02fb4227a7f7b02cabad1.tar.bz2

## xmedia-lib/l-smash
- MissingRemoteId: missing <remote-id type="github">l-smash/l-smash</remote-id> (inferred from URI 'https://github.com/l-smash/l-smash')
- VariableScope: version 20241028: variable 'ED' used in 'src_configure' on line: 36

## xmedia-lib/libglvnd
- MissingRemoteId: missing <remote-id type="github">NVIDIA/libglvnd</remote-id> (inferred from URI 'https://github.com/NVIDIA/libglvnd')

## xgui-lib/qtbase
- BadDependency: version 5.15.9999: ':=' operator is invalid in: PDEPEND="xgui-lib/qtsvg:5="
- BadDependency: version 5.15.9999: ':=' operator is invalid in: PDEPEND="xgui-lib/qttools:5="
- BadDependency: version 5.15.9999: ':=' operator is invalid in: PDEPEND="xgui-lib/qtx11extras:5="
- UnknownUseFlags: version 5.15.9999: unknown USE flags: 'gssapi', 'keep-la', 'mysql', 'postgres', 'vulkan', 'xkbcommon'
- UnusedInherits: version 5.15.9999: unused eclass: qmake-utils
- VisibleVcsPkg: version 5.15.9999: VCS version visible for KEYWORDS="amd64", profile core/amd64/glibc (16 total)
- WhitespaceFound: version 5.15.9999: ebuild has leading whitespace on lines: 102, 103
- UnknownUseFlags: version 6.10.9999: unknown USE flags: 'gssapi', 'mysql', 'postgres', 'vulkan', 'xkbcommon'
- VisibleVcsPkg: version 6.10.9999: VCS version visible for KEYWORDS="amd64", profile core/amd64/glibc (16 total)
- WhitespaceFound: version 6.10.9999: ebuild has leading whitespace on lines: 84, 85

## xmedia-lib/libogg
- MissingRemoteId: missing <remote-id type="github">xiph/ogg</remote-id> (inferred from URI 'https://github.com/xiph/ogg/archive/0288fadac3ac62d453409dfc83e9c4ab617d2472.tar.gz')
- UnknownUseFlags: version 20250707: unknown USE flag: 'keep-la'

## xmedia-lib/libldac
- MissingRemoteId: missing <remote-id type="github">EHfive/ldacBT</remote-id> (inferred from URI 'https://github.com/EHfive/ldacBT')
- UnsortedKeywords: version 20250110: unsorted KEYWORDS: arm64, amd64
- VariableShadowed: version 20250110: variable 'SRC_URI' may be shadowed, on lines: 12, 14

## xmedia-lib/libmediainfo
- MissingRemoteId: missing <remote-id type="github">MediaArea/MediaInfoLib</remote-id> (inferred from URI 'https://github.com/MediaArea/MediaInfoLib')
- UnknownUseFlags: version 20251203: unknown USE flag: 'keep-la'

## xmedia-lib/libexif
- MissingRemoteId: missing <remote-id type="github">libexif/libexif</remote-id> (inferred from URI 'https://github.com/libexif/libexif/archive/619f4e5181c41c4ac3e0637059d377b7dc1aaa38.tar.gz')
- NonexistentDeps: version 20251203: DEPEND: nonexistent package: app-tex/doxygen
- NonsolvableDepsInStable: version 20251203: nonsolvable depset(depend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-tex/doxygen ]
- VariableOrderWrong: version 20251203: variable LICENSE should occur before KEYWORDS

## xmedia-lib/libpng
- MissingRemoteId: missing <remote-id type="github">pnggroup/libpng</remote-id> (inferred from URI 'https://github.com/pnggroup/libpng/archive/0441becac5befce801b5c8503c4c467540e0d1e0.tar.gz')
- UnknownUseFlags: version 20251203: unknown USE flag: 'keep-la'

## xmedia-lib/libsdl3
- MissingRemoteId: missing <remote-id type="github">libsdl-org/SDL</remote-id> (inferred from URI 'https://github.com/libsdl-org/SDL/archive/b8618dd4051de66542e2ea228e55ed482fbcc5d7.tar.gz')

## xmedia-lib/libsamplerate
- MissingRemoteId: missing <remote-id type="github">libsndfile/libsamplerate</remote-id> (inferred from URI 'https://github.com/libsndfile/libsamplerate/archive/2ccde9568cca73c7b32c97fefca2e418c16ae5e3.tar.gz')
- UnknownUseFlags: version 20250907: unknown USE flags: 'keep-la', 'sndfile'

## xmedia-lib/libsdl3-gfx
- MissingRemoteId: missing <remote-id type="github">sabdul-khabir/SDL3_gfx</remote-id> (inferred from URI 'https://github.com/sabdul-khabir/SDL3_gfx/archive/27b177ba86f13ea3c106c26fcd48169f482a10e1.tar.gz')

## xmedia-lib/jbig2dec
- MissingRemoteId: missing <remote-id type="github">ArtifexSoftware/jbig2dec</remote-id> (inferred from URI 'https://github.com/ArtifexSoftware/jbig2dec/archive/6ecb04980813d693234190021bd1cf874c05b1b4.tar.gz')
- MissingTestRestrict: version 20240715: missing RESTRICT="!test? ( test )" with IUSE=test
- WhitespaceFound: version 20240715: ebuild has leading whitespace on lines: 36, 37, 38, 39, 48, 49, 50, 51, 52, 53

## xmedia-lib/libvorbis
- MissingRemoteId: missing <remote-id type="github">xiph/vorbis</remote-id> (inferred from URI 'https://github.com/xiph/vorbis/archive/851cce991da34adf5e1f3132588683758a6369ec.tar.gz')

## xmedia-lib/libass
- MissingRemoteId: missing <remote-id type="github">libass/libass</remote-id> (inferred from URI 'https://github.com/libass/libass')

## xmedia-lib/openh264
- MissingRemoteId: missing <remote-id type="github">cisco/openh264</remote-id> (inferred from URI 'https://github.com/cisco/openh264/archive/cf568c83f71a18778f9a16e344effaf40c11b752.tar.gz')

## xmedia-lib/obuparse
- MissingRemoteId: missing <remote-id type="github">dwbuiten/obuparse</remote-id> (inferred from URI 'https://github.com/dwbuiten/obuparse')
- WhitespaceFound: version 20250828: ebuild has leading whitespace on line: 28

## xmedia-lib/libwebp
- MissingRemoteId: missing <remote-id type="github">webmproject/libwebp</remote-id> (inferred from URI 'https://github.com/webmproject/libwebp/archive/934b7d7448c2d2850be9fa3aa4a924d51fff9823.tar.gz')
- TrailingEmptyLine: version 20251202: ebuild has trailing blank line(s)
- UnknownUseFlags: version 20251202: unknown USE flag: 'keep-la'

## xmedia-lib/glad
- MissingRemoteId: missing <remote-id type="github">Dav1dde/glad</remote-id> (inferred from URI 'https://github.com/Dav1dde/glad/archive/27bed1181560211b55e39a9b132fef8c5846aae5.tar.gz')
- NonexistentDeps: version 20251027: BDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 20251027: RDEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonsolvableDepsInStable: version 20251027: nonsolvable depset(bdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- NonsolvableDepsInStable: version 20251027: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ app-lang/python:3.11, app-lang/python:3.12, app-lang/python:3.14 ]
- PythonMissingDeps: version 20251027: missing RDEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 20251027: unknown USE flags: 'python_targets_python3_11', 'python_targets_python3_12', 'python_targets_python3_13', 'python_targets_python3_14'
- UnsortedKeywords: version 20251027: unsorted KEYWORDS: arm64, amd64

## xmedia-lib/taglib
- MissingRemoteId: missing <remote-id type="github">taglib/taglib</remote-id> (inferred from URI 'https://github.com/taglib/taglib/archive/9c042984d26af605a6fd1dac7f12bda05219fee7.tar.gz')

## xmedia-lib/speexdsp
- MissingRemoteId: missing <remote-id type="github">xiph/speexdsp</remote-id> (inferred from URI 'https://github.com/xiph/speexdsp/archive/7a158783df74efe7c2d1c6ee8363c1e695c71226.tar.gz')
- UnknownUseFlags: version 20250705: unknown USE flag: 'keep-la'

## xmedia-lib/sof
- MissingRemoteId: missing <remote-id type="github">thesofproject/sof-bin</remote-id> (inferred from URI 'https://github.com/thesofproject/sof-bin/releases/download/v2025.05.1/sof-bin-2025.05.1.tar.gz')
- UnknownUseFlags: version 2025.05.1: unknown USE flag: 'tools'

## xmedia-lib/uchardet
- MissingRemoteId: missing <remote-id type="freedesktop-gitlab">uchardet/uchardet</remote-id> (inferred from URI 'https://gitlab.freedesktop.org/uchardet/uchardet/-/archive/06029ec3340cdf6bf9a6a537dafb3f39eda0560e/uchardet-06029ec3340cdf6bf9a6a537dafb3f39eda0560e.tar.bz2')
- MissingTestRestrict: version 20250808: missing RESTRICT="!test? ( test )" with IUSE=test
- RedundantUriRename: version 20250808: redundant rename: https://gitlab.freedesktop.org/uchardet/uchardet/-/archive/06029ec3340cdf6bf9a6a537dafb3f39eda0560e/uchardet-06029ec3340cdf6bf9a6a537dafb3f39eda0560e.tar.bz2 -> uchardet-06029ec3340cdf6bf9a6a537dafb3f39eda0560e.tar.bz2

## xmedia-lib/qhull
- MissingRemoteId: missing <remote-id type="github">qhull/qhull</remote-id> (inferred from URI 'https://github.com/qhull/qhull/archive/d1c2fc0caa5f644f3a0f220290d4a868c68ed4f6.tar.gz')
- MissingInherits: version 20250907: dot-a: missing inherit usage: 'strip-lto-bytecode "${ED}/usr/$(get_libdir)/libqhull"{static,static_r,cpp}.a', line 65
- UnknownKeywords: version 20250907: unknown KEYWORDS: 'arm', 'ppc', 'ppc64', 'x86', '~alpha', '~amd64-linux', '~arm64-macos', '~hppa', '~loong', '~ppc-macos', '~riscv', '~s390', '~sparc', '~x64-macos', '~x86-linux'
- UnknownUseFlags: version 20250907: unknown USE flag: 'tools'
- WhitespaceFound: version 20250907: ebuild has trailing whitespace on line: 5

## xmedia-lib/libjpeg-turbo
- MissingRemoteId: missing <remote-id type="github">libjpeg-turbo/libjpeg-turbo</remote-id> (inferred from URI 'https://github.com/libjpeg-turbo/libjpeg-turbo/archive/826a4f86f746c32833a21d8d35bc4a7707b5dec3.tar.gz')

## xmedia-lib/opus
- MissingRemoteId: missing <remote-id type="github">xiph/opus</remote-id> (inferred from URI 'https://github.com/xiph/opus/archive/d38db32cffb00460dc52543ba3e07ab16c2bf380.tar.gz')

## xmedia-app/ffmpeg
- MissingRemoteId: missing <remote-id type="github">FFmpeg/FFmpeg</remote-id> (inferred from URI 'https://github.com/FFmpeg/FFmpeg/archive/7b2ae2ccf79954fb7d3e3a668e0bd50bd512040d.tar.gz')
- BadDescription: version 8.0.20251203: over 80 chars in length
- ExcessiveLineLength: version 8.0.20251203: excessive line length (over 120 characters) on line: 180
- IndirectInherits: version 8.0.20251203: toolchain-funcs: indirect inherit usage: 'tc-getCC', line 77
- NonexistentDeps: version 8.0.20251203: DEPEND: nonexistent package: xgui-lib/libva-intel-driver
- NonsolvableDepsInStable: version 8.0.20251203: nonsolvable depset(depend) keyword(amd64) stable profile (core/amd64/glibc) (8 total): solutions: [ xgui-lib/libva-intel-driver ]
- NonsolvableDepsInStable: version 8.0.20251203: nonsolvable depset(depend) keyword(arm64) stable profile (core/arm64/glibc) (8 total): solutions: [ bin/nvidia-cuda, xgui-lib/libva-intel-driver ]
- UnknownUseFlags: version 8.0.20251203: unknown USE flags: 'avcodec', 'avdevice', 'avfilter', 'avformat', 'avutil', 'ffmpeg', 'gpl', 'lame', 'libass', 'libdav1d', 'libxcb', 'network', 'nonfree', 'nvidia', 'openssl', 'opus', 'postproc', 'protocols', 'pulseaudio', 'swresample', 'swscale', 'vdpau', 'version3', 'vorbis', 'vpx', 'vulkan', 'x264', 'x265'
- UnquotedVariable: version 8.0.20251203: unquoted variable S on line: 186
- BadDescription: version 20251204: over 80 chars in length
- ExcessiveLineLength: version 20251204: excessive line length (over 120 characters) on line: 59
- IndirectInherits: version 20251204: toolchain-funcs: indirect inherit usage: 'tc-getCC', line 54
- NonexistentDeps: version 20251204: DEPEND: nonexistent package: xgui-lib/libva-intel-driver
- UnknownUseFlags: version 20251204: unknown USE flags: 'avcodec', 'avdevice', 'avfilter', 'avformat', 'avutil', 'ffmpeg', 'gpl', 'lame', 'libass', 'libdav1d', 'libxcb', 'network', 'nonfree', 'nvidia', 'openssl', 'postproc', 'protocols', 'pulseaudio', 'swresample', 'swscale', 'vdpau', 'version3', 'vorbis', 'vulkan', 'x264', 'x265'
- UnquotedVariable: version 20251204: unquoted variable S on line: 48
- WhitespaceFound: version 20251204: ebuild has leading whitespace on lines: 21, 58, 59

## xmedia-lib/libzen
- MissingRemoteId: missing <remote-id type="github">MediaArea/ZenLib</remote-id> (inferred from URI 'https://github.com/MediaArea/ZenLib')
- UnknownUseFlags: version 20251129: unknown USE flag: 'keep-la'

## xmedia-lib/vapoursynth
- MissingRemoteId: missing <remote-id type="github">vapoursynth/vapoursynth</remote-id> (inferred from URI 'https://github.com/vapoursynth/vapoursynth/archive/1b93fd9649d4420b64863de9226e6e751ba2ba9d.tar.gz')
- BadDefaultUseFlags: version 20251125: bad default USE flags: '-debug', '-guard', '-static-libs'
- UnknownUseFlags: version 20251125: unknown USE flags: 'guard', 'shared', 'vspipe'
- UnusedInherits: version 20251125: unused eclass: flag-o-matic

## xmedia-lib/libplacebo
- MissingRemoteId: missing <remote-id type="github">haasn/libplacebo</remote-id> (inferred from URI 'https://github.com/haasn/libplacebo/archive/53719e45d264d90d422f51e1fa21a2957131bf1a.tar.gz')
- NonexistentDeps: version 20251128: DEPEND: nonexistent package: lib-util/libunwind
- NonexistentDeps: version 20251128: RDEPEND: nonexistent package: lib-util/libunwind
- NonsolvableDepsInStable: version 20251128: nonsolvable depset(depend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ lib-util/libunwind ]
- NonsolvableDepsInStable: version 20251128: nonsolvable depset(rdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ lib-util/libunwind ]
- PythonMissingDeps: version 20251128: missing DEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 20251128: unknown USE flags: 'lcms', 'llvm-libunwind', 'shaderc', 'unwind', 'vulkan', 'xxhash'

## xmedia-lib/shaderc
- MissingRemoteId: missing <remote-id type="github">google/shaderc</remote-id> (inferred from URI 'https://github.com/google/shaderc')

## xmedia-lib/openjpeg
- MissingRemoteId: missing <remote-id type="github">uclouvain/openjpeg</remote-id> (inferred from URI 'https://github.com/uclouvain/openjpeg/archive/1ad9bec2c12ee445ce23e660f5e4fe870b9d5e09.tar.gz')
- AbsoluteSymlink: version 20250926: dosym called with absolute path on line 42: dosym /usr/include/openjpeg-2.5/opj_config.h
- AbsoluteSymlink: version 20250926: dosym called with absolute path on line 43: dosym /usr/include/openjpeg-2.5/openjpeg.h
- AbsoluteSymlink: version 20250926: dosym called with absolute path on line 44: dosym /usr/include/openjpeg-2.5/opj_stdint.h

## xmedia-lib/nv-codec-headers
- MissingRemoteId: missing <remote-id type="github">FFmpeg/nv-codec-headers</remote-id> (inferred from URI 'https://github.com/FFmpeg/nv-codec-headers/archive/876af32a202d0de83bd1d36fe74ee0f7fcf86b0d.tar.gz')

## xmedia-lib/tiff
- MissingRemoteId: missing <remote-id type="gitlab">libtiff/libtiff</remote-id> (inferred from URI 'https://gitlab.com/libtiff/libtiff/-/archive/4b4f8277eebf1ffe93f33bce70ffac84e59ab19c/libtiff-4b4f8277eebf1ffe93f33bce70ffac84e59ab19c.tar.bz2')
- MissingTestRestrict: version 20251129: missing RESTRICT="!test? ( test )" with IUSE=test
- NonexistentDeps: version 20251129: DEPEND: nonexistent package: >=xmedia-live-lib/jbigkit-2.1:=
- NonsolvableDepsInStable: version 20251129: nonsolvable depset(depend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ >=xmedia-live-lib/jbigkit-2.1:= ]
- RedundantUriRename: version 20251129: redundant rename: https://gitlab.com/libtiff/libtiff/-/archive/4b4f8277eebf1ffe93f33bce70ffac84e59ab19c/libtiff-4b4f8277eebf1ffe93f33bce70ffac84e59ab19c.tar.bz2 -> libtiff-4b4f8277eebf1ffe93f33bce70ffac84e59ab19c.tar.bz2
- UnknownUseFlags: version 20251129: unknown USE flags: 'cxx', 'jbig', 'keep-la', 'webp'
- UnusedInherits: version 20251129: unused eclass: libtool

## xmedia-lib/x265
- MissingRemoteId: missing <remote-id type="bitbucket">multicoreware/x265_git</remote-id> (inferred from URI 'https://bitbucket.org/multicoreware/x265_git/get/9e551a994f970a24f0e49bcebe3d43ef08448b01.zip')
- BadFilename: version 20251114: bad filename: [ 9e551a994f970a24f0e49bcebe3d43ef08448b01.zip ]
- MissingUnpackerDep: version 20251114: missing BDEPEND="app-arch/unzip" for SRC_URI archive: [ 9e551a994f970a24f0e49bcebe3d43ef08448b01.zip ]

## xmedia-lib/libvpx
- MissingRemoteId: missing <remote-id type="github">webmproject/libvpx</remote-id> (inferred from URI 'https://github.com/webmproject/libvpx/archive/98a119c2c67d41f6354281f2cb719c8229c30601.tar.gz')
- MissingTestRestrict: version 20251203: missing RESTRICT="!test? ( test )" with IUSE=test

## xmedia-lib/x264
- UnknownUseFlags: version 20250909: unknown USE flags: 'ffmpeg', 'ffmpegsource', 'interlaced', 'lsmash', 'opencl', 'pic'

## xmedia-lib/vulkan-loader
- MissingRemoteId: missing <remote-id type="github">KhronosGroup/Vulkan-Loader</remote-id> (inferred from URI 'https://github.com/KhronosGroup/Vulkan-Loader')
- NonexistentDeps: version 20251201: DEPEND: nonexistent packages: app-lang/python:3.11, app-lang/python:3.12
- NonexistentDeps: version 20251201: PDEPEND: nonexistent package: xmedia-live-lib/vulkan-layers
- NonsolvableDepsInStable: version 20251201: nonsolvable depset(pdepend) keyword(amd64) stable profile (core/amd64/glibc) (16 total): solutions: [ xmedia-live-lib/vulkan-layers ]
- PythonMissingDeps: version 20251201: missing DEPEND="${PYTHON_DEPS}"
- UnknownUseFlags: version 20251201: unknown USE flag: 'layers'
- UnusedInherits: version 20251201: unused eclasses: flag-o-matic, toolchain-funcs

## eclass
- EclassDocError: alternatives: failed parsing eclass docs: '@ECLASS: alternatives.eclass': missing tag: '@MAINTAINER:'
- EclassDocMissingFunc: alternatives: undocumented functions: _alternatives_ln_supports_relative, _alternatives_run_for_vars, _alternatives_sort_desc
- EclassDocError: autotools: failed parsing eclass docs: '@ECLASS: autotools.eclass': missing tag: '@MAINTAINER:'
- EclassDocMissingFunc: autotools: undocumented functions: _at_uses_autoheader, _at_uses_automake, _at_uses_gettext, _at_uses_glibgettext, _at_uses_gnomedoc, _at_uses_gtkdoc, _at_uses_intltool, _at_uses_libltdl, _at_uses_libtool, _at_uses_pkg, _autotools_m4dir_include, _elibtoolize, autotools_check_macro, autotools_check_macro_val, autotools_m4dir_include, autotools_m4sysdir_include, autotools_run_tool, config_rpath_update, eaclocal, eaclocal_amflags, eautoconf, eautoheader, eautomake, eautopoint, eautoreconf
- EclassDocMissingVar: autotools: undocumented variables: ALL_AUTOTOOLS_MACROS, AM_OPTS, AT_M4DIR, AT_NOEAUTOHEADER, AT_NOEAUTOMAKE, AT_NOELIBTOOLIZE, AT_SYS_M4DIR, AUTOTOOLS_AUTO_DEPEND, AUTOTOOLS_DEPEND, GNUCONFIG_AUTO_DEPEND
- EclassDocError: cargo: failed parsing eclass docs: '@ECLASS: cargo.eclass': missing tags: '@BLURB:', '@MAINTAINER:'
- EclassDocError: cargo: failed parsing eclass docs: '@SUPPORTED_EAPIS:', line 4: non-inline arg
- EclassDocMissingVar: cargo: undocumented variables: ECARGO_HOME, ECARGO_VENDOR
- EclassDocError: cmake: failed parsing eclass docs: '@ECLASS: cmake.eclass': missing tag: '@MAINTAINER:'
- EclassDocError: crossdev: failed parsing eclass docs: '@ECLASS: crossdev.eclass': missing tag: '@MAINTAINER:'
- EclassDocMissingVar: crossdev: undocumented variables: CBUILD, CTARGET
- EclassDocMissingFunc: distutils-r1: undocumented function: get_modname
- EclassDocError: doins: failed parsing eclass docs: '@DESCRIPTION:', line 6: invalid inline arg
- EclassDocError: doins: failed parsing eclass docs: '@DESCRIPTION:', line 6: missing args
- EclassDocError: doins: failed parsing eclass docs: '@ECLASS: doins.eclass': missing tag: '@MAINTAINER:'
- EclassDocMissingFunc: doins: undocumented functions: _bash-completion-r1_get_bashdir, bashcomp_alias, dobashcomp, dosysusers, dotmpfiles, get_bashcompdir, get_udevdir, make_wrapper, newbashcomp, newsysusers, newtmpfiles, systemd_dounit, systemd_douserunit, systemd_enable_service, systemd_get_systemunitdir, systemd_get_userunitdir, systemd_newunit, systemd_newuserunit, systemd_update_catalog, sysusers_process, tmpfiles_process, udev_dorules, udev_newrules, udev_reload
- EclassDocMissingVar: doins: undocumented variable: EAPI
- EclassDocError: emoji: failed parsing eclass docs: '@ECLASS: emoji.eclass': missing tags: '@BLURB:', '@MAINTAINER:'
- EclassDocMissingFunc: emoji: undocumented functions: _log, clr, detect_emoji_support, emoji_init, log_err, log_info, log_ok, log_warn, set_emoji_vars
- EclassDocMissingVar: emoji: undocumented variable: rst
- EclassDocError: flag-o-matic: failed parsing eclass docs: '@ECLASS: flag-o-matic.eclass': missing tags: '@BLURB:', '@MAINTAINER:'
- EclassDocMissingFunc: flag-o-matic: undocumented functions: _filter-hardened, _filter-var, _is_flagq, _test-flag-PROG, _test-flags-PROG, all-flag-vars, append-atomic-flags, append-cflags, append-cppflags, append-cxxflags, append-fflags, append-flags, append-ldflags, append-lfs-flags, append-libs, filter-clang, filter-defs, filter-flags, filter-gcc, filter-ldflags, filter-lfs-flags, filter-lto, filter-mfpmath, filter-sanitizers, get-flag, is-flag, is-flagq, is-ldflag, is-ldflagq, no-as-needed, raw-ldflags, replace-cpu-flags, replace-flags, setup-allowed-flags, strip-flags, strip-unsupported-flags, test-compile, test-flag-CC, test-flag-CCLD, test-flag-CXX, test-flag-F77, test-flag-FC, test-flag-PROG, test-flags, test-flags-CC, test-flags-CCLD, test-flags-CXX, test-flags-F77, test-flags-FC, test-flags-PROG, test_version_info
- EclassDocError: font: failed parsing eclass docs: '@ECLASS: font.eclass': missing tags: '@BLURB:', '@MAINTAINER:'
- EclassDocMissingFunc: font: undocumented functions: _update_fontcache, font_cleanup_dirs, font_fontconfig, font_wrap_opentype_compat, font_xfont_config
- EclassDocMissingVar: font: undocumented variables: FONTDIR, FONT_CONF, FONT_PN, FONT_SUFFIX
- EclassDocMissingFunc: git-r3: undocumented functions: git-r3_pkg_needrebuild, git-r3_src_fetch, pkg_needrebuild
- EclassDocError: gnuconfig: failed parsing eclass docs: '@ECLASS: gnuconfig.eclass': missing tags: '@BLURB:', '@MAINTAINER:'
- EclassDocError: gnuconfig: failed parsing eclass docs: '@FUNCTION:', line 83: non-inline arg
- EclassDocError: gnuconfig: failed parsing eclass docs: '@FUNCTION::gnuconfig_do_update', @RETURN or @DESCRIPTION required
- EclassDocError: gnuconfig: failed parsing eclass docs: '@FUNCTION::gnuconfig_findnewest', @RETURN or @DESCRIPTION required
- EclassDocError: gnuconfig: failed parsing eclass docs: '@FUNCTION::gnuconfig_update', @RETURN or @DESCRIPTION required
- EclassDocError: gnuconfig: failed parsing eclass docs: '@INTERNAL', line 46: tag takes no args, got 'Copies the newest version of each specified file from gnuconfig_findnewest'
- EclassDocError: gnuconfig: failed parsing eclass docs: '@USAGE:', line 24: non-inline arg
- EclassDocMissingVar: gnuconfig: undocumented variables: GNUCONFIG_AUTO_DEPEND, GNUCONFIG_DEPEND
- EclassDocError: go-env: failed parsing eclass docs: '@ECLASS:' block missing
- EclassDocMissingFunc: go-env: undocumented functions: go-env_goarch, go-env_set_compile_environment
- EclassDocMissingVar: go-module: undocumented variables: GO111MODULE, GOFLAGS, QA_FLAGS_IGNORED
- EclassReservedName: go-module: variable name "EBUILD" is disallowed because "ebuild" is a reserved substring
- EclassDocError: kernel-2: failed parsing eclass docs: '@ECLASS: kernel-2.eclass': missing tag: '@MAINTAINER:'
- EclassDocError: kernel-2: failed parsing eclass docs: '@FUNCTION::kernel-2_src_prepare', @RETURN or @DESCRIPTION required
- EclassDocMissingFunc: kernel-2: undocumented functions: env_setup_kernel_makeopts, kernel_header_destdir
- EclassDocMissingVar: kernel-2: undocumented variable: LINUX_HOSTCFLAGS
- EclassDocError: kernel-mod: failed parsing eclass docs: '@ECLASS:' block missing
- EclassDocMissingFunc: kernel-mod: undocumented functions: _modules_check_function, _modules_check_migration, _modules_prepare_kernel, _modules_prepare_sign, _modules_prepare_toolchain, _modules_process_compress, _modules_process_dracut.conf.d, _modules_process_sign, _modules_process_strip, _modules_sanity_gccplugins, _modules_sanity_kernelbuilt, _modules_sanity_kernelversion, _modules_sanity_modversion, _modules_set_makeargs, _modules_update_depmod, linux_domodule, linux_moduleinto, modules_post_process
- EclassDocMissingVar: kernel-mod: undocumented variable: MODULES_SIGN_CERT
- EclassExportFuncsBeforeInherit: kernel-mod: EXPORT_FUNCTIONS (line 522) called before inherit (line 11)
- EclassDocError: libtool: failed parsing eclass docs: '@ECLASS: libtool.eclass': missing tags: '@BLURB:', '@MAINTAINER:'
- EclassDocMissingVar: libtool: undocumented variables: LIBTOOL_AUTO_DEPEND, LIBTOOL_DEPEND
- EclassDocMissingFunc: perl-functions: undocumented functions: perl_get_wikiurl_features, perl_get_wikiurl_tests
- EclassDocMissingVar: perl-functions: undocumented variable: perlinfo_done
- EclassDocMissingVar: perl-module: undocumented variables: DIST_P, GENTOO_PERL_DEPSTRING, GENTOO_PERL_USESTRING, PREFER_BUILDPL, pm_echovar
- EclassDocMissingVar: python-any-r1: undocumented variable: PYTHON_REQUIRED_USE
- EclassDocMissingVar: python-utils-r1: undocumented variable: PYTHON_COMPAT
- EclassDocError: qmake-utils: failed parsing eclass docs: '@ECLASS: qmake-utils.eclass': missing tag: '@MAINTAINER:'
- EclassDocMissingFunc: qmake-utils: undocumented functions: eqmake5, eqmake6, qt5_get_bindir, qt5_get_headerdir, qt5_get_libdir, qt5_get_mkspecsdir, qt5_get_plugindir, qt5_get_qmake_args, qt6_get_bindir, qt6_get_headerdir, qt6_get_libdir, qt6_get_mkspecsdir, qt6_get_plugindir, qt6_get_qmake_args
- EclassDocError: rebar: failed parsing eclass docs: '@ECLASS: rebar.eclass': missing tag: '@MAINTAINER:'
- EclassDocMissingFunc: rebar: undocumented functions: _rebar_find_dep, erebar
- EclassDocError: rebar-utils: failed parsing eclass docs: '@ECLASS: rebar-utils.eclass': missing tag: '@MAINTAINER:'
- EclassDocMissingFunc: rebar-utils: undocumented functions: _rebar_find_dep, get_erl_libs, rebar_disable_coverage, rebar_fix_include_path, rebar_remove_deps, rebar_set_vsn
- EclassDocMissingVar: rebar-utils: undocumented variable: REBAR_APP_SRC
- EclassDocError: rust-toolchain: failed parsing eclass docs: '@ECLASS: rust-toolchain.eclass': missing tag: '@MAINTAINER:'
- EclassDocError: rust-toolchain: failed parsing eclass docs: '@FUNCTION:', line 15: non-inline arg
- EclassDocError: rust-toolchain: failed parsing eclass docs: '@FUNCTION:', line 28: non-inline arg
- EclassDocError: rust-toolchain: failed parsing eclass docs: '@FUNCTION:', line 39: non-inline arg
- EclassDocError: rust-toolchain: failed parsing eclass docs: '@FUNCTION::rust_abi', @RETURN or @DESCRIPTION required
- EclassDocError: rust-toolchain: failed parsing eclass docs: '@FUNCTION::rust_all_arch_uris', @RETURN or @DESCRIPTION required
- EclassDocError: rust-toolchain: failed parsing eclass docs: '@FUNCTION::rust_arch_uri', @RETURN or @DESCRIPTION required
- EclassDocMissingVar: rust-toolchain: undocumented variable: RUST_TOOLCHAIN_BASEURL
- EclassDocError: sgml-catalog-r1: failed parsing eclass docs: '@ECLASS: sgml-catalog-r1.eclass': missing tag: '@MAINTAINER:'
- EclassDocMissingFunc: sgml-catalog-r1: undocumented functions: sgml-catalog-r1_update_catalog, sgml-catalog-r1_update_env
- EclassDocMissingFunc: toolchain-funcs: undocumented functions: _clang_fullversion, _gcc-install-dir, _gcc-specs-directive_raw, _gcc-specs-exists, _gcc_fullversion, _tc-getPROG, gcc-specs-directive, gcc-specs-nostrict, gcc-specs-now, gcc-specs-pie, gcc-specs-relro, gcc-specs-ssp, gcc-specs-ssp-to-all, gcc-specs-stack-check, tc-getBUILD_PROG, tc-getPROG, tc-ninja_magic_to_arch
- EclassDocError: tree-sitter-grammar: failed parsing eclass docs: '@ECLASS: tree-sitter-grammar.eclass': missing tag: '@MAINTAINER:'
- EclassDocMissingFunc: tree-sitter-grammar: undocumented functions: _get_tsg_abi_ver, _tree-sitter-grammar_legacy_compile
- EclassDocError: unpacker: failed parsing eclass docs: '@BLURB:', line 5: non-inline arg
- EclassDocError: unpacker: failed parsing eclass docs: '@ECLASS: unpacker.eclass': missing tag: '@MAINTAINER:'
- EclassDocError: unpacker: failed parsing eclass docs: '@ECLASS_VARIABLE: UNPACKER_BZ2': missing tag: '@DESCRIPTION:'
- EclassDocError: unpacker: failed parsing eclass docs: '@ECLASS_VARIABLE: UNPACKER_LZIP': missing tag: '@DESCRIPTION:'
- EclassDocError: unpacker: failed parsing eclass docs: '@USER_VARIABLE', line 28: tag takes no args, got 'Utility used to decompress bzip2 files.  Auto-detects lbzip2/pbzip2/bzip2.'
- EclassDocError: unpacker: failed parsing eclass docs: '@USER_VARIABLE', line 34: tag takes no args, got 'Utility used to decompress lzip files.  Auto-detects xz/plzip/pdlzip/lzip.'
- EclassDocMissingFunc: unpacker: undocumented functions: _unpacker, _unpacker_get_decompressor, find_unpackable_file, unpack_7z, unpack_banner, unpack_cpio, unpack_deb, unpack_gpkg, unpack_lha, unpack_pdv, unpack_rar, unpack_zip, unpacker, unpacker_src_uri_depends
- EclassReservedName: unpacker: variable name "PORTAGE_BUNZIP2_COMMAND" is disallowed because "portage" is a reserved substring
- EclassReservedName: unpacker: variable name "PORTAGE_BZIP2_COMMAND" is disallowed because "portage" is a reserved substring
- EclassDocError: user: failed parsing eclass docs: '@ECLASS: user.eclass': missing tag: '@MAINTAINER:'
- EclassDocMissingFunc: user: undocumented functions: _esafe_usermod, _user_assert_pkg_phase, enewgroup, enewuser, esetcomment, esetgroups, esethome, esetshell, user_get_nologin
- EclassDocError: user-info: failed parsing eclass docs: '@ECLASS: user-info.eclass': missing tag: '@MAINTAINER:'
- EclassDocMissingFunc: user-info: undocumented functions: egetcomment, egetent, egetgroupname, egetgroups, egethome, egetshell, egetusername
- EclassDocError: wrapper: failed parsing eclass docs: '@ECLASS: wrapper.eclass': missing tag: '@MAINTAINER:'
- EclassDocError: xdg: failed parsing eclass docs: '@ECLASS: xdg.eclass': missing tag: '@MAINTAINER:'
- EclassDocMissingFunc: xdg: undocumented function: _xdg_do_updates
- EclassDocError: xdg-utils: failed parsing eclass docs: '@ECLASS: xdg-utils.eclass': missing tag: '@MAINTAINER:'
- EclassDocMissingFunc: xdg-utils: undocumented functions: _xdg_assert_post, _xdg_have, xdg_desktop_database_update, xdg_environment_reset, xdg_icon_cache_update, xdg_mimeinfo_database_update
- EclassDocMissingVar: xdg-utils: undocumented variables: DESKTOP_DATABASE_DIR, MIMEINFO_DATABASE_DIR

## profiles
- OutdatedProfilePackage: 'core/package.use': outdated package entry: 'lib-net/nodejs', last match removed 3.95 years ago
- OutdatedProfilePackage: 'core/package.use.force': outdated package entry: 'lib-net/nodejs', last match removed 3.95 years ago
- OutdatedProfilePackage: 'features/gui/package.use': outdated package entry: 'app-kernel/kernel-bin', last match removed 0.12 years ago
- OutdatedProfilePackage: 'features/libc/musl/package.mask': outdated package entry: '=lib-core/gdbm-1.25', last match removed 0.44 years ago
- UnknownCategoryDirs: unknown category dir: distfiles
- UnknownProfilePackage: 'features/gui/package.use': unknown package: 'xgui-live-app/wine'
- UnknownProfilePackage: 'features/gui/package.use': unknown package: 'xmedia-live-app/avidemux'
- UnknownProfilePackageUse: 'core/package.use': unknown package USE flag: 'app-emu/radare2[system-capstone]'
- UnknownProfilePackageUse: 'core/package.use': unknown package USE flag: 'app-fs/cryptsetup[-ssl]'
- UnknownProfilePackageUse: 'core/package.use': unknown package USE flag: 'lib-core/libxml2[python]'
- UnknownProfilePackageUse: 'core/package.use': unknown package USE flag: 'lib-core/sqlite[tempstore]'
- UnknownProfilePackageUse: 'core/package.use': unknown package USE flags: 'app-core/util-linux[suid, tty-helpers, liblastlog2, lscpu, pam]'
- UnknownProfilePackageUse: 'features/gui/package.use': unknown package USE flag: 'app-core/systemd[sleep]'
- UnknownProfilePackageUse: 'features/gui/package.use': unknown package USE flag: 'xgui-app/qbittorrent[qt5]'
- UnknownProfilePackageUse: 'features/libc/musl/package.use': unknown package USE flags: 'app-net/openssh[-utmpx, -wtmpx]'
- UnknownProfileUse: 'core/amd64/make.defaults': unknown USE flag: 'abi_x86_64'
- UnknownProfileUse: 'core/amd64/use.force': unknown USE flag: 'abi_x86_64'
- UnknownProfileUse: 'core/arm64/use.force': unknown USE flags: 'cpu_flags_arm_edsp', 'cpu_flags_arm_neon', 'cpu_flags_arm_thumb', 'cpu_flags_arm_thumb2', 'cpu_flags_arm_v4', 'cpu_flags_arm_v5', 'cpu_flags_arm_v6', 'cpu_flags_arm_v7', 'cpu_flags_arm_v8', 'cpu_flags_arm_vfp', 'cpu_flags_arm_vfp-d32', 'cpu_flags_arm_vfpv3', 'cpu_flags_arm_vfpv4'
- UnknownProfileUse: 'core/arm64/use.mask': unknown USE flags: '-cpu_flags_arm_aes', '-cpu_flags_arm_crc32', '-cpu_flags_arm_edsp', '-cpu_flags_arm_neon', '-cpu_flags_arm_sha1', '-cpu_flags_arm_sha2', '-cpu_flags_arm_thumb', '-cpu_flags_arm_thumb2', '-cpu_flags_arm_v4', '-cpu_flags_arm_v5', '-cpu_flags_arm_v6', '-cpu_flags_arm_v7', '-cpu_flags_arm_v8', '-cpu_flags_arm_vfp', '-cpu_flags_arm_vfp-d32', '-cpu_flags_arm_vfpv3', '-cpu_flags_arm_vfpv4'
- UnknownProfileUse: 'core/make.defaults': unknown USE flags: '#', '&', '(opt', '/', 'Components', 'Compression', 'Core', 'Crypto', 'DHCP', 'Default', 'Disabled', 'Drivers', 'Firmware', 'Helpers', 'Kernel', 'Libraries', 'Networking', 'OS', 'Runtimes', 'Security', 'Storage', 'System', 'Wireless', 'arches', 'argon2', 'asm', 'attr', 'blkid', 'bpf', 'bsdtar', 'by', 'cxx', 'device-mapper', 'dhcp', 'dhcp-tools', 'dhcp4', 'doh', 'dvbpsi', 'efi', 'elf', 'enable', 'gcrypt', 'gnutls', 'gshadow', 'in', 'intel', 'ipc', 'isl', 'iwlwifi', 'jit', 'kmod', 'kvm', 'libcap', 'libxcrypt', 'localed', 'machined', 'manpager', 'mediatek', 'mount', 'mpfr', 'native-extensions', 'needed', 'not', 'numa', 'on', 'only', 'per-package)', 'pie', 'prefer', 'problematic', 'pstore', 'regex', 'required', 'rtl_nic', 'scp', 'servers', 'some', 'static-pie', 'sysusersd', 'tcl', 'urandom', 'utmpx', 'uuid', 'where', 'wtmpx', 'xdp', 'xxhash', 'yescrypt', '──', '─────────', '──────────────────────', '────────────────────────────', '─────────────────────────────', '──────────────────────────────', '───────────────────────────────', '────────────────────────────────'
- UnknownProfileUse: 'core/use.force': unknown USE flag: 'userland_GNU'
- UnknownProfileUse: 'core/use.mask': unknown USE flags: 'abi_x86_32', 'abi_x86_64', 'abi_x86_x32', 'x86'
- UnknownProfileUse: 'features/gui/make.defaults': unknown USE flags: 'alsa-plugin', 'amd-ucode', 'autotype', 'bin', 'bluez', 'dhcp4', 'dri', 'drm', 'efi', 'egl', 'exif', 'extra-tools', 'flac', 'fontconfig', 'glamor', 'gles2', 'hwdb', 'i915', 'intel', 'iwlwifi', 'jpeg2k', 'kmod', 'kvm', 'ladspa', 'lcms', 'libinput', 'libsamplerate', 'machined', 'mount', 'ncat', 'networkd', 'nmtui', 'npm', 'pic', 'pipewire', 'poppler', 'postscript', 'pstore', 'pulseaudio', 'qemu_softmmu_targets_aarch64', 'qemu_softmmu_targets_x86_64', 'qemu_user_targets_aarch64', 'qemu_user_targets_x86_64', 'qml', 'qt', 'rfkill', 'rtl_nic', 'scp', 'shaderc', 'spirv', 'timedated', 'ucm', 'user-namespaces', 'video', 'vst', 'wasm', 'webp', 'xdg', 'xkb', 'xkbcommon'
- UnknownProfileUse: 'features/libc/musl/use.force': unknown USE flags: '-gshadow', '-vtv'
- UnknownProfileUse: 'features/libc/musl/use.mask': unknown USE flags: 'gshadow', 'vtv'
- UnknownProfileUseExpand: 'core/amd64/make.defaults': unknown USE_EXPAND groups in 'USE_EXPAND_HIDDEN': ABI_X86, CPU_FLAGS_X86
- UnknownProfileUseExpand: 'core/arm64/make.defaults': unknown USE_EXPAND group in 'USE_EXPAND_HIDDEN': CPU_FLAGS_ARM
- UnknownProfileUseExpand: 'core/make.defaults': unknown USE_EXPAND groups in 'USE_EXPAND': ABI_X86, CPU_FLAGS_ARM, CPU_FLAGS_X86, CURL_SSL, GRUB_PLATFORMS, PYTHON_SINGLE_TARGET, PYTHON_TARGETS
- UnknownProfileUseExpand: 'core/make.defaults': unknown USE_EXPAND groups in 'USE_EXPAND_HIDDEN': ABI_X86, CPU_FLAGS_ARM, CPU_FLAGS_X86

