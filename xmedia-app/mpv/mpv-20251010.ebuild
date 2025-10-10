# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson xdg

DESCRIPTION="Media player based on MPlayer and mplayer2"
HOMEPAGE="https://mpv.io/"
SNAPSHOT=67330ba2de700d887e0479c736213d18f221fa00
SRC_URI="https://github.com/mpv-player/mpv/archive/${SNAPSHOT}.tar.gz -> mpv-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/mpv-${SNAPSHOT}

LICENSE="LGPL-2.1+ GPL-2+ BSD ISC"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="alsa cli cuda drm egl iconv jpeg lcms libmpv lua opengl pipewire
	pulseaudio vaapi vapoursynth vdpau vulkan wayland +X zlib"

REQUIRED_USE="
	|| ( cli libmpv )
	lcms? ( opengl )
	opengl? ( || ( egl X !cli ) )
	vaapi? ( || ( X wayland ) )
	wayland? ( egl )
"

DEPEND="
	xgui-app/libdisplay-info
	xmedia-app/ffmpeg
	xmedia-lib/libass
	xmedia-lib/libplacebo
	alsa? ( xgui-tools/alsa-lib )
	cuda? (
		bin/nvidia-drivers[X]
		bin/nvidia-cuda
		xmedia-lib/nv-codec-headers
	)
	drm? ( xgui-lib/libdrm )
	jpeg? ( xmedia-lib/libjpeg-turbo )
	lcms? ( xgui-lib/lcms )
	lua? ( app-lang/luajit )
	pipewire? ( xgui-misc/pipewire )
	pulseaudio? ( xgui-misc/pulseaudio )
	vaapi? ( xgui-lib/libva:=[drm?,X?,wayland?] )
	vapoursynth? ( xmedia-lib/vapoursynth )
	vdpau? ( xgui-lib/libvdpau )
	vulkan? (
		app-dev/vulkan-headers
		xmedia-lib/vulkan-loader[X?,wayland?]
	)
	wayland? (
		xgui-lib/wayland
		xgui-lib/libxkbcommon
		xgui-lib/wayland-protocols
	)
	X? (
		xgui-lib/libX11
		xgui-lib/libXScrnSaver
		xgui-lib/libXext
		xgui-lib/libXinerama
		xgui-lib/libXpresent
		xgui-lib/libXrandr
		opengl? (
			xgui-lib/libXdamage
			xgui-tools/mesa
		)
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
		-D shaderc=disabled
		$(meson_feature X x11)
		-D xv=disabled
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

	insinto etc/mpv
	newins ${FILESDIR}/mpv.conf.fast mpv.conf

	if use lua; then
		insinto /usr/share/mpv
		doins -r TOOLS/lua

		insinto /etc/mpv/scripts
		doins "${FILESDIR}"/sponsorblock_minimal.lua
	fi
}
