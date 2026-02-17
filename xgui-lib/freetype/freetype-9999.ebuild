# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson git-r3 dot-a

DESCRIPTION="A high-quality and portable font engine"
HOMEPAGE="https://www.freetype.org/"
EGIT_REPO_URI="https://github.com/freetype/freetype"

LICENSE="|| ( FTL GPL-2+ )"
SLOT="2"
IUSE="brotli bzip2 debug harfbuzz png static-libs zlib"
#KEYWORDS="amd64 arm64"

RDEPEND="
	brotli? ( app-compression/brotli )
	bzip2? ( app-compression/bzip2 )
	harfbuzz? ( xgui-lib/harfbuzz[truetype] )
	png? ( xmedia-lib/libpng )
	zlib? ( lib-core/zlib )
"

src_configure() {
	use static-libs && lto-guarantee-fat

	local emesonargs=(
		-Ddefault_library=$(usex static-libs both shared)
	)
	meson_src_configure
}

src_install() {
	meson_src_install
	use static-libs && strip-lto-bytecode
}
