# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic autotools

DESCRIPTION="Version 2 of an advanced replacement library for libraries like libXpm"
HOMEPAGE="https://www.enlightenment.org/"
SNAPSHOT=72b610076ab5cd7645d0b439f17486beffda307a
SRC_URI="https://github.com/1g4-mirror/legacy-imlib2/archive/${SNAPSHOT}.tar.gz -> legacy-imlib2-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/legacy-imlib2-${SNAPSHOT}"

LICENSE="Imlib2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="gif jpeg png static-libs tiff X zlib webp"

DEPEND="
	xgui-lib/freetype
	gif? ( xmedia-lib/giflib )
	jpeg? ( xmedia-lib/libjpeg-turbo )
	png? ( xmedia-lib/libpng )
	tiff? ( xmedia-lib/tiff )
	webp? ( xmedia-lib/libwebp )
	zlib? ( lib-core/zlib )
	X? (
		xgui-tools/xorgproto
		xgui-lib/libX11
		xgui-lib/libXext
	)
"

src_prepare() {
	eautoreconf
	cp "${FILESDIR}"/loader_gif.c src/modules/loaders/loader_gif.c

	filter-flags -Wl,-z,defs
	default
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
		$(use_with webp)
	)

	ECONF_SOURCE="${S}" econf "${myconf[@]}"
}
