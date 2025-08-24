# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake flag-o-matic

DESCRIPTION="A unit test framework for C"
HOMEPAGE="https://github.com/libcheck/check"

SNAPSHOT=455005dc29dc6727de7ee36fee4b49a13b39f73f
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
