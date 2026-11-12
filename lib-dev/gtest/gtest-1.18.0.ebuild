# Distributed under the terms of the GNU General Public License v2

inherit cmake

DESCRIPTION="Google C++ testing and mocking frameworks"
HOMEPAGE="https://github.com/google/googletest"
SRC_URI="https://github.com/google/googletest/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/googletest-${PV}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="test"
RESTRICT="!test? ( test )"

src_configure() {
	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=ON
		-Dgtest_build_tests=$(usex test ON OFF)
		-Dgmock_build_tests=$(usex test ON OFF)
	)
	cmake_src_configure
}
