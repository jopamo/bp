# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 flag-o-matic

DESCRIPTION="Complete solution to record, convert and stream audio and video. Includes libavcodec"
HOMEPAGE="http://ffmpeg.org/"
EGIT_REPO_URI="https://www.github.com/ffmpeg/ffmpeg.git"
EGIT_BRANCH="release/$(ver_cut 1).$(ver_cut 2)"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="
	+alsa +avcodec avdevice +avfilter +avformat +avutil debug
	nvidia x264 +x265 vaapi vdpau static-libs +openssl +ffmpeg
	+network postproc +protocols pulseaudio +nonfree +gpl +version3
	 +swscale +swresample  +lame +libass +libdav1d +vorbis vulkan
"

DEPEND="
	app-lang/nasm
	xmedia-live-lib/libass
	lame? ( xmedia-live-app/lame )
	vorbis? ( xmedia-live-lib/libvorbis )
	libdav1d? ( xmedia-live-lib/libdav1d )
	x264? ( xmedia-live-lib/x264 )
	x265? ( xmedia-live-lib/x265 )
	nvidia? (
		xmedia-live-lib/nv-codec-headers
		bin/nvidia-cuda
	)
	vaapi? (
		xgui-live-lib/libva
		xgui-live-lib/libva-intel-driver
	)
	vdpau? ( xgui-live-lib/libvdpau )
"

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
