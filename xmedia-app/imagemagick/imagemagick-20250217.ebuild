# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A collection of tools and libraries for many image formats"
HOMEPAGE="https://www.imagemagick.org/"

SNAPSHOT=1deefc5c430b6ba0d5af001de3787c51f179cd11
SRC_URI="https://github.com/ImageMagick/ImageMagick/archive/${SNAPSHOT}.tar.gz -> ImageMagick-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/ImageMagick-${SNAPSHOT}"

LICENSE="imagemagick"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="bzip2 cxx fftw fontconfig fpx graphviz hdri heif jbig +jpeg +jpeg2k
lcms lqr lzma opencl openexr pango perl postscript +png raw static-libs
+svg test +tiff truetype +webp wmf X +xml zlib"

DEPEND="
	jpeg2k? ( xmedia-lib/openjpeg )
	jpeg? ( xmedia-lib/libjpeg-turbo )
	png? ( xmedia-lib/libpng )
	svg? ( xgui-lib/librsvg )
	tiff? ( xmedia-lib/tiff )
	webp? ( xmedia-lib/libwebp )
"

src_prepare() {
	default
	touch NEWS.txt
}

src_configure() {
	local myconf=(
		$(use_enable hdri)
		$(use_enable opencl)
		$(use_enable static-libs static)
		$(use_with X x)
		$(use_with bzip2 bzlib)
		$(use_with cxx magick-plus-plus)
		$(use_with fftw)
		$(use_with fontconfig)
		$(use_with fpx)
		$(use_with graphviz gvc)
		$(use_with heif heic)
		$(use_with jbig)
		$(use_with jpeg)
		$(use_with jpeg2k openjp2)
		$(use_with lcms)
		$(use_with lqr)
		$(use_with lzma)
		$(use_with openexr)
		$(use_with pango)
		$(use_with perl)
		$(use_with png)
		$(use_with postscript dps)
		$(use_with postscript gslib)
		$(use_with raw)
		$(use_with svg rsvg)
		$(use_with tiff)
		$(use_with truetype freetype)
		$(use_with webp)
		$(use_with wmf)
		$(use_with xml)
		$(use_with zlib)
		--without-autotrace
		--without-dps
		--without-fftw
		--without-fpx
		--without-gcc-arch
		--without-gvc
	)
	econf "${myconf[@]}"
}
