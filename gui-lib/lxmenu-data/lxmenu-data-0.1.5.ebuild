# Distributed under the terms of the GNU General Public License v2

EAPI="6"

DESCRIPTION="Provides files needed for LXDE application menus"
HOMEPAGE="http://lxde.org/"
SRC_URI="mirror://sourceforge/lxde/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="sys-devel/gettext
	>=dev-util/intltool-0.40.0
	dev-util/pkgconfig"

src_install() {
	emake DESTDIR="${D}" install
	dodoc AUTHORS README
}
