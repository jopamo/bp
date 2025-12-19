# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic linux-info user meson

DESCRIPTION="A networked sound server with an advanced plugin system"
HOMEPAGE="https://www.freedesktop.org/wiki/Software/PulseAudio/"
SNAPSHOT=b096704c0d42c5e784deb781a07b23cfb5286a82
SRC_URI="https://github.com/pulseaudio/pulseaudio/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="alsa alsa-plugin asyncns bluez dbus fftw glib gtk ipv6 jack
samplerate native-headset systemd +udev +X"

DEPEND="
	app-dev/intltool
	app-build/gettext
	lib-dev/check
	xmedia-lib/speexdsp
	xgui-lib/libsndfile
	X? (
		xgui-lib/libX11
		xgui-lib/libxcb
		xgui-lib/libSM
		xgui-lib/libICE
		xgui-lib/libXtst
		xgui-tools/xorgproto
		xgui-lib/libXtst
	)
	bluez? ( xgui-lib/sbc )
	samplerate? ( xmedia-lib/libsamplerate )
	alsa? ( xgui-tools/alsa-lib )
	glib? ( lib-util/glib )
	jack? ( virtual/jack )
	dbus? ( app-core/dbus )
	gtk? ( xgui-lib/gtk3 )
	udev? ( app-core/systemd[hwdb(+)] )
	lib-core/gdbm
	systemd? ( app-core/systemd )
"

PDEPEND="alsa? ( alsa-plugin? ( xgui-tools/alsa-plugins[pulseaudio] ) )"

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
	echo 17.9 > .tarball-version

	filter-flags -Wl,-z,defs

	local emesonargs=(
		$(meson_feature alsa)
		$(meson_feature asyncns)
		$(meson_feature bluez bluez5)
		$(meson_use bluez bluez5-native-headset)
		$(meson_use bluez bluez5-native-headset)
		$(meson_feature dbus)
		$(meson_feature fftw)
		$(meson_feature glib)
		$(meson_feature gtk)
		$(meson_feature jack)
		$(meson_feature samplerate)
		$(meson_use ipv6)
		-Ddaemon=false
		-Ddoxygen=disabled
		-Dconsolekit=disabled
	    -Delogind=disabled
		-Davahi=disabled
		-Ddatabase=gdbm
		-Dx11=disabled
		-Dgsettings=disabled
		-Dgstreamer=disabled
		-Dpulsedsp-location='/usr/\$LIB/pulseaudio'
		-Dstream-restore-clear-old-devices=true
		-Dtcpwrap=disabled
		-Dudevrulesdir=/usr/lib/udev/rules.d
	)
		meson_src_configure
}

src_install() {
	meson_src_install

	use X || rm "${ED}"/usr/bin/start-pulseaudio-x11

	diropts -o pulse -g pulse -m0755

	rm "${ED}"/etc/dbus-1/system.d/pulseaudio-system.conf
	rm -rf "${ED}"/usr/lib/systemd
}
