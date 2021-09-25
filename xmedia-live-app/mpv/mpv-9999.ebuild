# Distributed under the terms of the GNU General Public License v2

EAPI=7

WAF_PV=2.0.18

inherit toolchain-funcs waf-utils xdg-utils

DESCRIPTION="Media player based on MPlayer and mplayer2"
HOMEPAGE="https://mpv.io/"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="https://github.com/mpv-player/mpv/archive/v${PV}.tar.gz -> ${P}.tar.gz"
else
	EGIT_REPO_URI="https://github.com/mpv-player/mpv.git"
	inherit git-r3
fi

SRC_URI+=" https://waf.io/waf-${WAF_PV}"

LICENSE="LGPL-2.1+ GPL-2+ BSD ISC"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="+alsa +archive bluray cdda +cli coreaudio cplugins
	cuda drm dvb +egl jack javascript jpeg lcms libcaca
	libmpv  +lua +opengl pulseaudio raspberry-pi rubberband
	sdl uchardet vaapi vdpau wayland +X xv zlib"

REQUIRED_USE="
	|| ( cli libmpv )
	lcms? ( opengl )
	opengl? ( || ( egl X raspberry-pi !cli ) )
	xv? ( X )
	raspberry-pi? ( opengl )
	vaapi? ( || ( X wayland ) )
	wayland? ( egl )
"

COMMON_DEPEND="
	xmedia-live-lib/libass:=
	alsa? ( >=xmedia-live-lib/alsa-lib-1.0.18 )
	archive? ( >=app-compression/libarchive-3.0.0:= )
	bluray? ( >=xmedia-live-lib/libbluray-0.3.0:= )
	cdda? ( lib-dev/libcdio-paranoia )
	drm? ( xgui-live-lib/libdrm )
	uchardet? ( xmedia-live-lib/uchardet )
	jack? ( virtual/jack )
	javascript? ( >=dev-lang/mujs-1.0.0 )
	jpeg? ( xmedia-live-lib/libjpeg-turbo )
	lcms? ( >=xmedia-live-lib/lcms-2.6:2 )
	fonts/liberation-fonts
	libcaca? ( >=xmedia-live-lib/libcaca-0.99_beta18 )
	lua? ( dev-lang/luajit )
	pulseaudio? ( xgui-misc/pulseaudio )
	raspberry-pi? ( >=xmedia-live-lib/raspberrypi-userland-0_pre20160305-r1 )
	rubberband? ( >=xmedia-live-lib/rubberband-1.8.0 )
	sdl? ( xmedia-live-lib/libsdl2[sound,threads,video] )
	vaapi? ( xgui-live-lib/libva:=[drm?,X?,wayland?] )
	vdpau? ( xgui-live-lib/libvdpau )
	wayland? (
		>=xgui-live-lib/wayland-1.6.0
		>=xgui-live-lib/libxkbcommon-0.3.0
		xgui-live-lib/wayland-protocols
	)
	X? (
		xgui-live-lib/libX11
		xgui-live-lib/libXScrnSaver
		xgui-live-lib/libXext
		xgui-live-lib/libXinerama
		xgui-live-lib/libXrandr
		opengl? (
			xgui-live-lib/libXdamage
			xmedia-live-lib/mesa
		)
		xv? ( xgui-live-lib/libXv )
	)
	zlib? ( lib-core/zlib )
"
DEPEND="${COMMON_DEPEND}
	dev-util/pkgconf
	xmedia-live-app/ffmpeg
	dev-util/vulkan-headers
	dvb? ( virtual/linuxtv-dvb-headers )
"
RDEPEND="${COMMON_DEPEND}
	cuda? ( bin/nvidia-drivers[X]
		bin/nvidia-cuda
		xmedia-live-lib/nv-codec-headers )"

src_prepare() {
	cp "${DISTDIR}/waf-${WAF_PV}" "${S}"/waf || die
	chmod +x "${S}"/waf || die
	default
}

src_configure() {
	tc-export CC PKG_CONFIG AR

	local mywafargs=(
		--confdir="${EPREFIX}/etc/${PN}"

		$(usex cli '' '--disable-cplayer')
		$(use_enable libmpv libmpv-shared)

		--disable-libmpv-static
		--disable-static-build
		--disable-optimize		# Don't add '-O2' to CFLAGS.
		--disable-debug-build	# Don't add '-g' to CFLAGS.
		--disable-html-build
		--disable-manpage-build
		--disable-pdf-build
		$(use_enable cplugins)
		--disable-android
		$(use_enable lua)
		$(use_enable javascript)
		$(use_enable zlib)
		$(use_enable bluray libbluray)
		$(use_enable cdda)
		$(use_enable uchardet)
		$(use_enable rubberband)
		$(use_enable lcms lcms2)
		--disable-vapoursynth	# Only available in overlays.
		$(use_enable archive libarchive)
		--disable-vulkan

		# Audio outputs:
		$(use_enable sdl sdl2)	# Listed under audio, but also includes video.
		$(use_enable pulseaudio pulse)
		$(use_enable jack)
		--disable-opensles
		$(use_enable alsa)
		$(use_enable coreaudio)

		# Video outputs:
		$(use_enable drm)
		$(use_enable wayland wayland-scanner)
		$(use_enable wayland wayland-protocols)
		$(use_enable wayland)
		$(use_enable X x11)
		$(use_enable xv)
		$(usex opengl "$(use_enable X gl-x11)" '--disable-gl-x11')
		$(use_enable vdpau)
		$(usex vdpau "$(use_enable opengl vdpau-gl-x11)" '--disable-vdpau-gl-x11')
		$(usex egl "$(use_enable X egl-x11)" '--disable-egl-x11')
		$(usex opengl "$(use_enable wayland gl-wayland)" '--disable-gl-wayland')
		$(use_enable vaapi)		# See below for vaapi-glx, vaapi-x-egl.
		$(usex vaapi "$(use_enable X vaapi-x11)" '--disable-vaapi-x11')
		$(usex vaapi "$(use_enable wayland vaapi-wayland)" '--disable-vaapi-wayland')
		$(use_enable libcaca caca)
		$(use_enable jpeg)
		$(use_enable raspberry-pi rpi)
		$(usex libmpv "$(use_enable opengl plain-gl)" '--disable-plain-gl')
		$(usex opengl '' '--disable-gl')
		$(use_enable cuda cuda-hwaccel)
		$(use_enable dvb dvbin)
		--disable-zimg
	)

	if use vaapi && use X; then
		mywafargs+=(
			$(use_enable opengl vaapi-glx)
			$(use_enable egl vaapi-x-egl)
		)
	fi

	waf-utils_src_configure "${mywafargs[@]}"
}

src_install() {
	waf-utils_src_install

	insinto etc/${PN}
	doins ${FILESDIR}/mpv.conf

	if use lua; then
		insinto /usr/share/${PN}
		doins -r TOOLS/lua
	fi
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
