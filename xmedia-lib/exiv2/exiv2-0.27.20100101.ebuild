# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="EXIF, IPTC and XMP metadata C++ library and command line utility"
HOMEPAGE="http://www.exiv2.org/"

SNAPSHOT=9343c6d3232b131c0295886a5949a673ee0a8c5f
SRC_URI="https://github.com/Exiv2/exiv2/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/Exiv2-${SNAPSHOT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="png static-libs webready xmp"

DEPEND="
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
