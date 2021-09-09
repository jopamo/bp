# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="LXQt system configuration control center"
HOMEPAGE="https://lxqt.org/"

if [[ ${PV} = *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/lxqt/${PN}.git"
else
	SRC_URI="https://downloads.lxqt.org/downloads/${PN}/${PV}/${P}.tar.xz"
fi

LICENSE="GPL-2 GPL-2+ GPL-3 LGPL-2 LGPL-2+ LGPL-2.1+ WTFPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	lib-live/libqtxdg
	xgui-live-lib/qtbase
	xgui-live-lib/qtx11extras
	xgui-live-app/kwindowsystem
	xgui-live-lib/liblxqt
	lib-core/zlib
	xgui-live-lib/libxcb
	xgui-live-lib/libX11
	xgui-live-lib/libXcursor
	xgui-live-lib/libXfixes
	xgui-live-app/xf86-input-libinput
"
BDEPEND="dev-util/lxqt-build-tools"

src_configure() {
	local mycmakeargs=(
		-DWITH_MONITOR=OFF
		-DWITH_TOUCHPAD=OFF
	)
	cmake_src_configure
}
