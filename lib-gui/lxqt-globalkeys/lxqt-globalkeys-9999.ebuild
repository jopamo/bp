# Distributed under the terms of the GNU General Public License v2

EAPI=7

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
	lib-gui/qtbase
	lib-gui/qtx11extras:5
	lib-gui/liblxqt
	>=lib-dev/libqtxdg-2.0.0
	x11-live-libs/libICE
	x11-live-libs/libSM
	x11-live-libs/libX11
	x11-live-libs/libXext
"

BDEPEND="dev-util/lxqt-build-tools"

src_install() {
	cmake_src_install
	rm "${ED}"/usr/share/applications/lxqt-config-globalkeyshortcuts.desktop
}
