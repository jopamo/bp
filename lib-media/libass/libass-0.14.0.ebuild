# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Library for SSA/ASS subtitles rendering"
HOMEPAGE="https://github.com/libass/libass"
SRC_URI="https://github.com/libass/libass/releases/download/${PV}/${P}.tar.xz"

LICENSE="ISC"
SLOT="0/1"
KEYWORDS="amd64 arm64"
IUSE="+fontconfig +harfbuzz static-libs"

RDEPEND="fontconfig? ( >=lib-media/fontconfig-2.10.92 )
	>=lib-media/freetype-2.5.0.1:2
	>=lib-dev/fribidi-0.19.5-r1
	harfbuzz? ( >=lib-media/harfbuzz-0.9.12[truetype] )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-lang/nasm"

src_configure() {
	ECONF_SOURCE="${S}" econf \
		$(use_enable fontconfig) \
		$(use_enable harfbuzz) \
		$(use_enable static-libs static) \
		--disable-require-system-font-provider
}

src_install_all() {
	find "${ED}" -name "*.la" -delete || die
}
