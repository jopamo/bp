# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit git-r3 autotools

DESCRIPTION="Provides files needed for LXDE application menus"
HOMEPAGE="http://lxde.org/"
EGIT_REPO_URI="https://github.com/lxde/lxmenu-data.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="sys-devel/gettext
	>=dev-util/intltool-0.40.0
	dev-util/pkgconfig"

src_prepare() {
	default
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc AUTHORS README
}
