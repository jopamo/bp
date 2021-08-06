# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 flag-o-matic

DESCRIPTION="Complete solution to record, convert and stream audio and video. Includes libavcodec"
HOMEPAGE="http://ffmpeg.org/"
EGIT_REPO_URI="https://www.github.com/ffmpeg/ffmpeg.git"
EGIT_BRANCH="release/$(ver_cut 1).$(ver_cut 2)"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="debug nvidia +x264 +x265 vaapi vdpau static-libs +openssl
	+ffmpeg +network +protocols +nonfree +gpl +version3 +avutil
	+avcodec +avformat +swscale +avresample +swresample +avfilter
	+lame +libass +vorbis"

DEPEND="
	lame? ( xmedia-live-app/lame )
	vorbis? ( xmedia-live-lib/libvorbis )
	dev-lang/yasm
	x264? ( xmedia-live-lib/x264 )
	x265? ( xmedia-live-lib/x265 )
	xmedia-live-lib/libass
	nvidia? ( xmedia-live-lib/nv-codec-headers )
	vaapi? ( x11-live-lib/libva
		x11-live-lib/libva-intel-driver )
	vdpau? ( xgui-live-lib/libvdpau )
"

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
		--extra-cflags="${CFLAGS}" \
  		--extra-cxxflags="${CXXFLAGS}" \
		$(use_enable avcodec) \
		$(use_enable avfilter) \
		$(use_enable avformat) \
		$(use_enable avresample) \
		$(use_enable avutil) \
		$(use_enable debug) \
		$(use_enable ffmpeg) \
		$(use_enable gpl) \
		$(use_enable lame libmp3lame) \
		$(use_enable libass) \
		$(use_enable network) \
		$(use_enable nonfree) \
		$(use_enable openssl) \
		$(use_enable protocols) \
		$(use_enable static-libs static) \
		$(use_enable swresample) \
		$(use_enable swscale) \
		$(use_enable vaapi) \
		$(use_enable vdpau) \
		$(use_enable version3) \
		$(use_enable vorbis libvorbis) \
		$(use_enable x264 libx264) \
		$(use_enable x265 libx265) \
		--disable-doc \
		--disable-htmlpages \
		--disable-manpages \
		--disable-podpages \
		--disable-txtpages \
		--enable-decoders \
		--enable-demuxers \
		--enable-encoder=flac,png,libmp3lame \
		--enable-filters \
		--enable-lto \
        	--enable-muxer=matroska,mp4 \
        	--disable-stripping
}
