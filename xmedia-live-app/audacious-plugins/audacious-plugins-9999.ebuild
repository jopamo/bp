# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools git-r3

DESCRIPTION="Audacious Player - Your music, your way, no exceptions"
HOMEPAGE="https://audacious-media-player.org/"
EGIT_REPO_URI="https://github.com/audacious-media-player/audacious-plugins.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="aac alsa aosd bs2b cdda cue +ffmpeg +flac fluidsynth hotkeys http gme jack libsamplerate lirc
mms modplug pulseaudio scrobbler sdl sid sndfile soxr speedpitch vorbis wavpack"

DEPEND="
	lib-dev/dbus-glib
	lib-live/glib
	lib-core/libxml2
	~xmedia-live-app/audacious-${PV}
	aac? ( xmedia-live-lib/faad2 )
	alsa? ( xmedia-live-lib/alsa-lib )
	aosd? (
		xgui-live-lib/libXrender
		xgui-live-lib/libXcomposite
	)
	bs2b? ( xmedia-live-lib/libbs2b )
	cdda? (
		xmedia-live-lib/libcddb
		lib-dev/libcdio-paranoia
	)
	cue? ( xmedia-live-lib/libcue )
	ffmpeg? ( xmedia-live-app/ffmpeg )
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
	lirc? ( app-misc/lirc )
	mms? ( xmedia-live-lib/libmms )
	modplug? ( xmedia-live-lib/libmodplug )
	xgui-misc/mpg123
	pulseaudio? ( xgui-misc/pulseaudio )
	scrobbler? ( app-net/curl )
	sdl? ( xmedia-live-lib/libsdl2[sound] )
	sid? ( xmedia-live-lib/libsidplayfp )
	sndfile? ( xmedia-live-lib/libsndfile )
	soxr? ( xmedia-live-lib/soxr )
	speedpitch? ( xmedia-live-lib/libsamplerate )
	vorbis? (
		xmedia-live-lib/libvorbis
		xmedia-live-lib/libogg
	)
	wavpack? ( xmedia-live-app/wavpack )
"

BDEPEND="dev-util/pkgconf"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		--disable-gtk
		--disable-nls
		--enable-qt
		--enable-mpris2
		--enable-songchange
		--disable-oss4
		--disable-qtaudio
		--disable-qtglspectrum
		--disable-coreaudio
		--disable-sndio
		$(use_enable aac)
		$(use_enable alsa)
		--disable-ampache
		$(use_enable aosd)
		$(use_enable bs2b)
		$(use_enable cdda cdaudio)
		$(use_enable cue)
		$(use_enable flac)
		$(use_enable fluidsynth amidiplug)
		$(use_enable flac filewriter)
		$(use_enable gme console)
		$(use_enable hotkeys hotkey)
		$(use_enable http neon)
		$(use_enable jack)
		--disable-filewriter_mp3
		$(use_enable libsamplerate resample)
		$(use_enable lirc)
		$(use_enable mms)
		$(use_enable modplug)
		--enable-mpg123
		$(use_enable pulseaudio pulse)
		$(use_enable scrobbler scrobbler2)
		$(use_enable sdl sdlout)
		$(use_enable sid)
		$(use_enable sndfile)
		$(use_enable soxr)
		$(use_enable speedpitch)
		$(use_enable vorbis)
		$(use_enable wavpack)
		$(use_with ffmpeg)
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
