# Distributed under the terms of the GNU General Public License v2

inherit cmake

DESCRIPTION="Unit testing framework for C with support for mock objects"
HOMEPAGE="https://cmocka.org/"
SRC_URI="https://cmocka.org/files/$(ver_cut 1-2)/${P}.tar.xz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="test"
RESTRICT="!test? ( test )"

src_configure() {
	local mycmakeargs=(
		-DUNIT_TESTING=$(usex test ON OFF)
		-DWITH_EXAMPLES=OFF
	)
	cmake_src_configure
}
