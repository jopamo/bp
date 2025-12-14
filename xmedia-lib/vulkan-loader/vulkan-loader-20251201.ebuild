# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake python-any-r1

DESCRIPTION="Vulkan Installable Client Driver (ICD) Loader"
HOMEPAGE="https://github.com/KhronosGroup/Vulkan-Loader"
SNAPSHOT=e042a3a16bdf37e8c9d61b95b7a5933bccef0f45
SRC_URI="https://github.com/KhronosGroup/Vulkan-Loader/archive/${SNAPSHOT}.tar.gz -> Vulkan-Loader-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/Vulkan-Loader-${SNAPSHOT}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="layers wayland X"

DEPEND="${PYTHON_DEPS}
	app-dev/vulkan-headers
	wayland? ( xgui-lib/wayland )
	X? (
		xgui-lib/libX11
		xgui-lib/libXrandr
	)
"
PDEPEND="layers? ( xmedia-live-lib/vulkan-layers )"

src_configure() {
	local mycmakeargs=(
		-DCMAKE_SKIP_RPATH=ON
		-DBUILD_TESTS=OFF
		-DBUILD_WSI_WAYLAND_SUPPORT=$(usex wayland)
		-DBUILD_WSI_XCB_SUPPORT=$(usex X)
		-DBUILD_WSI_XLIB_SUPPORT=$(usex X)
		-DVULKAN_HEADERS_INSTALL_DIR="${EPREFIX}/usr"
	)
	cmake_src_configure
}

src_install() {
	keepdir /etc/vulkan/icd.d

	cmake_src_install
}
