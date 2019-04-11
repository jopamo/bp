# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit flag-o-matic

DESCRIPTION="Standard tool to compile source trees"
HOMEPAGE="https://www.gnu.org/software/make/make.html"
SRC_URI="https://1g4.org/files/${P}.tar.xz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="guile nls static"

DEPEND="guile? ( >=dev-scheme/guile-1.8:= )
	nls? ( sys-devel/gettext )"

src_configure() {
	use static && append-ldflags -static
	econf \
		$(use_with guile) \
		$(use_enable nls)
}

src_install() {
	emake DESTDIR="${D}" install
}
