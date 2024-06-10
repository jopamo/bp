# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="A lossy image compression format"
HOMEPAGE="https://developers.google.com/speed/webp/download"

SNAPSHOT=ea0e121b6a9688ea21d3543cc12ea6cb48d15663
SRC_URI="https://github.com/webmproject/libwebp/archive/${SNAPSHOT}.tar.gz -> libwebp-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/libwebp-${SNAPSHOT}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="+jpeg +png static-libs +tiff"

DEPEND="
	jpeg? ( xmedia-lib/libjpeg-turbo )
	png? ( xmedia-lib/libpng )
	tiff? ( xmedia-lib/tiff )
"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		$(use_enable jpeg)
		$(use_enable png)
		$(use_enable static-libs static)
		$(use_enable tiff)
		--disable-gif
		--enable-libwebpdecoder
		--enable-libwebpdemux
		--enable-libwebpmux
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
