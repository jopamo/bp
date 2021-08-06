# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools libtool git-r3

DESCRIPTION="Tag Image File Format (TIFF) library"
HOMEPAGE="http://libtiff.maptools.org"
EGIT_REPO_URI="https://gitlab.com/libtiff/libtiff.git"

LICENSE="libtiff"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="+cxx jbig jpeg lzma static-libs test webp zlib zstd"

DEPEND="jpeg? ( lib-media/libjpeg-turbo )
	jbig? ( >=lib-media/jbigkit-2.1:= )
	lzma? ( >=app-compression/xz-utils-5.0.5-r1:= )
	webp? ( lib-media/libwebp )
	zlib? ( >=lib-sys/zlib-1.2.8-r1:= )
	zstd? ( app-compression/zstd )"

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
		$(use_enable webp) \
		$(use_enable zstd) \
		--without-x
}

src_test() {
	emake check
}
