# Distributed under the terms of the GNU General Public License v2

inherit cmake

DESCRIPTION="C++ testing framework for unit tests and TDD"
HOMEPAGE="https://github.com/doctest/doctest"
SRC_URI="https://github.com/doctest/doctest/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="test"
RESTRICT="!test? ( test )"

src_configure() {
	local mycmakeargs=(
		-DDOCTEST_WITH_TESTS=$(usex test ON OFF)
	)
	cmake_src_configure
}
