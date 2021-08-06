# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 cmake

DESCRIPTION="Framework providing assorted high-level user interface components"
EGIT_REPO_URI="https://github.com/KDE/kguiaddons.git"

LICENSE="LGPL-2+"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="wayland"

RDEPEND="lib-gui/qtbase
	lib-gui/qtx11extras
	x11-live-libs/libX11"

DEPEND="lib-gui/libxcb
	x11-live-misc/xorgproto
	x11-live-misc/kf-env
	wayland? ( lib-gui/qtwayland )"

src_configure() {
	local mycmakeargs=(
		$(usex wayland '-DWITH_WAYLAND=ON' '-DWITH_WAYLAND=OFF')
	)

	cmake_src_configure
}
