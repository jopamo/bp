# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake git-r3 xdg-utils

DESCRIPTION="Qt-based multitab terminal emulator"
HOMEPAGE="https://github.com/lxqt/qterminal"
EGIT_REPO_URI="https://github.com/lxqt/qterminal.git"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
	lib-gui/qtbase
	lib-gui/qtx11extras:5
	x11-libs/libX11
	~x11-libs/qtermwidget-${PV}
"
DEPEND="${RDEPEND}
	dev-util/lxqt-build-tools
"

src_install() {
	cmake_src_install

	insinto etc/xdg/${PN}.org
	doins ${FILESDIR}/qterminal.ini
}
