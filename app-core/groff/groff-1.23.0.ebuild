# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic

DESCRIPTION="Text formatter used for man pages"
HOMEPAGE="https://www.gnu.org/software/groff/groff.html"
SRC_URI="mirror://gnu/groff/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="core-perl/libintl-perl"

PATCHES=( "${FILESDIR}"/gcc15.patch )

src_prepare() {
	filter-flags -fno-signed-zeros -fassociative-math

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

	dosym -r /usr/bin/eqn /usr/bin/geqn
	dosym -r /usr/bin/tbl /usr/bin/gtbl

	rm -rf "${ED}"/usr/share/doc
	rm -f "${ED}"/usr/lib/charset.alias
}
