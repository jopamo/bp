# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{6,7,8} )

WAF_PV=2.0.12

inherit gnome2-utils python-r1 toolchain-funcs versionator waf-utils xdg-utils

DESCRIPTION="Media player based on MPlayer and mplayer2"
HOMEPAGE="https://mpv.io/"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="https://github.com/mpv-player/mpv/archive/v${PV}.tar.gz -> ${P}.tar.gz"
else
	EGIT_REPO_URI="https://github.com/mpv-player/mpv.git"
	inherit git-r3
	KEYWORDS="amd64 arm64 x86"
fi
SRC_URI+=" https://waf.io/waf-${WAF_PV}"

LICENSE="LGPL-2.1+ GPL-2+ BSD ISC"
SLOT="0"
IUSE="+alsa aqua archive bluray cdda +cli coreaudio cplugins cuda drm dvb
	dvd +egl gbm jack javascript jpeg lcms +libass libcaca
	libmpv +lua openal +opengl oss pulseaudio raspberry-pi rubberband
	sdl test +uchardet v4l vaapi wayland +X +xv zlib
	zsh-completion"

REQUIRED_USE="
	|| ( cli libmpv )
	aqua? ( opengl )
	cuda? ( opengl )
	egl? ( || ( gbm X wayland ) )
	gbm? ( drm egl opengl )
	lcms? ( opengl )
	opengl? ( || ( aqua egl X raspberry-pi !cli ) )
	raspberry-pi? ( opengl )
	test? ( opengl )
	v4l? ( || ( alsa oss ) )
	vaapi? ( || ( gbm X wayland ) )
	wayland? ( egl )
	X? ( egl? ( opengl ) )
	xv? ( X )
	zsh-completion? ( cli )
	${PYTHON_REQUIRED_USE}
"

COMMON_DEPEND="
	alsa? ( >=lib-media/alsa-lib-1.0.18 )
	archive? ( >=app-compression/libarchive-3.0.0:= )
	bluray? ( >=lib-media/libbluray-0.3.0:= )
	cdda? ( lib-dev/libcdio-paranoia )
	drm? ( x11-libs/libdrm )
	dvd? (
		>=lib-media/libdvdnav-4.2.0
		>=lib-media/libdvdread-4.1.0
	)
	egl? ( lib-media/mesa[egl,gbm(-)?,wayland(-)?] )
	uchardet? ( lib-media/uchardet )
	jack? ( virtual/jack )
	javascript? ( >=dev-lang/mujs-1.0.0 )
	jpeg? ( lib-media/libjpeg-turbo )
	lcms? ( >=lib-media/lcms-2.6:2 )
	libass? (
		>=lib-media/libass-0.12.1:=[fontconfig,harfbuzz]
		fonts/liberation-fonts
	)
	libcaca? ( >=lib-media/libcaca-0.99_beta18 )
	lua? ( dev-lang/luajit )
	openal? ( >=lib-media/openal-1.13 )
	pulseaudio? ( app-media/pulseaudio )
	raspberry-pi? ( >=lib-media/raspberrypi-userland-0_pre20160305-r1 )
	rubberband? ( >=lib-media/rubberband-1.8.0 )
	sdl? ( lib-media/libsdl2[sound,threads,video] )
	v4l? ( lib-media/libv4l )
	vaapi? ( x11-libs/libva:=[drm?,X?,wayland?] )
	wayland? (
		>=lib-dev/wayland-1.6.0
		>=x11-libs/libxkbcommon-0.3.0
		lib-dev/wayland-protocols
	)
	X? (
		x11-libs/libX11
		x11-libs/libXScrnSaver
		x11-libs/libXext
		x11-libs/libXinerama
		x11-libs/libXrandr
		opengl? (
			x11-libs/libXdamage
			lib-media/mesa
		)
		xv? ( x11-libs/libXv )
	)
	zlib? ( lib-sys/zlib )
"
DEPEND="${COMMON_DEPEND}
	${PYTHON_DEPS}
	dev-python/docutils
	dev-util/pkgconfig
	app-media/ffmpeg
	dvb? ( virtual/linuxtv-dvb-headers )
	test? ( >=dev-util/cmocka-1.0.0 )
	v4l? ( sys-kernel/stable-sources )
	zsh-completion? ( dev-lang/perl )
"
RDEPEND="${COMMON_DEPEND}
	cuda? ( nvidia/nvidia-drivers[X]
		nvidia/nvidia-cuda-sdk
		nvidia/nvidia-cuda-toolkit
		lib-media/nv-codec-headers
		)
"

pkg_setup() {
	[[ ${MERGE_TYPE} != "binary" ]] && python_setup
}

src_prepare() {
	cp "${DISTDIR}/waf-${WAF_PV}" "${S}"/waf || die
	chmod +x "${S}"/waf || die
	default_src_prepare
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
		$(use_enable zsh-completion zsh-comp)
		$(use_enable test)
		--disable-android
		$(use_enable lua)
		$(use_enable javascript)
		$(use_enable libass)
		$(use_enable libass libass-osd)
		$(use_enable zlib)
		$(use_enable bluray libbluray)
		$(use_enable dvd dvdread)
		$(use_enable dvd dvdnav)
		$(use_enable cdda)
		$(use_enable uchardet)
		$(use_enable rubberband)
		$(use_enable lcms lcms2)
		--disable-vapoursynth	# Only available in overlays.
		--disable-vapoursynth-lazy
		$(use_enable archive libarchive)

		# Audio outputs:
		$(use_enable sdl sdl2)	# Listed under audio, but also includes video.
		$(use_enable oss oss-audio)
		--disable-rsound
		--disable-sndio
		$(use_enable pulseaudio pulse)
		$(use_enable jack)
		$(use_enable openal)
		--disable-opensles
		$(use_enable alsa)
		$(use_enable coreaudio)
		--disable-vulkan

		# Video outputs:
		$(use_enable aqua cocoa)
		$(use_enable drm)
		$(use_enable gbm)
		$(use_enable wayland wayland-scanner)
		$(use_enable wayland wayland-protocols)
		$(use_enable wayland)
		$(use_enable X x11)
		$(use_enable xv)
		$(usex opengl "$(use_enable aqua gl-cocoa)" '--disable-gl-cocoa')
		$(usex opengl "$(use_enable X gl-x11)" '--disable-gl-x11')
		$(usex egl "$(use_enable X egl-x11)" '--disable-egl-x11')
		$(usex egl "$(use_enable gbm egl-drm)" '--disable-egl-drm')
		$(usex opengl "$(use_enable wayland gl-wayland)" '--disable-gl-wayland')
		$(use_enable vaapi)		# See below for vaapi-glx, vaapi-x-egl.
		$(usex vaapi "$(use_enable X vaapi-x11)" '--disable-vaapi-x11')
		$(usex vaapi "$(use_enable wayland vaapi-wayland)" '--disable-vaapi-wayland')
		$(usex vaapi "$(use_enable gbm vaapi-drm)" '--disable-vaapi-drm')
		$(use_enable libcaca caca)
		$(use_enable jpeg)
		$(use_enable raspberry-pi rpi)
		$(usex libmpv "$(use_enable opengl plain-gl)" '--disable-plain-gl')
		--disable-mali-fbdev	# Only available in overlays.
		$(usex opengl '' '--disable-gl')

		$(use_enable cuda cuda-hwaccel)

		# TV features:
		$(use_enable v4l tv)
		$(use_enable v4l tv-v4l2)
		$(use_enable v4l libv4l2)
		$(use_enable v4l audio-input)
		$(use_enable dvb dvbin)

		# Miscellaneous features:
		--disable-apple-remote
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

	if use lua; then
		insinto /usr/share/${PN}
		doins -r TOOLS/lua
	fi

	rm -rf "${ED}"/usr/share/doc/mpv
}

pkg_postinst() {
	gnome2_icon_cache_update
	xdg_desktop_database_update
}

pkg_postrm() {
	gnome2_icon_cache_update
	xdg_desktop_database_update
}

src_test() {
	cd "${S}"/build/test || die
	local test
	for test in *; do
		if [[ -x ${test} ]]; then
			./"${test}" || die "Test suite failed"
		fi
	done
}
