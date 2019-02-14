# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils

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
	gui-lib/qtcore:5
	gui-lib/qtdbus:5
	gui-lib/qtgui:5
	gui-lib/qtwidgets:5
	gui-lib/qtx11extras:5
	gui-lib/qtxml:5
	gui-lib/liblxqt
	>=lib-dev/libqtxdg-2.0.0
	x11-libs/libICE
	x11-libs/libSM
	x11-libs/libX11
	x11-libs/libXext
"
DEPEND="${RDEPEND}
	gui-lib/linguist-tools:5
	>=dev-util/lxqt-build-tools-0.1.0
"

src_install() {
	cmake-utils_src_install
	rm "${ED}"/usr/share/applications/lxqt-config-globalkeyshortcuts.desktop
}
