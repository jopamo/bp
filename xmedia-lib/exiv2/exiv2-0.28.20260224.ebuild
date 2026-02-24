# Distributed under the terms of the GNU General Public License v2

EAPI=8

BRANCH_NAME="$(ver_cut 1-2).x"

inherit cmake dot-a

DESCRIPTION="EXIF, IPTC and XMP metadata C++ library and command line utility"
HOMEPAGE="http://www.exiv2.org/"
SNAPSHOT=3410c6de2db7df6cb26ada7988affd1b586e506b
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
	use static-libs && lto-guarantee-fat

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

src_install() {
	cmake_src_install
	use static-libs && strip-lto-bytecode
}
