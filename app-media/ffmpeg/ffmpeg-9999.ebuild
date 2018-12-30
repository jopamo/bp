# Distributed under the terms of the GNU General Public License v2

EAPI=6

EGIT_REPO_URI="https://www.github.com/ffmpeg/ffmpeg.git"

inherit multilib-minimal git-r3 flag-o-matic

DESCRIPTION="Complete solution to record, convert and stream audio and video. Includes libavcodec"
HOMEPAGE="http://ffmpeg.org/"

SLOT="0"
LICENSE="GPL-3"

KEYWORDS="amd64 arm64 x86"

IUSE="debug nvidia static-libs
"

DEPEND="
	>=app-media/lame-3.99.5-r1[${MULTILIB_USEDEP}]
	dev-lang/yasm
	nvidia? ( lib-media/nv-codec-headers[${MULTILIB_USEDEP}] )
"

S=${WORKDIR}/${P/_/-}

MULTILIB_WRAPPED_HEADERS=(
	/usr/include/libavutil/avconfig.h
)

multilib_src_configure() {
	filter-flags -fno-common

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
		--enable-openssl \
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
