# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3 flag-o-matic

DESCRIPTION="Complete solution to record, convert and stream audio and video. Includes libavcodec"
HOMEPAGE="http://ffmpeg.org/"
EGIT_REPO_URI="https://www.github.com/ffmpeg/ffmpeg.git"

SLOT="0"
LICENSE="GPL-3"

KEYWORDS="amd64 arm64"

IUSE="debug nvidia static-libs"

DEPEND="
	>=app-media/lame-3.99.5-r1
	dev-lang/yasm
	nvidia? ( lib-media/nv-codec-headers )
"

S=${WORKDIR}/${P/_/-}

filter-flags -flto -fno-common

src_configure() {
	${S}/configure \
		--prefix="${EPREFIX}/usr" \
		--shlibdir="${EPREFIX}/usr/lib64" \
		--bindir="${EPREFIX}"/usr/bin \
		--libdir="${EPREFIX}"/usr/lib64 \
		--enable-shared \
		--cc="$(tc-getCC)" \
		--cxx="$(tc-getCXX)" \
		--ar="$(tc-getAR)" \
		--optflags="${CFLAGS}" \
		--disable-all \
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
		--enable-libmp3lame \
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
