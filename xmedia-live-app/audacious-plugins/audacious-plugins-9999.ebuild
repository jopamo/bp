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
mms modplug nls pulseaudio scrobbler sdl sid sndfile soxr speedpitch vorbis wavpack"

RDEPEND="
	lib-dev/dbus-glib
	lib-live/glib
	lib-core/libxml2
	~xmedia-live-app/audacious-${PV}
	aac? ( >=xmedia-live-lib/faad2-2.7 )
	alsa? ( >=xmedia-live-lib/alsa-lib-1.0.16 )
	aosd? (
		xgui-live-lib/libXrender
		xgui-live-lib/libXcomposite
	)
	bs2b? ( xmedia-live-lib/libbs2b )
	cdda? (
		>=xmedia-live-lib/libcddb-1.2.1
		lib-dev/libcdio-paranoia
	)
	cue? ( xmedia-live-lib/libcue )
	ffmpeg? ( xmedia-live-app/ffmpeg )
	flac? (
		>=xmedia-live-lib/libvorbis-1.0
		>=xmedia-live-lib/flac-1.2.1-r1
	)
	fluidsynth? ( xmedia-live-app/fluidsynth )
	http? ( >=lib-net/neon-0.26.4 )
	xgui-live-lib/qtbase
	jack? (
		>=xmedia-live-lib/bio2jack-0.4
		virtual/jack
	)
	libsamplerate? ( xmedia-live-lib/libsamplerate:= )
	lirc? ( app-misc/lirc )
	mms? ( >=xmedia-live-lib/libmms-0.3 )
	modplug? ( xmedia-live-lib/libmodplug )
	xgui-misc/mpg123
	pulseaudio? ( >=xgui-misc/pulseaudio-0.9.3 )
	scrobbler? ( app-net/curl )
	sdl? ( xmedia-live-lib/libsdl2[sound] )
	sid? ( >=xmedia-live-lib/libsidplayfp-1.0.0 )
	sndfile? ( >=xmedia-live-lib/libsndfile-1.0.17-r1 )
	soxr? ( xmedia-live-lib/soxr )
	speedpitch? ( xmedia-live-lib/libsamplerate:= )
	vorbis? (
		>=xmedia-live-lib/libvorbis-1.2.0
		>=xmedia-live-lib/libogg-1.1.3
	)
	wavpack? ( >=xmedia-live-app/wavpack-4.50.1-r1 )"

DEPEND="${RDEPEND}
	dev-util/pkgconf
	nls? ( dev-util/intltool )"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/lib
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		--disable-gtk
		$(use_enable nls)
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
