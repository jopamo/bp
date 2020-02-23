# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit flag-o-matic

DESCRIPTION="The GNU info program and utilities"
HOMEPAGE="https://www.gnu.org/software/texinfo/"
SRC_URI="mirror://gnu/${PN}/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0/1"
KEYWORDS="amd64 arm64"

IUSE="nls static"

RDEPEND="
	dev-lang/perl
	nls? ( sys-devel/gettext )"

DEPEND="${RDEPEND}
	app-compression/xz-utils
	nls? ( >=sys-devel/gettext-0.19.6 )"

src_configure() {
	use static && append-ldflags -static
	local myconf=(
		--with-external-libintl-perl
		--with-external-Unicode-EastAsianWidth
		--with-external-Text-Unidecode
		$(use_enable nls)
	)
	econf "${myconf[@]}"
}

src_configure() {
	default
	dosym texi2any usr/bin/makeinfo
}
