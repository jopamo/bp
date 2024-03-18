# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic

DESCRIPTION="The GNU info program and utilities"
HOMEPAGE="https://www.gnu.org/software/texinfo/"
SRC_URI="mirror://gnu//${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static"

DEPEND="app-compression/xz-utils"

src_configure() {
	use static && append-ldflags -static

	local myconf=( --disable-perl-xs )
	econf "${myconf[@]}"
}

src_configure() {
	default
	dosym texi2any usr/bin/makeinfo
}
