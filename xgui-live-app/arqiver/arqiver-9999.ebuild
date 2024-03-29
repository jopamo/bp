# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit xdg qmake-utils git-r3

DESCRIPTION="Simple Qt archive manager based on libarchive"
HOMEPAGE="https://github.com/tsujan/Arqiver.git"
EGIT_REPO_URI="https://github.com/tsujan/Arqiver.git"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	xgui-lib/qtbase
	xgui-lib/qtsvg
	xgui-lib/qtx11extras
	app-compression/libarchive[bsdtar]"

src_configure() {
	eqmake5 arqiver.pro
}

src_install() {
	emake INSTALL_ROOT="${ED}" install
	insinto /etc/xdg/arqiver
	doins "${FILESDIR}"/arq.conf

	rm -rf "${ED}"/usr/share/arqiver
}
