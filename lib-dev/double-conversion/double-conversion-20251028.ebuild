# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Binary-decimal and decimal-binary conversion routines for IEEE doubles"
HOMEPAGE="https://github.com/google/double-conversion"
SNAPSHOT=adc7c2450f99e0ca673238276c93e7896afa7b29
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
