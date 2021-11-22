# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs autotools flag-o-matic

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
	xgui-misc/freetype
	bzip2? ( app-compression/bzip2 )
	zlib? ( lib-core/zlib )
	gif? ( xmedia-live-lib/giflib )
	png? ( xmedia-live-lib/libpng )
	jpeg? ( xmedia-live-lib/libjpeg-turbo )
	tiff? ( xmedia-live-lib/tiff )
	webp? ( xmedia-live-lib/libwebp )
	X? (
		xgui-live-lib/libX11
		xgui-live-lib/libXext
		xgui-live-app/xorgproto
	)
"

filter-flags -Wl,-z,defs

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
