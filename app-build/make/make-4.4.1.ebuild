# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic qa-policy

DESCRIPTION="Standard tool to compile source trees"
HOMEPAGE="https://www.gnu.org/software/make/make.html"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz"

LICENSE="GPL-3+ FDL-1.3+"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static test"

BDEPEND="test? ( app-lang/perl )"

PATCHES=( "${FILESDIR}"/getopt-gcc15.patch )

src_configure() {
	qa-policy-configure
	use static && append-ldflags -static

	local myconf=(
		--without-guile
		--disable-nls
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_test() {
	use test || return 0

	emake check
}

src_install() {
	default

	qa-policy-install
}
