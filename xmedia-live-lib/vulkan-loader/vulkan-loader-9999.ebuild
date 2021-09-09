# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit flag-o-matic cmake python-any-r1 toolchain-funcs

if [[ ${PV} == *9999* ]]; then
	EGIT_REPO_URI="https://github.com/KhronosGroup/Vulkan-Loader.git"
	EGIT_SUBMODULES=()
	inherit git-r3
else
	SRC_URI="https://github.com/KhronosGroup/${MY_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~ppc64 ~x86"
	S="${WORKDIR}"/${MY_PN}-${PV}
fi

DESCRIPTION="Vulkan Installable Client Driver (ICD) Loader"
HOMEPAGE="https://github.com/KhronosGroup/Vulkan-Loader"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="layers wayland X"

BDEPEND=">=dev-util/cmake-3.10.2"
DEPEND="${PYTHON_DEPS}
	>=dev-util/vulkan-headers-${PV}
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
