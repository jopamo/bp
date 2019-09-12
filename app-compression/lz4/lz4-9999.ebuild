# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils git-r3

DESCRIPTION="Extremely Fast Compression algorithm"
HOMEPAGE="https://github.com/lz4/lz4"
EGIT_REPO_URI="https://github.com/lz4/lz4.git"
EGIT_BRANCH="master"

LICENSE="BSD-2 GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

CMAKE_USE_DIR=${S}/contrib/cmake_unofficial

src_configure() {
	local mycmakeargs=(
		-DBUILD_STATIC_LIBS=$(usex static-libs)
	)

	cmake-utils_src_configure
}
