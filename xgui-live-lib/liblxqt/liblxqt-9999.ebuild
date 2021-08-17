# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="Common base library for the LXQt desktop environment"
HOMEPAGE="http://lxqt.org/"

if [[ ${PV} = *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="http://www.github.com/lxqt/${PN}.git"
else
	SRC_URI="https://github.com/lxqt/liblxqt/releases/download/${PV}/${P}.tar.xz"
fi

LICENSE="GPL-2 LGPL-2.1+"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	lib-live/libqtxdg
	xgui-live-lib/qtbase
	xgui-live-lib/qtx11extras
	x11-live-misc/kwindowsystem
	lib-live/libqtxdg
	x11-live-lib/libXScrnSaver
"

src_configure() {
	local mycmakeargs=(
		-DBUILD_BACKLIGHT_LINUX_BACKEND=OFF
	)
	cmake_src_configure
}
