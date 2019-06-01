# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit flag-o-matic toolchain-funcs

DESCRIPTION="Library for build EFI Applications"
HOMEPAGE="http://gnu-efi.sourceforge.net/"
SRC_URI="mirror://sourceforge/gnu-efi/${P}.tar.bz2"

LICENSE="GPL-2+ BSD BSD-2"
SLOT="0/1"
KEYWORDS="amd64 arm64"

IUSE="-custom-cflags"

DEPEND="sys-app/pciutils"

# These objects get run early boot (i.e. not inside of Linux),
# so doing these QA checks on them doesn't make sense.
QA_EXECSTACK="usr/*/lib*efi.a:* usr/*/crt*.o"
RESTRICT="strip"

src_prepare() {
	sed -i -e "s/-Werror//" Make.defaults || die
	default
}

efimake() {
	local arch=
	case ${CHOST} in
		aarch64*) arch=aarch64 ;;
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
		PREFIX="${EPREFIX}/usr"
		LIBDIR='$(PREFIX)'/lib64
	)
	emake -j1 "${args[@]}" "$@"
}

src_compile() {
	tc-export BUILD_CC AR AS CC LD

	if use custom-cflags; then
		# https://bugs.gentoo.org/607992
		filter-mfpmath sse

		# https://bugs.gentoo.org/619628
		append-flags $(test-flags-CC -mno-avx)
	else
		unset CFLAGS CPPFLAGS LDFLAGS
	fi

	efimake
}

src_install() {
	efimake INSTALLROOT="${D}" install
}
