# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic

DESCRIPTION="A general-purpose (yacc-compatible) parser generator"
HOMEPAGE="https://www.gnu.org/software/bison/"
SRC_URI="mirror://gnu/${PN}/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static test"

DEPEND="
	app-build/m4
	test? ( app-lang/perl )
"

src_prepare() {
	touch doc/bison.1
	sed -i '2iexport TZ=UTC' build-aux/mdate-sh || die
	default
}

src_configure() {
	use static && append-ldflags -static
	default
}

src_install() {
	default
	rm -f "${ED}"/usr/lib/liby.a || die
}
