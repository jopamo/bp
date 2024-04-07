# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="An encoding detector library"
HOMEPAGE="https://www.freedesktop.org/wiki/Software/uchardet/"

SNAPSHOT=edae8e81cfb8092496f94da1a306c4c9f0ce32bb
SRC_URI="https://gitlab.freedesktop.org/uchardet/uchardet/-/archive/${SNAPSHOT}/uchardet-${SNAPSHOT}.tar.bz2 -> uchardet-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/uchardet-${SNAPSHOT}"

LICENSE="|| ( MPL-1.1 GPL-2+ LGPL-2.1+ )"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs test"

src_prepare() {
	cmake_src_prepare
	use test || cmake_comment_add_subdirectory test
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_STATIC=$(usex static-libs)
	)
	cmake_src_configure
}
