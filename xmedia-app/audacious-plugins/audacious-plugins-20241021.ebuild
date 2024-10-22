# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="Audacious Player - Your music, your way, no exceptions"
HOMEPAGE="https://audacious-media-player.org/"

SNAPSHOT=ac482565142ad7dca712d00f89da08f57d6733c7
SRC_URI="https://github.com/audacious-media-player/audacious-plugins/archive/${SNAPSHOT}.tar.gz -> audacious-plugins-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/audacious-plugins-${SNAPSHOT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="aac alsa aosd cdda cue +flac fluidsynth hotkeys gme jack libsamplerate
lirc mms modplug opus pipewire pulseaudio scrobbler qt qt6 filewriter
sdl sid sndfile soxr speedpitch vorbis wavpack"

DEPEND="
	lib-dev/dbus-glib
	xgui-misc/mpg123
	xmedia-app/ffmpeg
	xmedia-app/audacious
	aac? ( xmedia-live-lib/faad2 )
	alsa? ( xgui-tools/alsa-lib )
	aosd? (
		xgui-lib/libXrender
		xgui-lib/libXcomposite
	)
	cdda? (
		xmedia-live-lib/libcddb
		lib-dev/libcdio-paranoia
	)
	cue? ( xmedia-live-lib/libcue )
	flac? (
		xmedia-lib/libvorbis
		xmedia-lib/flac
	)
	fluidsynth? ( xmedia-live-app/fluidsynth )
	jack? (
		xmedia-live-lib/bio2jack
		virtual/jack
	)
	libsamplerate? ( xmedia-lib/libsamplerate )
	lirc? ( app-var/lirc )
	mms? ( xmedia-live-lib/libmms )
	modplug? ( xmedia-live-lib/libmodplug )
	opus? ( xmedia-lib/opus )
	pulseaudio? ( xgui-misc/pulseaudio )
	qt? ( xgui-lib/qtbase:5 )
	scrobbler? ( app-net/curl )
	sdl? ( xmedia-live-lib/libsdl2[sound] )
	sid? ( xmedia-live-lib/libsidplayfp )
	sndfile? ( xgui-misc/libsndfile )
	soxr? ( xmedia-live-lib/soxr )
	speedpitch? ( xmedia-lib/libsamplerate )
	vorbis? (
		xmedia-lib/libvorbis
		xmedia-lib/libogg
	)
	wavpack? ( xmedia-live-app/wavpack )
"

BDEPEND="app-dev/pkgconf"

src_configure() {
	local emesonargs=(
		#gui toolkits
		-D gtk=false
		-D qt=true
		-D qt5=true

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
