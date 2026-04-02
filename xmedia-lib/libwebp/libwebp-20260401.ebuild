# Distributed under the terms of the GNU General Public License v2

inherit autotools qa-policy

DESCRIPTION="A lossy image compression format"
HOMEPAGE="https://developers.google.com/speed/webp/download"
SNAPSHOT=0c9546f7efc61eac7f79ae115c3f99c91c21c443
SRC_URI="https://github.com/webmproject/libwebp/archive/${SNAPSHOT}.tar.gz -> libwebp-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/libwebp-${SNAPSHOT}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="jpeg keep-la png static-libs tiff"

DEPEND="
	jpeg? ( xmedia-lib/libjpeg-turbo )
	png? ( xmedia-lib/libpng )
	tiff? ( xmedia-lib/tiff )
"

src_prepare() {
	qa-policy-configure
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

src_install() {
	default
	qa-policy-install

	if ! use keep-la; then
		find "${ED}" -name '*.la' -delete || die
	fi
}
