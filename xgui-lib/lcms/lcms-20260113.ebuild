# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dot-a

DESCRIPTION="A lightweight, speed optimized color management engine"
HOMEPAGE="http://www.littlecms.com/"
SNAPSHOT=b269a998c1132449d92b4d2d05fa2515556c3087
SRC_URI="https://github.com/ImageMagick/lcms/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="MIT"
SLOT="2"
KEYWORDS="amd64 arm64"

IUSE="jpeg static-libs test tiff"

DEPEND="
	jpeg? ( xmedia-lib/libjpeg-turbo )
	tiff? ( >=xmedia-lib/tiff-4.0.3-r6:0= )
"

src_prepare() {
	use static-libs && lto-guarantee-fat
	default
}

src_configure() {
	local myconf=(
		$(use_with jpeg)
		$(use_enable static-libs static)
		$(use_with tiff)
		--without-zlib
	)
	ECONF_SOURCE="${S}" econf ${myconf[@]}
}

src_install() {
	default
	use static-libs && strip-lto-bytecode
}
