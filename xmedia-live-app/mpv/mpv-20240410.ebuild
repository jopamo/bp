# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson xdg

DESCRIPTION="Media player based on MPlayer and mplayer2"
HOMEPAGE="https://mpv.io/"

SNAPSHOT=a6c38b93a2182d62a8d9b9c9bc73f18a81f24bef
SB_SNAPSHOT=a6c38b93a2182d62a8d9b9c9bc73f18a81f24bef

SRC_URI="https://github.com/mpv-player/mpv/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz
		https://codeberg.org/jouni/mpv_sponsorblock_minimal/raw/commit/${SB_SNAPSHOT}/sponsorblock_minimal.lua"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="LGPL-2.1+ GPL-2+ BSD ISC"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="+alsa +cli cuda drm +egl iconv jpeg lcms libmpv +lua +opengl pipewire
	pulseaudio vaapi vapoursynth vdpau vulkan wayland +X xv zlib"

REQUIRED_USE="
	|| ( cli libmpv )
	lcms? ( opengl )
	opengl? ( || ( egl X !cli ) )
	vaapi? ( || ( X wayland ) )
	wayland? ( egl )
	xv? ( X )
"

DEPEND="
	app-dev/vulkan-headers
	fonts/liberation-fonts
	xmedia-live-app/ffmpeg
	xmedia-live-lib/libass
	xmedia-live-lib/libplacebo
	alsa? ( xgui-misc/alsa-lib )
	cuda? (
		bin/nvidia-drivers[X]
		bin/nvidia-cuda
		xmedia-live-lib/nv-codec-headers
	)
	drm? ( xgui-live-lib/libdrm )
	jpeg? ( xmedia-live-lib/libjpeg-turbo )
	lcms? ( xgui-misc/lcms )
	lua? ( app-lang/luajit )
	pipewire? ( xgui-misc/pipewire )
	pulseaudio? ( xgui-misc/pulseaudio )
	vaapi? ( xgui-live-lib/libva:=[drm?,X?,wayland?] )
	vapoursynth? ( xmedia-live-lib/vapoursynth )
	vdpau? ( xgui-live-lib/libvdpau )
	vulkan? (
		xmedia-live-lib/shaderc
		xmedia-live-lib/vulkan-loader[X?,wayland?]
	)
	wayland? (
		xgui-live-lib/wayland
		xgui-live-lib/libxkbcommon
		xgui-live-lib/wayland-protocols
	)
	X? (
		xgui-live-lib/libX11
		xgui-live-lib/libXScrnSaver
		xgui-live-lib/libXext
		xgui-live-lib/libXinerama
		xgui-live-lib/libXpresent
		xgui-live-lib/libXrandr
		opengl? (
			xgui-live-lib/libXdamage
			xgui-misc/mesa
		)
		xv? ( xgui-live-lib/libXv )
	)
	zlib? ( lib-core/zlib )
"

src_prepare() {
	default

	#find a better way?
	#git config --global --add safe.directory "${WORKDIR}/mpv-9999"
}

src_configure() {
	local emesonargs=(
		# booleans
		$(meson_use cli cplayer)
		$(meson_use libmpv)
		-D build-date=false

		#misc
		$(meson_feature iconv)
		$(meson_feature lcms lcms2)
		$(meson_feature lua)
		$(meson_feature vapoursynth)
		$(meson_feature zlib)
		-D cdda=disabled
		-D cplugins=disabled
		-D dvbin=disabled
		-D dvdnav=disabled
		-D javascript=disabled
		-D libarchive=disabled
		-D libavdevice=disabled
		-D libbluray=disabled
		-D rubberband=disabled
		-D sdl2-gamepad=disabled
		-D sdl2=disabled
		-D uchardet=disabled
		-D uwp=disabled
		-D zimg=disabled

		# audio output features
		$(meson_feature alsa)
		$(meson_feature pulseaudio pulse)
		$(meson_feature pipewire)

		# video output features
		-D caca=disabled
		$(meson_feature drm)
		$(meson_feature egl)
		$(meson_feature jpeg)
		$(meson_feature opengl gl)
		$(meson_feature vaapi)
		$(meson_feature vdpau)
		$(meson_feature vulkan)
		$(meson_feature vulkan shaderc)
		$(meson_feature X x11)
		$(meson_feature xv)
		$(meson_feature wayland)

		# hwaccel features
		$(meson_feature cuda cuda-hwaccel)
		$(meson_feature cuda cuda-interop)
		-D d3d-hwaccel=disabled
		-D d3d9-hwaccel=disabled
		-D gl-dxinterop-d3d9=disabled
		-D ios-gl=disabled
		-D videotoolbox-gl=disabled

	)
		meson_src_configure
}

src_install() {
	meson_src_install

	insinto etc/${PN}
	doins ${FILESDIR}/mpv.conf

	if use lua; then
		insinto /usr/share/${PN}
		doins -r TOOLS/lua

		insinto /etc/mpv/scripts
		doins "${DISTDIR}"/sponsorblock_minimal.lua
	fi
}
