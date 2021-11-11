# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Daemon used to register global keyboard shortcuts"
HOMEPAGE="http://lxqt.org/"
KEYWORDS="amd64 arm64"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/lxde/${PN}.git"
else
	SRC_URI="https://github.com/lxde/${PN}/releases/download/${PV}/${P}.tar.xz"
fi

LICENSE="LGPL-2.1+"
SLOT="0"

RDEPEND="
	xgui-live-lib/qtbase
	xgui-live-lib/qtx11extras
	xgui-live-lib/liblxqt
	lib-live/libqtxdg
	xgui-live-lib/libICE
	xgui-live-lib/libSM
	xgui-live-lib/libX11
	xgui-live-lib/libXext
"

BDEPEND="app-dev/lxqt-build-tools"

src_install() {
	cmake_src_install
	rm "${ED}"/usr/share/applications/lxqt-config-globalkeyshortcuts.desktop
}
