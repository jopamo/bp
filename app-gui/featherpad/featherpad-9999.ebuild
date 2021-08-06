# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit xdg-utils qmake-utils git-r3

DESCRIPTION="Lightweight Qt5 Plain-Text Editor"
HOMEPAGE="https://github.com/tsujan/FeatherPad"
EGIT_REPO_URI="https://github.com/tsujan/FeatherPad.git"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	lib-gui/qtbase
	lib-gui/qtsvg:5
	lib-gui/qtx11extras:5
	app-text/hunspell
"
src_configure() {
	eqmake5 fp.pro
}

src_install() {
	emake INSTALL_ROOT="${ED}" install
	insinto /etc/xdg/featherpad
	doins "${FILESDIR}"/fp.conf
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
