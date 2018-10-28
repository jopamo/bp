# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit autotools eutils libtool multilib-minimal

DESCRIPTION="A lossy image compression format"
HOMEPAGE="https://developers.google.com/speed/webp/download"
SRC_URI="http://downloads.webmproject.org/releases/webp/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/7" # subslot = libwebp soname version
KEYWORDS="amd64 arm64 x86"
IUSE="cpu_flags_x86_avx2 cpu_flags_x86_sse2 cpu_flags_x86_sse4_1 gif +jpeg neon opengl +png static-libs swap-16bit-csp tiff"

# TODO: dev-lang/swig bindings in swig/ subdirectory
RDEPEND="gif? ( lib-media/giflib:= )
	jpeg? ( lib-media/libjpeg-turbo )
	opengl? (
		lib-media/freeglut
		lib-media/mesa
		)
	png? ( lib-media/libpng:0= )
	tiff? ( lib-media/tiff:0= )"
DEPEND="${RDEPEND}"

ECONF_SOURCE=${S}

src_prepare() {
	default

	# Fix libtool relinking, bug 499270.
	#elibtoolize
	eautoreconf
}

multilib_src_configure() {
	local args=(
		--enable-libwebpmux
		--enable-libwebpdemux
		--enable-libwebpdecoder
		$(use_enable static-libs static)
		$(use_enable swap-16bit-csp)
		$(use_enable jpeg)
		$(use_enable png)
		$(use_enable opengl gl)
		$(use_enable tiff)

		$(use_enable cpu_flags_x86_avx2 avx2)
		$(use_enable cpu_flags_x86_sse2 sse2)
		$(use_enable cpu_flags_x86_sse4_1 sse4.1)
		$(use_enable neon)

		# Only used for gif2webp binary wrt #486646
		$(multilib_native_use_enable gif)
	)

	econf "${args[@]}"
}
