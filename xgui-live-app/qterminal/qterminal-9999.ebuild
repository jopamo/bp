# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake git-r3 xdg-utils

DESCRIPTION="Qt-based multitab terminal emulator"
HOMEPAGE="https://github.com/lxqt/qterminal"
EGIT_REPO_URI="https://github.com/lxqt/qterminal.git"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="translations"

DEPEND="
	xgui-live-lib/qtbase
	xgui-live-lib/qtx11extras
	xgui-live-lib/libX11
	~xgui-live-lib/qtermwidget-${PV}
"
BDEPEND="dev-util/lxqt-build-tools"

src_prepare() {
	cmake_src_prepare
	sed -i 's/utilities-terminal/qterminal/g' {src/mainwindow.cpp,src/icons.qrc,src/forms/propertiesdialog.ui,qterminal.desktop.in,qterminal-drop.desktop.in}
}

src_install() {
	cmake_src_install

	insinto etc/xdg/${PN}.org
	doins ${FILESDIR}/qterminal.ini

	use translations || rm -rf "${ED}"/usr/share/${PN}/translations || die

	rm -rf "${ED}"/usr/share/appdata || die

}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
