# Distributed under the terms of the GNU General Public License v2

EAPI=7

CMAKE_MAKEFILE_GENERATOR=emake
SNAPSHOT=c4bae8d8185858435bdf22cd98ba7e58e67d9041

inherit cmake

DESCRIPTION="Light-weight, simple, and fast XML parser for C++ with XPath support"
HOMEPAGE="https://pugixml.org/ https://github.com/zeux/pugixml/"
SRC_URI="https://github.com/zeux/pugixml/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

src_configure() {
	local mycmakeargs=( -DBUILD_SHARED_LIBS=ON )
	cmake_src_configure
}
