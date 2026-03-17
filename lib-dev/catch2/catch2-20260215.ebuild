# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Modern, header-only C++ test framework"
HOMEPAGE="https://github.com/catchorg/Catch2"

SNAPSHOT=b9eeca15d7598fae6a368c1c5d2462108f892849
SRC_URI="https://github.com/catchorg/Catch2/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/Catch2-${SNAPSHOT}

LICENSE="Boost-1.0"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="test"

RESTRICT="!test? ( test )"

src_configure() {
	local mycmakeargs=(
		-DCATCH_DEVELOPMENT_BUILD=$(usex test ON OFF)
		-DCATCH_BUILD_TESTING=$(usex test ON OFF)
		-DCATCH_BUILD_EXAMPLES=OFF
		-DCATCH_BUILD_EXTRA_TESTS=OFF
		-DCATCH_BUILD_FUZZERS=OFF
		-DCATCH_BUILD_BENCHMARKS=OFF
		-DCATCH_ENABLE_WERROR=OFF
	)

	cmake_src_configure
}

src_test() {
	cmake_src_test
}
