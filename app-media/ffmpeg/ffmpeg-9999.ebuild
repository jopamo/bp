# Distributed under the terms of the GNU General Public License v2

EAPI=6

EGIT_REPO_URI="https://www.github.com/ffmpeg/ffmpeg.git"

inherit multilib-minimal git-r3

DESCRIPTION="Complete solution to record, convert and stream audio and video. Includes libavcodec"
HOMEPAGE="http://ffmpeg.org/"

SLOT="0"
LICENSE="GPL-3"

KEYWORDS="amd64 arm64 x86"

IUSE="alsa debug mp3 gcrypt openssl vpx doc X +encode jack nvidia oss pic static-libs test v4l +threads vaapi
"

RDEPEND="
	alsa? ( >=lib-media/alsa-lib-1.0.27.2[${MULTILIB_USEDEP}] )
	>=app-media/lame-3.99.5-r1[${MULTILIB_USEDEP}]
	openssl? ( >=lib-dev/openssl-1.0.1h-r2:0[${MULTILIB_USEDEP}] )
	nvidia? ( lib-media/nv-codec-headers[${MULTILIB_USEDEP}] )
	X? (
		>=x11-libs/libX11-1.6.2[${MULTILIB_USEDEP}]
		>=x11-libs/libXext-1.3.2[${MULTILIB_USEDEP}]
		>=x11-libs/libXv-1.0.10[${MULTILIB_USEDEP}]
		>=x11-libs/libxcb-1.4[${MULTILIB_USEDEP}]
	)
"

DEPEND="${RDEPEND}
	>=sys-devel/make-3.81
	doc? ( sys-app/texinfo )
	>=dev-util/pkgconfig-0-r1[${MULTILIB_USEDEP}]
	>=dev-lang/yasm-1.3
	test? ( app-net/wget sys-devel/bc )
	v4l? ( sys-kernel/stable-sources )
"

RDEPEND="${RDEPEND}"

S=${WORKDIR}/${P/_/-}

MULTILIB_WRAPPED_HEADERS=(
	/usr/include/libavutil/avconfig.h
)

multilib_src_configure() {
	${S}/configure \
		--prefix="${EPREFIX}/usr" \
		--shlibdir="${EPREFIX}/usr/$(get_libdir)" \
		--bindir="${EPREFIX}"/usr/bin \
		--libdir="${EPREFIX}"/usr/$(get_libdir) \
		--enable-shared \
		--cc="$(tc-getCC)" \
		--cxx="$(tc-getCXX)" \
		--ar="$(tc-getAR)" \
		--optflags="${CFLAGS}" \
		--disable-all \
		--enable-openssl \
		--enable-nonfree \
		--enable-gpl \
		--enable-version3 \
		--enable-avutil \
        --enable-avcodec \
        --enable-avformat \
        --enable-swscale \
        --enable-avresample \
        --enable-swresample \
        --enable-avfilter \
		--enable-libmp3lame \
		--enable-encoder=flac,png \
		--enable-encoder=libmp3lame \
		--disable-gnutls \
		--disable-indevs \
		--disable-doc \
		--disable-htmlpages \
		--disable-manpages \
		--disable-podpages \
		--disable-txtpages \
		--enable-decoders \
		--enable-demuxers \
        --enable-muxer=matroska \
        --enable-muxer=mp4 \
		$(use_enable static-libs static) \
		--enable-filters \
		$(use_enable debug)
}
