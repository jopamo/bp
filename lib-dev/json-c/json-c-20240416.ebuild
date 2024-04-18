# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="A JSON implementation in C"
HOMEPAGE="https://github.com/json-c/json-c/wiki"

SNAPSHOT=0051f2dbe0cbcb537ccf257e9154b443488fecca
SRC_URI="https://github.com/json-c/json-c/archive/${SNAPSHOT}.tar.gz -> json-c-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/json-c-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

src_configure() {
	export USE_VALGRIND=0

	local mycmakeargs=(
		-DBUILD_APPS=OFF
		-DBUILD_STATIC_LIBS=$(usex static-libs)
		-DDISABLE_EXTRA_LIBS=ON
		-DDISABLE_WERROR=ON
		-DENABLE_RDRAND=ON
		-DENABLE_THREADING=ON
	)

	cmake_src_configure
}
