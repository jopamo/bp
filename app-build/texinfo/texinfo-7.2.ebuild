# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic qa-policy

DESCRIPTION="The GNU info program and utilities"
HOMEPAGE="https://www.gnu.org/software/texinfo/"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz"

LICENSE="GPL-3+ FDL-1.3+"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static test"

DEPEND="virtual/curses"
RDEPEND="
	${DEPEND}
	app-lang/perl
"
BDEPEND="
	app-build/gettext
	test? ( app-lang/perl )
"

src_configure() {
	qa-policy-configure
	use static && append-ldflags -static

	local myconf=( --disable-perl-xs )
	econf "${myconf[@]}"
}

src_test() {
	use test || return 0

	emake check
}

src_install() {
	default

	qa-policy-install
}
