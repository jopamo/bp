# Distributed under the terms of the GNU General Public License v2

inherit cmake

DESCRIPTION="Modern, header-only C++ test framework"
HOMEPAGE="https://github.com/catchorg/Catch2"
SNAPSHOT=69e0473f6e98d47c93518424c08ee69ee632c0f0
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
