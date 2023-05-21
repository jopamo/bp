# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson git-r3

DESCRIPTION="Audacious Player - Your music, your way, no exceptions"
HOMEPAGE="https://audacious-media-player.org/"
EGIT_REPO_URI="https://github.com/audacious-media-player/audacious-plugins.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="aac alsa aosd cdda cue +flac fluidsynth hotkeys gme jack libsamplerate
lirc mms modplug opus pipewire pulseaudio scrobbler qt qt6 filewriter
sdl sid sndfile soxr speedpitch vorbis wavpack"

DEPEND="
	lib-dev/dbus-glib
	xgui-misc/mpg123
	xmedia-live-app/ffmpeg
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
	qt? ( xgui-live-lib/qtbase:5 )
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

src_configure() {
	local emesonargs=(
		#gui toolkits
		-Dgtk=false
		-Dgtk3=false
		$(meson_use qt)
		$(meson_use qt6)

		#container plugins
		$(meson_use cue)

		# transport plugins
		$(meson_use mms)
		-Dneon=false

		# input plugins
		$(meson_use aac)
		-Dadplug=false
		-Damidiplug=false
		-Dcdaudio=false
		-Dconsole=false
		-Dffaudio=true
		$(meson_use flac)
		$(meson_use modplug)
		-Dmpg123=true
		-Dopenmpt=false
		$(meson_use opus)
		$(meson_use sid)
		$(meson_use sndfile)
		$(meson_use vorbis)
		$(meson_use wavpack)

		# output plugins
		$(meson_use alsa)
		-Dcoreaudio=false
		$(meson_use filewriter)
		$(meson_use jack)
		-Doss=false
		#not working yet
		-Dpipewire=false
		$(meson_use pulseaudio pulse)
		-Dqtaudio=false
		$(meson_use sdl sdlout)
		-Dsndio=false

		# general plugins
		-Dampache=false
		$(meson_use aosd)
		$(meson_use hotkeys hotkey)
		$(meson_use lirc)
		$(meson_use scrobbler scrobbler2)

		# effect plugins
		$(meson_use libsamplerate resample)
		$(meson_use soxr)
		$(meson_use speedpitch)
	)
	meson_src_configure
}
