# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils git-r3 xdg-utils

DESCRIPTION="Qt-based multitab terminal emulator"
HOMEPAGE="https://github.com/lxqt/qterminal"
EGIT_REPO_URI="https://github.com/lxqt/qterminal.git"

LICENSE="GPL-2+"
SLOT="0/1"
KEYWORDS="amd64 arm64"

RDEPEND="
	gui-lib/qtcore:5
	gui-lib/qtgui:5
	gui-lib/qtwidgets:5
	gui-lib/qtx11extras:5
	x11-libs/libX11
	~x11-libs/qtermwidget-${PV}
"
DEPEND="${RDEPEND}
	dev-util/lxqt-build-tools
"
