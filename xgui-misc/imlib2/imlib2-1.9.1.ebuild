# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic

DESCRIPTION="Version 2 of an advanced replacement library for libraries like libXpm"
HOMEPAGE="https://www.enlightenment.org/"

if [[ ${PV} == *9999 ]]; then
	EGIT_REPO_URI=https://git.enlightenment.org/legacy/imlib2.git
	inherit git-r3
else
	SRC_URI="https://downloads.sourceforge.net/enlightenment/${P}.tar.xz"
fi

LICENSE="Imlib2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="gif jpeg png static-libs tiff X zlib webp"

DEPEND="
	xgui-misc/freetype
	gif? ( xmedia-live-lib/giflib )
	jpeg? ( xmedia-live-lib/libjpeg-turbo )
	png? ( xmedia-live-lib/libpng )
	tiff? ( xmedia-live-lib/tiff )
	webp? ( xmedia-live-lib/libwebp )
	zlib? ( lib-core/zlib )
	X? (
		xgui-live-app/xorgproto
		xgui-live-lib/libX11
		xgui-live-lib/libXext
	)
"

filter-flags -Wl,-z,defs

src_configure() {
	local myconf=(
		$(use_enable static-libs static)
		$(use_with X x)
		$(use_with jpeg)
		$(use_with png)
		$(use_with tiff)
		$(use_with gif)
		$(use_with zlib)
		$(use_with webp)
	)

	ECONF_SOURCE="${S}" econf "${myconf[@]}"
}
