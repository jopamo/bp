# Distributed under the terms of the GNU General Public License v2

inherit cmake flag-o-matic

DESCRIPTION="A unit test framework for C"
HOMEPAGE="https://github.com/libcheck/check"

SNAPSHOT=fb77d3db72b985522813214cb206bc933220871c
SRC_URI="https://github.com/libcheck/check/archive/${SNAPSHOT}.tar.gz -> check-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/check-${SNAPSHOT}"

LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="test"

RESTRICT="!test? ( test )"

src_configure() {
	append-flags -ffat-lto-objects

	local mycmakeargs=(
		-DBUILD_TESTING=$(usex test ON OFF)
	)

	cmake_src_configure
}
