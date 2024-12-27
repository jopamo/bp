# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic

DESCRIPTION="Complete solution to record, convert and stream audio and video. Includes libavcodec"
HOMEPAGE="http://ffmpeg.org/"

SNAPSHOT=b168ed9b146337e7bd3c218c5d1c0f7e88bf1315
SRC_URI="https://github.com/FFmpeg/FFmpeg/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/FFmpeg-${SNAPSHOT}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="
	+alsa +avcodec +avdevice +avfilter +avformat +avutil debug
	+gpl +ffmpeg +lame +libass +libdav1d +libxcb +network +nonfree
	nvidia +openssl postproc +protocols pulseaudio static-libs
    +swscale +swresample +version3 +vorbis vulkan vaapi vdpau
	+x264 +x265
"

DEPEND="
	app-lang/nasm
	xmedia-lib/libass
	lame? ( xmedia-lib/lame )
	vorbis? ( xmedia-lib/libvorbis )
	libdav1d? ( xmedia-lib/libdav1d )
	libxcb? ( xgui-lib/libxcb )
	x264? ( xmedia-lib/x264 )
	x265? ( xmedia-lib/x265 )
	nvidia? (
		xmedia-lib/nv-codec-headers
		bin/nvidia-cuda
	)
	vaapi? (
		xgui-lib/libva
		xgui-lib/libva-intel-driver
	)
	vdpau? ( xgui-lib/libvdpau )
"

src_configure() {
	append-flags -ffat-lto-objects

	${S}/configure \
		--prefix="${EPREFIX}/usr" \
		--shlibdir="${EPREFIX}/usr/lib" \
		--bindir="${EPREFIX}"/usr/bin \
		--libdir="${EPREFIX}"/usr/lib \
		--enable-shared \
		--cc="$(tc-getCC)" \
		--cxx="$(tc-getCXX)" \
		--ar="$(tc-getAR)" \
		--extra-cflags="${CFLAGS}" \
  		--extra-cxxflags="${CXXFLAGS}" \
  		--nvccflags="-gencode arch=compute_75,code=sm_75 -O2 -I/opt/cuda/targets/x86_64-linux/include -allow-unsupported-compiler" \
		$(use_enable alsa) \
		$(use_enable avcodec) \
		$(use_enable avdevice) \
		$(use_enable avfilter) \
		$(use_enable avformat) \
		$(use_enable avutil) \
		$(use_enable debug) \
		$(use_enable ffmpeg) \
		$(use_enable gpl) \
		$(use_enable lame libmp3lame) \
		$(use_enable libxcb) \
		$(use_enable libxcb libxcb-shm) \
		$(use_enable libxcb libxcb-xfixes) \
		$(use_enable libxcb libxcb-shape) \
		$(use_enable libass) \
		$(use_enable libdav1d) \
		$(use_enable network) \
		$(use_enable nonfree) \
		$(use_enable nvidia cuvid) \
		$(use_enable nvidia ffnvcodec) \
		$(use_enable nvidia libnpp) \
		$(use_enable nvidia nvdec) \
		$(usex nvidia '--extra-cflags=-I/opt/cuda/targets/x86_64-linux/include' '') \
		$(usex nvidia '--extra-ldflags=-L/opt/cuda/targets/x86_64-linux/lib' '') \
		$(use_enable openssl) \
		$(use_enable postproc) \
		$(use_enable protocols) \
		$(use_enable pulseaudio libpulse) \
		$(use_enable static-libs static) \
		$(use_enable swresample) \
		$(use_enable swscale) \
		$(use_enable vaapi) \
		$(use_enable vdpau) \
		$(use_enable version3) \
		$(use_enable vorbis libvorbis) \
		$(use_enable vulkan) \
		$(use_enable x264 libx264) \
		$(use_enable x265 libx265) \
		--disable-doc \
		--disable-htmlpages \
		--disable-manpages \
		--disable-podpages \
		--disable-txtpages \
		--enable-pic \
		--enable-lto \
		--enable-nonfree \
		--disable-stripping
}
