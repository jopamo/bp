# Distributed under the terms of the GNU General Public License v2

inherit cmake

DESCRIPTION="Binary-decimal and decimal-binary conversion routines for IEEE doubles"
HOMEPAGE="https://github.com/google/double-conversion"
SNAPSHOT=12592d9040f13a3bc1a393add4dff88bf9632d9e
SRC_URI="https://github.com/google/double-conversion/archive/${SNAPSHOT}.tar.gz -> double-conversion-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/double-conversion-${SNAPSHOT}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

src_configure() {
	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=ON
	)

	cmake_src_configure
}
