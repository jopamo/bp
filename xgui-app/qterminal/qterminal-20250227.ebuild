# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg

DESCRIPTION="Qt-based multitab terminal emulator"
HOMEPAGE="https://github.com/lxqt/qterminal"
SNAPSHOT=e2f6e0e85b85b09f80f7b405f13f6af4d8f2ec64
SRC_URI="https://github.com/lxqt/qterminal/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="translations"

DEPEND="
	xgui-lib/qtbase
	xgui-lib/qtx11extras
	xgui-lib/libX11
	xgui-lib/qtermwidget
"
BDEPEND="app-dev/lxqt-build-tools"
RDEPEND="xgui-icontheme/hicolor-icon-theme"

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
