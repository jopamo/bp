# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Library implementing the GIT2 protocol"
HOMEPAGE="https://www.libgit2.org/"

SNAPSHOT=21a351b0ed207d0871cb23e09c027d1ee42eae98
SRC_URI="https://github.com/libgit2/libgit2/archive/${SNAPSHOT}.tar.gz -> libgit2-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

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
