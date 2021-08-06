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

RDEPEND="
	lib-dev/libqtxdg
	lib-gui/qtbase
	lib-gui/qtx11extras:5
	x11-live-misc/kwindowsystem
	=lib-gui/liblxqt-$(ver_cut 1-2)*
	lib-sys/zlib:=
	lib-gui/libxcb
	x11-live-libs/libX11
	x11-live-libs/libXcursor
	x11-live-libs/libXfixes
"
DEPEND="${RDEPEND}
	>=dev-util/lxqt-build-tools-0.5.0
	x11-live-misc/xf86-input-libinput
"

src_configure() {
	local mycmakeargs=(
		-DWITH_MONITOR=OFF
		-DWITH_TOUCHPAD=OFF
	)
	cmake_src_configure
}
