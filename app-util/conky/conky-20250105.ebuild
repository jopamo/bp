# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="An advanced, highly configurable system monitor for X"
HOMEPAGE="https://github.com/brndnmtthws/conky"

SNAPSHOT=7fd5dcb7e6802b52ebd4fb1d2198cc89c8f1715e
SRC_URI="https://github.com/brndnmtthws/conky/archive/${SNAPSHOT}.tar.gz -> conky-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/conky-${SNAPSHOT}"

LICENSE="GPL-3 BSD LGPL-2.1 MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="apcupsd curl vim hddtemp imlib
	intel-backlight iostats math mpd ncurses nvidia
	+portmon pulseaudio rss systemd +xft
	wayland wifi +vim X xinerama xmms2"

COMMON_DEPEND="
	curl? ( app-net/curl )
	imlib? ( xgui-misc/imlib2 )
	ncurses? ( lib-core/ncurses )
	nvidia? ( bin/nvidia-drivers )
	pulseaudio? ( xgui-misc/pulseaudio )
	rss? ( lib-core/libxml2 net-misc/curl lib-core/glib:2 )
	systemd? ( app-core/systemd )
	xft? ( xgui-lib/libXft xgui-misc/freetype )
	wayland? (
		xgui-lib/wayland
		xgui-lib/pango
	)
	wifi? ( app-net/wireless-tools )
	X? (
		xgui-lib/libX11
		xgui-lib/libXdamage
		xgui-lib/libXfixes
		xgui-lib/libXext
	)
	xinerama? ( xgui-lib/libXinerama )
"
RDEPEND="
	${COMMON_DEPEND}
	apcupsd? ( app-live/apcupsd )
	hddtemp? ( app-live/hddtemp )
"
DEPEND="
	${COMMON_DEPEND}
	wayland? (
		dev-libs/wayland-protocols
	)
"

DISABLE_AUTOFORMATTING="yes"

src_prepare() {
	cmake_src_prepare
	xdg_environment_reset
}

src_configure() {
	local mycmakeargs=()

	if use X; then
		mycmakeargs+=(
			-DBUILD_ARGB=yes
			-DBUILD_X11=yes
			-DBUILD_XDAMAGE=yes
			-DBUILD_XDBE=yes
			-DBUILD_XSHAPE=yes
			-DBUILD_MOUSE_EVENTS=yes
			-DOWN_WINDOW=yes
		)
	else
		mycmakeargs+=(
			-DBUILD_X11=no
		)
	fi

	mycmakeargs+=(
		-DBUILD_APCUPSD=$(usex apcupsd)
		-DBUILD_AUDACIOUS=no
		-DBUILD_BUILTIN_CONFIG=yes
		-DBUILD_CMUS=no
		-DBUILD_CURL=$(usex curl)
		-DBUILD_DOCS=no
		-DBUILD_EXTRAS=yes
		-DBUILD_HDDTEMP=$(usex hddtemp)
		-DBUILD_HTTP=no
		-DBUILD_I18N=yes
		-DBUILD_IBM=no
		-DBUILD_IMLIB2=$(usex imlib)
		-DBUILD_INTEL_BACKLIGHT=$(usex intel-backlight)
		-DBUILD_IOSTATS=$(usex iostats)
		-DBUILD_IPV6=yes
		-DBUILD_JOURNAL=$(usex systemd)
		-DBUILD_MATH=$(usex math)
		-DBUILD_MOC=no
		-DBUILD_MPD=$(usex mpd)
		-DBUILD_NCURSES=$(usex ncurses)
		-DBUILD_NVIDIA=$(usex nvidia)
		-DBUILD_OLD_CONFIG=yes
		-DBUILD_PORT_MONITORS=$(usex portmon)
		-DBUILD_PULSEAUDIO=$(usex pulseaudio)
		-DBUILD_RSS=$(usex rss)
		-DBUILD_WAYLAND=$(usex wayland)
		-DBUILD_WLAN=$(usex wifi)
		-DBUILD_XFT=$(usex xft)
		-DBUILD_XINERAMA=$(usex xinerama)
		-DBUILD_XMMS2=no
		-DDOC_PATH=/usr/share/doc/${PF}
		-DMAINTAINER_MODE=no
		-DRELEASE=yes
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install

	if use vim; then
		insinto /usr/share/vim/vimfiles/ftdetect
		doins "${S}"/extras/vim/ftdetect/conkyrc.vim

		insinto /usr/share/vim/vimfiles/syntax
		doins "${BUILD_DIR}"/extras/vim/syntax/conkyrc.vim
	fi
}
