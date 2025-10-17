# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="Convert DOS or MAC text files to UNIX format or vice versa"
HOMEPAGE="https://www.xs4all.nl/~waterlan/dos2unix.html https://sourceforge.net/projects/dos2unix/"
SNAPSHOT=ecdd7428ac17035140f7c369c1022bca3016a099
SRC_URI="https://github.com/1g4-mirror/dos2unix/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}/dos2unix"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="debug test"

RESTRICT="!test? ( test )"

src_prepare() {
	default

	sed -i '
/^man:/,/^doc:/s/^/# /;
/^install-man:/,/^install-mo:/s/^/# /;
/^mofiles:/,/^install-mo:/s/^/# /;
/^install-doc:/,/^install-pdf:/s/^/# /;
/^%.1 : %.pod/,/^%.mo : %.po/s/^/# /;
/^ifdef ENABLE_NLS/,/^endif/s/^/# /;
/^dist:/,/^dist-zip:/s/^/# /;
' Makefile


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
	dobin dos2unix
}
