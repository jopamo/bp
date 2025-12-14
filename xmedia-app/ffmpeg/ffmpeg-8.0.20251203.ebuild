# Distributed under the terms of the GNU General Public License v2

EAPI=8

BRANCH_NAME="release/$(ver_cut 1-2)"

inherit flag-o-matic toolchain-funcs

DESCRIPTION="Complete solution to record, convert and stream audio and video. Includes libavcodec"
HOMEPAGE="http://ffmpeg.org/"
SNAPSHOT=f9a3e1b7763669c5a29287b1dadc2f6288677e97
SRC_URI="https://github.com/FFmpeg/FFmpeg/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/FFmpeg-${SNAPSHOT}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="
	+alsa +avcodec +avdevice +avfilter +avformat +avutil debug
	+gpl +ffmpeg +lame +libass +libdav1d +libxcb +network +nonfree
	nvidia +openssl postproc +protocols pulseaudio static-libs
	+swscale +swresample +version3 +vorbis vulkan vaapi vdpau
	+x264 +x265 +opus +vpx
"

DEPEND="
	app-lang/nasm

	lame? ( xmedia-lib/lame )
	vorbis? ( xmedia-lib/libvorbis )
	opus? ( xmedia-lib/opus )
	vpx? ( xmedia-lib/libvpx )
	libass? ( xmedia-lib/libass )
	libdav1d? ( xmedia-lib/libdav1d )

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

	local myconf=(
		--prefix="${EPREFIX}/usr"
		--shlibdir="${EPREFIX}/usr/lib"
		--bindir="${EPREFIX}/usr/bin"
		--libdir="${EPREFIX}/usr/lib"

		--enable-shared
		--enable-pic
		--enable-lto

		--enable-gpl
		--enable-version3
		--enable-nonfree

		--disable-doc
		--disable-htmlpages
		--disable-manpages
		--disable-podpages
		--disable-txtpages
		--disable-stripping

		--cc="$(tc-getCC)"
		--cxx="$(tc-getCXX)"
		--ar="$(tc-getAR)"
		--extra-cflags="${CFLAGS}"
		--extra-cxxflags="${CXXFLAGS}"

		$(use_enable debug)

		# core components
		$(use_enable avcodec)
		$(use_enable avdevice)
		$(use_enable avfilter)
		$(use_enable avformat)
		$(use_enable avutil)
		$(use_enable swresample)
		$(use_enable swscale)
		$(use_enable protocols)
		$(use_enable network)

		# audio outputs
		$(use_enable alsa)
		$(use_enable pulseaudio libpulse)

		# hw accel and display
		$(use_enable vaapi)
		$(use_enable vdpau)
		$(use_enable vulkan)
		$(use_enable libxcb)
		$(use_enable libxcb libxcb-shm)
		$(use_enable libxcb libxcb-xfixes)
		$(use_enable libxcb libxcb-shape)

		# crypto / tls
		$(use_enable openssl)

		# third party codec libs
		$(use_enable lame libmp3lame)
		$(use_enable vorbis libvorbis)
		$(use_enable opus libopus)
		$(use_enable vpx libvpx)
		$(use_enable libass)
		$(use_enable libdav1d)
		$(use_enable x264 libx264)
		$(use_enable x265 libx265)

		# nvidia stack
		$(use_enable nvidia cuvid)
		$(use_enable nvidia ffnvcodec)
		$(use_enable nvidia nvdec)

		# cli tool
		$(use_enable ffmpeg)

		# audio decoders
		--enable-decoder=aac
		--enable-decoder=aac_fixed
		--enable-decoder=mp3
		--enable-decoder=opus
		--enable-decoder=vorbis
		--enable-decoder=flac
		--enable-decoder=ac3
		--enable-decoder=eac3

		# video decoders
		--enable-decoder=h264
		--enable-decoder=hevc
		--enable-decoder=vp8
		--enable-decoder=vp9
		--enable-decoder=av1

		# parsers
		--enable-parser=aac
		--enable-parser=h264
		--enable-parser=hevc
		--enable-parser=vp8
		--enable-parser=vp9
		--enable-parser=av1

		# containers / demuxers
		--enable-demuxer=mov
		--enable-demuxer=matroska
		--enable-demuxer=webm
		--enable-demuxer=ogg
		--enable-demuxer=mp3
		--enable-demuxer=flac
		--enable-demuxer=wav
		--enable-demuxer=hls
		--enable-demuxer=mpegts

		# containers / muxers
		--enable-muxer=mp4
		--enable-muxer=matroska
		--enable-muxer=webm
		--enable-muxer=ogg
		--enable-muxer=mp3
		--enable-muxer=flac
		--enable-muxer=wav
		--enable-muxer=hls
		--enable-muxer=segment
	)

	if use nvidia; then
		myconf+=(
			--nvccflags="-gencode arch=compute_75,code=sm_75 -O2 -I/opt/cuda/targets/x86_64-linux/include -allow-unsupported-compiler"
			--extra-cflags="${CFLAGS} -I/opt/cuda/targets/x86_64-linux/include"
			--extra-ldflags="-L/opt/cuda/targets/x86_64-linux/lib"
		)
	fi

	${S}/configure "${myconf[@]}"
}
