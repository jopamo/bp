# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs flag-o-matic

DESCRIPTION="UASM is a free MASM-compatible assembler"
HOMEPAGE="https://www.terraspace.co.uk/uasm.html"

SNAPSHOT=540d2159360fac5d3c2ac5efbeb15e0fcf869756
SRC_URI="https://github.com/Terraspace/UASM/archive/${SNAPSHOT}.tar.gz -> uasm-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/UASM-${SNAPSHOT}"

LICENSE="Watcom-1.0"
SLOT="0"
KEYWORDS="amd64"

src_prepare() {
	default
	# don't strip binary
	sed -i Makefile-Linux-GCC-64.mak -e 's/ -s / /g' || die
}

src_compile() {
	append-cflags -fcommon
	append-cflags -Wno-error=incompatible-pointer-types

	emake -f Makefile-Linux-GCC-64.mak \
		CC="$(tc-getCC)" \
		CFLAGS="${CFLAGS}" \
		LDFLAGS="${LDFLAGS}"
}

src_install() {
	dobin GccUnixR/uasm
}
