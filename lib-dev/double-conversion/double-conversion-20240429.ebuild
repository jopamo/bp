# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Binary-decimal and decimal-binary conversion routines for IEEE doubles"
HOMEPAGE="https://github.com/google/double-conversion"

SNAPSHOT=eec1833304d389031c26a618161a15250cc4351f
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
