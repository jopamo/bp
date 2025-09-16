# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson git-r3

DESCRIPTION="A high-quality and portable font engine"
HOMEPAGE="https://www.freetype.org/"
EGIT_REPO_URI="https://github.com/freetype/freetype"

IUSE="brotli bzip2 debug harfbuzz png static-libs zlib"

LICENSE="|| ( FTL GPL-2+ )"
SLOT="2"
#KEYWORDS="amd64 arm64"

RDEPEND="
	brotli? ( app-compression/brotli )
	bzip2? ( app-compression/bzip2 )
	harfbuzz? ( xgui-lib/harfbuzz[truetype] )
	png? ( xmedia-lib/libpng )
	zlib? ( lib-core/zlib )
"
