# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit autotools eutils libtool multilib-minimal

DESCRIPTION="Tag Image File Format (TIFF) library"
HOMEPAGE="http://libtiff.maptools.org"
SRC_URI="http://download.osgeo.org/libtiff/${P}.tar.gz
	ftp://ftp.remotesensing.org/pub/libtiff/${P}.tar.gz"

LICENSE="libtiff"
SLOT="0"
KEYWORDS="amd64 arm64 x86"
IUSE="+cxx jbig jpeg lzma static-libs test zlib"

RDEPEND="jpeg? ( lib-media/libjpeg-turbo[${MULTILIB_USEDEP}] )
	jbig? ( >=lib-media/jbigkit-2.1:=[${MULTILIB_USEDEP}] )
	lzma? ( >=app-compression/xz-utils-5.0.5-r1:=[${MULTILIB_USEDEP}] )
	zlib? ( >=lib-sys/zlib-1.2.8-r1:=[${MULTILIB_USEDEP}] )
	abi_x86_32? (
		!<=app-misc/emul-linux-x86-baselibs-20130224-r9
		!app-misc/emul-linux-x86-baselibs[-abi_x86_32(-)]
	)"
DEPEND="${RDEPEND}"

REQUIRED_USE="test? ( jpeg )" #483132

MULTILIB_WRAPPED_HEADERS=(
	/usr/include/tiffconf.h
)

src_prepare() {
	default
	eautoreconf
}

multilib_src_configure() {
	ECONF_SOURCE="${S}" econf \
		$(use_enable static-libs static) \
		$(use_enable zlib) \
		$(use_enable jpeg) \
		$(use_enable jbig) \
		$(use_enable lzma) \
		$(use_enable cxx) \
		--without-x

	# remove useless subdirs
	if ! multilib_is_native_abi ; then
		sed -i \
			-e 's/ tools//' \
			-e 's/ contrib//' \
			-e 's/ man//' \
			-e 's/ html//' \
			Makefile || die
	fi
}

multilib_src_test() {
	if ! multilib_is_native_abi ; then
		emake -C tools
	fi
	emake check
}

