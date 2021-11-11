# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake python-any-r1 git-r3

DESCRIPTION="Official Vulkan Tools and Utilities for Windows, Linux, Android, and MacOS"
HOMEPAGE="https://github.com/KhronosGroup/Vulkan-Tools"
EGIT_REPO_URI="https://github.com/KhronosGroup/Vulkan-Tools.git"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="cube wayland +X"

# Cube demo only supports one window system at a time
REQUIRED_USE="!cube? ( || ( X wayland ) ) cube? ( ^^ ( X wayland ) )"

BDEPEND="${PYTHON_DEPS}
	>=app-dev/cmake-3.10.2
	cube? ( app-dev/glslang )
"
RDEPEND="
	>=xmedia-live-lib/vulkan-loader-${PV}
	wayland? ( xgui-live-lib/wayland )
	X? (
		xgui-live-lib/libX11
		xgui-live-lib/libXrandr
	)
"
DEPEND="${RDEPEND}
	>=app-dev/vulkan-headers-${PV}
"

pkg_setup() {
	python-any-r1_pkg_setup
}

src_configure() {
	local mycmakeargs=(
		-DCMAKE_SKIP_RPATH=ON
		-DBUILD_VULKANINFO=ON
		-DBUILD_CUBE=$(usex cube)
		-DBUILD_WSI_WAYLAND_SUPPORT=$(usex wayland)
		-DBUILD_WSI_XCB_SUPPORT=$(usex X)
		-DBUILD_WSI_XLIB_SUPPORT=$(usex X)
	)

	use cube && mycmakeargs+=(
		-DGLSLANG_INSTALL_DIR="${EPREFIX}/usr"
		-DCUBE_WSI_SELECTION=$(usex X XCB WAYLAND)
	)

	cmake_src_configure
}
