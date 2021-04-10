# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="Extremely Fast Compression algorithm"
HOMEPAGE="https://github.com/lz4/lz4"

if [[ ${PV} == *9999* ]]; then
	EGIT_REPO_URI="https://github.com/${PN}/${PN}.git"
	inherit git-r3
else
	SNAPSHOT=bdc9d3b0c10cbf7e1ff40fc6e27dad5f693a00e7
	SRC_URI="https://github.com/${PN}/${PN}/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
	S=${WORKDIR}/${PN}-${SNAPSHOT}
fi

LICENSE="BSD-2 GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

CMAKE_USE_DIR=${S}/build/cmake

src_configure() {
	local mycmakeargs=(
		-DBUILD_STATIC_LIBS=$(usex static-libs)
	)

	cmake_src_configure
}
