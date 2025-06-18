# Distributed under the terms of the GNU General Public License v2

EAPI=8

BRANCH_NAME="$(ver_cut 1-2).x"

inherit cmake

DESCRIPTION="EXIF, IPTC and XMP metadata C++ library and command line utility"
HOMEPAGE="http://www.exiv2.org/"

SNAPSHOT=907169fa643c2c74c14fd4106e55eaeee3634d9f
SRC_URI="https://github.com/Exiv2/exiv2/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/exiv2-${SNAPSHOT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="png static-libs webready xmp"

DEPEND="
	lib-misc/inih
	png? ( lib-core/zlib )
	webready? (
		lib-net/libssh
		app-net/curl
	)
	xmp? ( lib-core/expat )
"

src_configure() {
	local mycmakeargs=(
		-DEXIV2_ENABLE_NLS=NO
		-DEXIV2_ENABLE_PNG=$(usex png)
		-DEXIV2_ENABLE_CURL=$(usex webready)
		-DEXIV2_ENABLE_SSH=$(usex webready)
		-DEXIV2_ENABLE_WEBREADY=$(usex webready)
		-DEXIV2_ENABLE_XMP=$(usex xmp)
	)
	cmake_src_configure
}
