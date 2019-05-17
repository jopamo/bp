# Distributed under the terms of the GNU General Public License v2

EAPI="5"

EGIT_REPO_URI=https://git.enlightenment.org/legacy/imlib2.git

inherit toolchain-funcs git-r3 autotools

DESCRIPTION="Version 2 of an advanced replacement library for libraries like libXpm"
HOMEPAGE="https://www.enlightenment.org/"
KEYWORDS="amd64 arm64"

IUSE="bzip2 gif jpeg png static-libs tiff X zlib"
SLOT=0
RDEPEND="lib-media/freetype:2
	bzip2? ( >=app-compression/lbzip2-1.0.6-r4 )
	zlib? ( >=lib-sys/zlib-1.2.8-r1 )
	gif? ( >=lib-media/giflib-4.1.6-r3:0= )
	png? ( >=lib-media/libpng-1.6.10:0= )
	jpeg? ( lib-media/libjpeg-turbo )
	tiff? ( >=lib-media/tiff-4.0.3-r6:0 )
	X? (
		>=x11-libs/libX11-1.6.2
		>=x11-libs/libXext-1.3.2
	)"
DEPEND="${RDEPEND}
	>=dev-util/pkgconf-0-r1
	X? ( x11-misc/xorgproto )"

src_prepare() {
	eautoreconf
}

src_configure() {
	[[ $(gcc-major-version) -ge 4 ]] && E_ECONF+=( --enable-visibility-hiding )

	ECONF_SOURCE="${S}" \
	E_ECONF+=(
		$(use_enable static-libs static)
		$(use_with X x)
		$(use_with jpeg)
		$(use_with png)
		$(use_with tiff)
		$(use_with gif)
		$(use_with zlib)
		$(use_with bzip2)
	)

	has static-libs ${IUSE} && E_ECONF+=( $(use_enable static-libs static) )

	econf ${MY_ECONF} "${E_ECONF[@]}"
}
