# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="Convert DOS or MAC text files to UNIX format or vice versa"
HOMEPAGE="https://www.xs4all.nl/~waterlan/dos2unix.html https://sourceforge.net/projects/dos2unix/"
SRC_URI="
	https://www.xs4all.nl/~waterlan/${PN}/${P/_/-}.tar.gz
	mirror://sourceforge/${PN}/${P/_/-}.tar.gz
"
S="${WORKDIR}/${P/_/-}"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="debug test"

RESTRICT="!test? ( test )"

src_prepare() {
	default

	sed \
		-e '/^LDFLAGS/s|=|+=|' \
		-e '/CFLAGS_OS \+=/d' \
		-e '/LDFLAGS_EXTRA \+=/d' \
		-e "/^CFLAGS/s|-O2|${CFLAGS}|" \
		-i Makefile || die

	if use debug ; then
		sed -e "/^DEBUG/s:0:1:" \
			-e "/EXTRA_CFLAGS +=/s:-g::" \
			-i Makefile || die
	fi

	tc-export CC
}

src_compile() {
	emake prefix="${EPREFIX}/usr"
}

src_install() {
	emake DESTDIR="${D}" prefix="${EPREFIX}/usr" install
}
