# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic toolchain-funcs

DESCRIPTION="Library for build EFI Applications"
HOMEPAGE="https://sourceforge.net/projects/gnu-efi/"
SNAPSHOT=dccdf84a2312512e3cd99b648992bc56c384faca
SRC_URI="https://github.com/ncroxon/gnu-efi/archive/${SNAPSHOT}.tar.gz -> gnu-efi-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/gnu-efi-${SNAPSHOT}"

LICENSE="GPL-2+ BSD BSD-2"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="custom-cflags"

QA_EXECSTACK="usr/*/lib*efi.a:* usr/*/crt*.o"
RESTRICT="strip"

DOCS="README* SECURITY* docs/*"

src_prepare() {
	default
	sed -i -e "s/-Werror//" Make.defaults || die
}

efimake() {
	local arch=
	case ${CHOST} in
		arm*) arch=arm ;;
		aarch64*) arch=aarch64 ;;
		ia64*) arch=ia64 ;;
		i?86*) arch=ia32 ;;
		loongarch64*) arch=loongarch64 ;;
		riscv64*) arch=riscv64;;
		x86_64*) arch=x86_64 ;;
		*) die "Unknown CHOST" ;;
	esac

	local args=(
		ARCH="${arch}"
		HOSTCC="${BUILD_CC}"
		CC="${CC}"
		AS="${AS}"
		LD="${LD}"
		AR="${AR}"
		OBJCOPY="${OBJCOPY}"
		PREFIX="${EPREFIX}/usr"
		LIBDIR='$(PREFIX)'/lib
	)
	emake -j1 "${args[@]}" "$@"
}

src_compile() {
	tc-export BUILD_CC AR AS CC LD OBJCOPY

	if ! use custom-cflags; then
		unset CFLAGS CPPFLAGS LDFLAGS
	fi

	# work around musl: include first the compiler include dir, then the system one
	# bug #933080, #938012
	local CPPINCLUDEDIR
	if tc-is-gcc; then
		CPPINCLUDEDIR=$(LC_ALL=C ${CC} -print-search-dirs 2> /dev/null | grep ^install: | cut -f2 -d' ')/include
	elif tc-is-clang; then
		CPPINCLUDEDIR=$(LC_ALL=C ${CC} -print-resource-dir 2> /dev/null)/include
	fi
	append-cflags "-nostdinc -isystem ${CPPINCLUDEDIR} -isystem ${ESYSROOT}/usr/include"

	efimake
}

src_install() {
	efimake INSTALLROOT="${D}" install
}
