# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Fast and exact implementation of the C++ from_chars functions for number types"
HOMEPAGE="https://github.com/fastfloat/fast_float"
SRC_URI="https://github.com/fastfloat/fast_float/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

SNAPSHOT=b8085ba3634018ad6e5618cf87dd5a04a0e3f146
SRC_URI="https://github.com/fastfloat/fast_float/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="|| ( Apache-2.0 Boost-1.0 MIT )"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="test"

BDEPEND="test? ( dev-cpp/doctest )"

RESTRICT="!test? ( test )"

src_configure() {
	local mycmakeargs=( -DFASTFLOAT_TEST=$(usex test) )
	# Avoid passing these without USE=test to avoid cmake warning
	# "Manually-specified variables were not used by the project"
	use test && mycmakeargs+=(
		-DSYSTEM_DOCTEST=ON
		# Unconditionally calls FetchContent
		-DFASTFLOAT_SUPPLEMENTAL_TESTS=OFF
	)

	sed -i 's/-Werror//' tests/CMakeLists.txt || die

	cmake_src_configure
}
