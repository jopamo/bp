# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 flag-o-matic

DESCRIPTION="Complete solution to record, convert and stream audio and video. Includes libavcodec"
HOMEPAGE="http://ffmpeg.org/"
EGIT_REPO_URI="https://www.github.com/ffmpeg/ffmpeg.git"

LICENSE="GPL-3"
SLOT="0/1"
KEYWORDS="amd64 arm64"

IUSE="debug nvidia vaapi static-libs"

DEPEND="
	>=app-media/lame-3.99.5-r1
	dev-lang/yasm
	nvidia? ( lib-media/nv-codec-headers )
	vaapi? ( 	x11-libs/libva
				x11-libs/libva-intel-driver
		)
"

S=${WORKDIR}/${P/_/-}

filter-flags -fno-common
append-flags -ffat-lto-objects

src_configure() {
	${S}/configure \
		--prefix="${EPREFIX}/usr" \
		--shlibdir="${EPREFIX}/usr/lib" \
		--bindir="${EPREFIX}"/usr/bin \
		--libdir="${EPREFIX}"/usr/lib \
		--enable-shared \
		--cc="$(tc-getCC)" \
		--cxx="$(tc-getCXX)" \
		--ar="$(tc-getAR)" \
		--optflags="${CFLAGS}" \
		--enable-pic \
		--enable-lto \
		--enable-ffmpeg \
		--enable-network	\
		--enable-protocols	\
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
        $(use_enable vaapi) \
		--enable-libmp3lame \
		--enable-libvorbis \
		--enable-encoder=flac,png \
		--enable-encoder=libmp3lame \
		--enable-openssl \
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
