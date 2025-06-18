# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic

DESCRIPTION="Standard tool to compile source trees"
HOMEPAGE="https://www.gnu.org/software/make/make.html"
SRC_URI="mirror://gnu//${PN}/${P}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="guile nls static"

DEPEND="guile? ( >=dev-scheme/guile-1.8:= )
		nls? ( app-build/gettext )
		core-perl/libintl-perl
		app-build/texinfo"

src_configure() {
	use static && append-ldflags -static

	local myconf=(
		$(use_with guile)
		$(use_enable nls)
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
