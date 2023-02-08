# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools git-r3

DESCRIPTION="Audacious Player - Your music, your way, no exceptions"
HOMEPAGE="https://audacious-media-player.org/"
EGIT_REPO_URI="https://github.com/audacious-media-player/audacious-plugins.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="aac alsa aosd cdda cue +flac fluidsynth hotkeys
http gme jack libsamplerate lirc mms modplug opus pulseaudio scrobbler
sdl sid sndfile soxr speedpitch vorbis wavpack"

DEPEND="
	lib-core/libxml2
	lib-dev/dbus-glib
	lib-live/glib
	xgui-misc/mpg123
	~xmedia-live-app/audacious-${PV}
	aac? ( xmedia-live-lib/faad2 )
	alsa? ( xgui-misc/alsa-lib )
	aosd? (
		xgui-live-lib/libXrender
		xgui-live-lib/libXcomposite
	)
	cdda? (
		xmedia-live-lib/libcddb
		lib-dev/libcdio-paranoia
	)
	cue? ( xmedia-live-lib/libcue )
	flac? (
		xmedia-live-lib/libvorbis
		xmedia-live-lib/flac
	)
	fluidsynth? ( xmedia-live-app/fluidsynth )
	http? ( lib-net/neon )
	xgui-live-lib/qtbase
	jack? (
		xmedia-live-lib/bio2jack
		virtual/jack
	)
	libsamplerate? ( xmedia-live-lib/libsamplerate )
	lirc? ( app-var/lirc )
	mms? ( xmedia-live-lib/libmms )
	modplug? ( xmedia-live-lib/libmodplug )
	opus? ( xmedia-live-lib/opus )
	pulseaudio? ( xgui-misc/pulseaudio )
	scrobbler? ( app-net/curl )
	sdl? ( xmedia-live-lib/libsdl2[sound] )
	sid? ( xmedia-live-lib/libsidplayfp )
	sndfile? ( xgui-misc/libsndfile )
	soxr? ( xmedia-live-lib/soxr )
	speedpitch? ( xmedia-live-lib/libsamplerate )
	vorbis? (
		xmedia-live-lib/libvorbis
		xmedia-live-lib/libogg
	)
	wavpack? ( xmedia-live-app/wavpack )
"

BDEPEND="app-dev/pkgconf"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		$(use_enable aac)
		$(use_enable alsa)
		$(use_enable aosd)
		$(use_enable cdda cdaudio)
		$(use_enable cue)
		$(use_enable flac filewriter)
		$(use_enable flac)
		$(use_enable fluidsynth amidiplug)
		$(use_enable gme console)
		$(use_enable hotkeys hotkey)
		$(use_enable http neon)
		$(use_enable jack)
		$(use_enable libsamplerate resample)
		$(use_enable lirc)
		$(use_enable mms)
		$(use_enable modplug)
		$(use_enable opus)
		$(use_enable pulseaudio pulse)
		$(use_enable scrobbler scrobbler2)
		$(use_enable sdl sdlout)
		$(use_enable sid)
		$(use_enable sndfile)
		$(use_enable soxr)
		$(use_enable speedpitch)
		$(use_enable vorbis)
		$(use_enable wavpack)
		--disable-ampache
		--disable-bs2b
		--disable-coreaudio
		--disable-filewriter_mp3
		--disable-gtk
		--disable-nls
		--disable-oss4
		--disable-qt
		--disable-qtaudio
		--disable-qtglspectrum
		--disable-sndio
		--enable-mpg123
		--enable-mpris2
		--enable-songchange
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
