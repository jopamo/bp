# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic cmake python-any-r1 toolchain-funcs

DESCRIPTION="Vulkan Installable Client Driver (ICD) Loader"
HOMEPAGE="https://github.com/KhronosGroup/Vulkan-Loader"

SNAPSHOT=2cb930f7f7491f0dcef9a18e447644306fafab18
SRC_URI="https://github.com/KhronosGroup/Vulkan-Loader/archive/${SNAPSHOT}.tar.gz -> Vulkan-Loader-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/Vulkan-Loader-${SNAPSHOT}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="layers wayland X"

BDEPEND=">=app-dev/cmake-3.10.2"
DEPEND="${PYTHON_DEPS}
	>=app-dev/vulkan-headers-${PV}
	wayland? ( xgui-live-lib/wayland )
	X? (
		xgui-live-lib/libX11
		xgui-live-lib/libXrandr
	)
"
PDEPEND="layers? ( xmedia-live-lib/vulkan-layers )"

src_configure() {
	local mycmakeargs=(
		-DCMAKE_SKIP_RPATH=ON
		-DBUILD_TESTS=OFF
		-DBUILD_LOADER=ON
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
