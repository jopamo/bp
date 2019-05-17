# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils

DESCRIPTION="LXQt system configuration control center"
HOMEPAGE="https://lxqt.org/"

if [[ ${PV} = *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/lxqt/${PN}.git"
else
	SRC_URI="https://downloads.lxqt.org/downloads/${PN}/${PV}/${P}.tar.xz"
fi

LICENSE="GPL-2 GPL-2+ GPL-3 LGPL-2 LGPL-2+ LGPL-2.1+ WTFPL-2"
SLOT="0/1"
KEYWORDS="amd64 arm64"

RDEPEND="
	>=lib-dev/libqtxdg-3.0.0
	gui-lib/qtcore:5
	gui-lib/qtdbus:5
	gui-lib/qtgui:5
	gui-lib/qtwidgets:5
	gui-lib/qtx11extras:5
	gui-lib/qtxml:5
	x11-misc/kwindowsystem
	=gui-lib/liblxqt-$(ver_cut 1-2)*
	lib-sys/zlib:=
	x11-libs/libxcb:=
	x11-libs/libX11
	x11-libs/libXcursor
	x11-libs/libXfixes
"
DEPEND="${DEPEND}
	gui-lib/linguist-tools:5
	>=dev-util/lxqt-build-tools-0.5.0
	x11-misc/xf86-input-libinput
"

src_configure() {
	local mycmakeargs=(
		-DWITH_MONITOR=OFF
	)
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
}
