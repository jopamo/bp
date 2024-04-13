# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="A lossy image compression format"
HOMEPAGE="https://developers.google.com/speed/webp/download"

SNAPSHOT=b3d1b2cbf7e6286832876cc720dee96cd1945aec
SRC_URI="https://github.com/webmproject/libwebp/archive/${SNAPSHOT}.tar.gz -> libwebp-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/libwebp-${SNAPSHOT}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="+jpeg neon opengl +png static-libs swap-16bit-csp tiff"

DEPEND="
	jpeg? ( xmedia-lib/libjpeg-turbo )
	opengl? (
		xgui-misc/freeglut
		xgui-tools/mesa
		)
	png? ( xmedia-lib/libpng:0= )
	tiff? ( xmedia-lib/tiff:0= )"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		$(use_enable jpeg)
		$(use_enable neon)
		$(use_enable opengl gl)
		$(use_enable png)
		$(use_enable static-libs static)
		$(use_enable swap-16bit-csp)
		$(use_enable tiff)
		--disable-gif
		--enable-libwebpdecoder
		--enable-libwebpdemux
		--enable-libwebpmux
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
