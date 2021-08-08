# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit flag-o-matic linux-info user meson

DESCRIPTION="A networked sound server with an advanced plugin system"
HOMEPAGE="https://www.freedesktop.org/wiki/Software/PulseAudio/"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://github.com/pulseaudio/pulseaudio.git"
	inherit git-r3
	KEYWORDS=""
else
	SRC_URI="https://freedesktop.org/software/pulseaudio/releases/${P}.tar.xz"
fi

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="+alsa +alsa-plugin asyncns bluez dbus elogind fftw +glib gtk ipv6 jack
samplerate native-headset systemd +udev +X"

DEPEND="
	dev-util/intltool
	sys-devel/gettext
	xmedia-live-lib/speexdsp
	xmedia-live-lib/libsndfile
	X? (
		x11-live-lib/libX11
		xgui-live-lib/libxcb
		x11-live-lib/libSM
		x11-live-lib/libICE
		x11-live-lib/libXtst
		x11-live-misc/xorgproto
		x11-live-lib/libXtst
	)
	bluez? ( xmedia-live-lib/sbc )
	samplerate? ( xmedia-live-lib/libsamplerate )
	alsa? ( xmedia-live-lib/alsa-lib )
	glib? ( lib-live/glib )
	jack? ( virtual/jack )
	dbus? ( app-core/dbus )
	gtk? ( x11-live-lib/gtk+:3 )
	udev? ( app-core/systemd[hwdb(+)] )
	lib-core/gdbm
	systemd? ( app-core/systemd )
"

PDEPEND="alsa? ( alsa-plugin? ( xmedia-live-app/alsa-plugins[pulseaudio] ) )"

filter-flags -Wl,-z,defs

pkg_pretend() {
	CONFIG_CHECK="~HIGH_RES_TIMERS"
	WARNING_HIGH_RES_TIMERS="CONFIG_HIGH_RES_TIMERS:\tis not set (required for enabling timer-based scheduling in pulseaudio)\n"
	check_extra_config

	if linux_config_exists; then
		local snd_hda_prealloc_size=$(linux_chkconfig_string SND_HDA_PREALLOC_SIZE)
		if [ -n "${snd_hda_prealloc_size}" ] && [ "${snd_hda_prealloc_size}" -lt 2048 ]; then
			ewarn "A preallocated buffer-size of 2048 (kB) or higher is recommended for the HD-audio driver!"
			ewarn "CONFIG_SND_HDA_PREALLOC_SIZE=${snd_hda_prealloc_size}"
		fi
	fi
}

pkg_setup() {
	linux-info_pkg_setup

	enewgroup audio 18 # Just make sure it exists
}

src_configure() {
	local emesonargs=(
		$(meson_feature alsa)
		$(meson_feature asyncns)
		-Davahi=disabled
		$(meson_use bluez bluez5)
		$(meson_feature dbus)
		$(meson_feature elogind)
		$(meson_feature fftw)
		$(meson_feature glib)
		-Dgsettings=disabled
		-Dgstreamer=disabled
		-Ddatabase=gdbm
		-Ddoxygen=false
		$(meson_feature gtk)
		$(meson_use ipv6)
		$(meson_feature jack)
		$(meson_feature samplerate)
)
		meson_src_configure
}

src_install() {
	meson_src_install

	use X || rm "${ED}"/usr/bin/start-pulseaudio-x11

	diropts -o pulse -g pulse -m0755

	rm "${ED}"/etc/dbus-1/system.d/pulseaudio-system.conf
}
