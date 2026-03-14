# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic qa-policy

DESCRIPTION="A general-purpose (yacc-compatible) parser generator"
HOMEPAGE="https://www.gnu.org/software/bison/"
SRC_URI="mirror://gnu/${PN}/${P}.tar.xz"

LICENSE="GPL-3+ FDL-1.3"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs test"

RDEPEND="
	app-build/gettext
	app-build/m4
"
DEPEND="
	app-build/gettext
"
BDEPEND="
	app-build/m4
	test? ( app-lang/perl )
"

src_prepare() {
	touch doc/bison.1
	sed -i '2iexport TZ=UTC' build-aux/mdate-sh || die
	default
}

src_configure() {
	qa-policy-configure
	use static-libs && append-ldflags -static
	default
}

src_test() {
	use test || return 0

	emake check
}

src_install() {
	default
	use static-libs || rm -f "${ED}"/usr/lib/liby.a || die
	qa-policy-install
}
