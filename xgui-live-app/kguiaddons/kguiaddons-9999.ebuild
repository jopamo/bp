# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 cmake

DESCRIPTION="Framework providing assorted high-level user interface components"
EGIT_REPO_URI="https://github.com/KDE/kguiaddons.git"

LICENSE="LGPL-2+"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="wayland"

RDEPEND="xgui-live-lib/qtbase
	xgui-live-lib/qtx11extras
	xgui-live-lib/libX11"

DEPEND="xgui-live-lib/libxcb
	xgui-live-app/xorgproto
	xgui-live-app/kf-env
	wayland? ( xgui-live-lib/qtwayland )"

src_configure() {
	local mycmakeargs=(
		$(usex wayland '-DWITH_WAYLAND=ON' '-DWITH_WAYLAND=OFF')
	)

	cmake_src_configure
}
