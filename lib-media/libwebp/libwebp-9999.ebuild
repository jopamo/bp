# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools git-r3

DESCRIPTION="A lossy image compression format"
HOMEPAGE="https://developers.google.com/speed/webp/download"
EGIT_REPO_URI="https://github.com/webmproject/libwebp.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="gif +jpeg neon opengl +png static-libs swap-16bit-csp tiff"

DEPEND="gif? ( lib-media/giflib:= )
	jpeg? ( lib-media/libjpeg-turbo )
	opengl? (
		lib-media/freeglut
		lib-media/mesa
		)
	png? ( lib-media/libpng:0= )
	tiff? ( lib-media/tiff:0= )"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/lib
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		--enable-libwebpmux
		--enable-libwebpdemux
		--enable-libwebpdecoder
		$(use_enable static-libs static)
		$(use_enable swap-16bit-csp)
		$(use_enable jpeg)
		$(use_enable png)
		$(use_enable opengl gl)
		$(use_enable tiff)
		$(use_enable neon)
		$(use_enable gif)
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
