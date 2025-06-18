# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs flag-o-matic

DESCRIPTION="Text formatter used for man pages"
HOMEPAGE="https://www.gnu.org/software/groff/groff.html"
SRC_URI="mirror://gnu/groff/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="core-perl/libintl-perl"

filter-flags -fno-signed-zeros -fassociative-math

src_prepare() {
	if tc-is-cross-compiler ; then
		sed -i \
			-e '/^GROFFBIN=/s:=.*:=${EPREFIX}/usr/bin/groff:' \
			-e '/^TROFFBIN=/s:=.*:=${EPREFIX}/usr/bin/troff:' \
			-e '/^GROFF_BIN_PATH=/s:=.*:=:' \
			-e '/^GROFF_BIN_DIR=/s:=.*:=:' \
			contrib/*/Makefile.sub \
			doc/Makefile.in \
			doc/Makefile.sub || die "cross-compile sed failed"
	fi

	sed -i -e 's/^[ \t]\+g=g$/g=/' configure || die
	default
}

src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/lib
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}/etc"
		--localstatedir="${EPREFIX}/var"
		--docdir="${EPREFIX}"/usr/share/doc/${PF}
	)
	econf ${myconf[@]}
}

src_compile() {
	emake -j1
}

src_install() {
	default

	dosym eqn /usr/bin/geqn
	dosym tbl /usr/bin/gtbl

	rm -rf "${ED}"/usr/share/doc
	rm -f "${ED}"/usr/lib/charset.alias
}
