# Distributed under the terms of the GNU General Public License v2

inherit cmake

DESCRIPTION="Unit testing and mocking framework for C and C++"
HOMEPAGE="https://cpputest.github.io/"
SRC_URI="https://github.com/cpputest/cpputest/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="test"
RESTRICT="!test? ( test )"

src_configure() {
	# Install native archives usable without a compiler-specific LTO plugin.
	filter-lto
	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=OFF
		-DCMAKE_POLICY_VERSION_MINIMUM=3.5
		-DCMAKE_POSITION_INDEPENDENT_CODE=ON
		-DTESTS=$(usex test)
	)
	cmake_src_configure
}
