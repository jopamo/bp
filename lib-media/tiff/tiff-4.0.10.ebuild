# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools libtool

DESCRIPTION="Tag Image File Format (TIFF) library"
HOMEPAGE="http://libtiff.maptools.org"
SRC_URI="http://download.osgeo.org/libtiff/${P}.tar.gz
	ftp://ftp.remotesensing.org/pub/libtiff/${P}.tar.gz"

LICENSE="libtiff"
SLOT="0/1"
KEYWORDS="amd64 arm64"

IUSE="+cxx jbig jpeg lzma static-libs test zlib"

DEPEND="jpeg? ( lib-media/libjpeg-turbo )
	jbig? ( >=lib-media/jbigkit-2.1:= )
	lzma? ( >=app-compression/xz-utils-5.0.5-r1:= )
	zlib? ( >=lib-sys/zlib-1.2.8-r1:= )"

REQUIRED_USE="test? ( jpeg )" #483132

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	ECONF_SOURCE="${S}" econf \
		$(use_enable static-libs static) \
		$(use_enable zlib) \
		$(use_enable jpeg) \
		$(use_enable jbig) \
		$(use_enable lzma) \
		$(use_enable cxx) \
		--without-x
}

src_test() {
	emake check
}
