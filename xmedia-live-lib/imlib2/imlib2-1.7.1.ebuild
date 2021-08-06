# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs autotools

DESCRIPTION="Version 2 of an advanced replacement library for libraries like libXpm"
HOMEPAGE="https://www.enlightenment.org/"

if [[ ${PV} == *9999* ]]; then
	EGIT_REPO_URI=https://git.enlightenment.org/legacy/imlib2.git
	inherit git-r3
else
	SRC_URI="https://downloads.sourceforge.net/enlightenment/${P}.tar.bz2"
fi

LICENSE="Imlib2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="bzip2 gif jpeg png static-libs tiff X zlib webp"

DEPEND="
	xmedia-live-lib/freetype:2
	bzip2? ( >=app-compression/lbzip2-1.0.6-r4 )
	zlib? ( >=lib-sys/zlib-1.2.8-r1 )
	gif? ( >=xmedia-live-lib/giflib-4.1.6-r3:0= )
	png? ( >=xmedia-live-lib/libpng-1.6.10:0= )
	jpeg? ( xmedia-live-lib/libjpeg-turbo )
	tiff? ( >=xmedia-live-lib/tiff-4.0.3-r6:0 )
	webp? ( xmedia-live-lib/libwebp:0 )
	X? (
		x11-live-lib/libX11
		x11-live-lib/libXext
		x11-live-misc/xorgproto
	)
"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		$(use_enable static-libs static)
		$(use_with X x)
		$(use_with jpeg)
		$(use_with png)
		$(use_with tiff)
		$(use_with gif)
		$(use_with zlib)
		$(use_with bzip2)
		$(use_with webp)
	)

	ECONF_SOURCE="${S}" econf "${myconf[@]}"
}
