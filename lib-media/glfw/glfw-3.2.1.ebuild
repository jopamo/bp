# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils

DESCRIPTION="The Portable OpenGL FrameWork"
HOMEPAGE="http://www.glfw.org/"
SRC_URI="mirror://sourceforge/glfw/${P}.tar.bz2"

LICENSE="ZLIB"
SLOT="0/1"
KEYWORDS="amd64 arm64"

IUSE="examples wayland"

RDEPEND="
	lib-gui/libxkbcommon
	!wayland? (
		lib-media/mesa
		x11-libs/libX11
		x11-libs/libXcursor
		x11-libs/libXinerama
		x11-libs/libXrandr
		x11-libs/libXxf86vm
	)
	wayland? (
		lib-dev/wayland
		lib-media/mesa[egl,wayland]
	)
"
DEPEND="
	${RDEPEND}
	wayland? (
		lib-dev/wayland-protocols
		x11-misc/extra-cmake-modules
	)
"

src_configure() {
	local mycmakeargs=(
		-DGLFW_BUILD_EXAMPLES="$(usex examples)"
		-DGLFW_USE_WAYLAND="$(usex wayland)"
		-DBUILD_SHARED_LIBS=1
	)
	cmake-utils_src_configure
}
