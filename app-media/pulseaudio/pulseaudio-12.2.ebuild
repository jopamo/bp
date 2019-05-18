# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools flag-o-matic gnome2-utils linux-info systemd user

DESCRIPTION="A networked sound server with an advanced plugin system"
HOMEPAGE="https://www.freedesktop.org/wiki/Software/PulseAudio/"
SRC_URI="https://freedesktop.org/software/pulseaudio/releases/${P}.tar.xz"

LICENSE="!gdbm? ( LGPL-2.1 ) gdbm? ( GPL-2 ) equalizer? ( AGPL-3+ )"
SLOT="0/1"
KEYWORDS="amd64 arm64"

IUSE="+alsa +alsa-plugin +asyncns bluetooth +caps dbus doc equalizer +gdbm +glib
gnome gtk ipv6 jack libsamplerate lirc native-headset neon ofono-headset
+orc oss qt4 realtime sox ssl systemd test +udev +X"

REQUIRED_USE="
	bluetooth? ( dbus )
	equalizer? ( dbus )
	ofono-headset? ( bluetooth )
	native-headset? ( bluetooth )
	udev? ( || ( alsa oss ) )
"

RDEPEND=">=lib-media/libsndfile-1.0.20
	X? (
		>=x11-libs/libX11-1.4.0
		>=x11-libs/libxcb-1.6
		x11-libs/libSM
		x11-libs/libICE
		x11-libs/libXtst
	)
	caps? ( >=lib-sys/libcap-2.22-r2 )
	libsamplerate? ( >=lib-media/libsamplerate-0.1.1-r1 )
	alsa? ( >=lib-media/alsa-lib-1.0.19 )
	glib? ( >=lib-dev/glib-2.4.0:2 )
	jack? ( virtual/jack )
	lirc? ( app-misc/lirc )
	dbus? ( >=sys-app/dbus-1.0.0 )
	gtk? ( x11-libs/gtk+:3 )
	gnome? ( >=gui-lib/gconf-2.4.0 )
	bluetooth? (
		>=app-net/bluez-5
		>=sys-app/dbus-1.0.0
		lib-media/sbc
	)
	asyncns? ( lib-net/libasyncns )
	udev? ( >=sys-app/systemd-143[hwdb(+)] )
	realtime? ( lib-sys/rtkit )
	equalizer? ( sci-libs/fftw:3.0 )
	ofono-headset? ( >=app-net/ofono-1.13 )
	orc? ( >=dev-lang/orc-0.4.15 )
	sox? ( >=lib-media/soxr-0.1.1 )
	ssl? ( lib-dev/openssl:0= )
	gdbm? ( lib-sys/gdbm:= )
	systemd? ( sys-app/systemd:0= )
	lib-dev/libltdl:0
"
# it's a valid RDEPEND, libltdl.so is used for native abi

DEPEND="${RDEPEND}
	sys-devel/m4
	doc? ( app-text/doxygen )
	test? ( >=lib-dev/check-0.9.10 )
	X? (
		x11-misc/xorgproto
		>=x11-libs/libXtst-1.0.99.2
	)
	lib-dev/libatomic_ops
	dev-util/pkgconf
	dev-util/intltool
	>=sys-devel/gettext-0.18.1
	lib-media/speexdsp
"
# This is a PDEPEND to avoid a circular dep
PDEPEND="
	alsa? ( alsa-plugin? ( >=app-media/alsa-plugins-1.0.27-r1[pulseaudio] ) )
"

# alsa-utils dep is for the alsasound init.d script (see bug #155707)
# bluez dep is for the bluetooth init.d script
# PyQt4 dep is for the qpaeq script
RDEPEND="${RDEPEND}
	equalizer? ( qt4? ( dev-python/PyQt4[dbus] ) )
"

filter-flags -flto -Wl,-z,defs -Wl,-z,relro
replace-flags -Ofast -O2

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
	gnome2_environment_reset #543364

	enewgroup audio 18 # Just make sure it exists
}

src_prepare() {
	default

	# Skip test that cannot work with sandbox, bug #501846
	sed -i -e '/lock-autospawn-test/d' src/Makefile.am || die

	eautoreconf
}

src_configure() {
	local myconf=()

	if use gdbm; then
		myconf+=( --with-database=gdbm )
	else
		myconf+=( --with-database=simple )
	fi

	if use bluetooth; then
		myconf+=( --enable-bluez5
				$(use_enable native-headset bluez5-native-headset)
				$(use_enable ofono-headset bluez5-ofono-headset) )
	else
		myconf+=( --disable-bluez5 )
	fi

	myconf+=(
		--enable-largefile
		$(use_enable glib glib2)
		--disable-solaris
		$(use_enable asyncns)
		$(use_enable oss oss-output)
		$(use_enable alsa)
		$(use_enable lirc)
		$(use_enable neon neon-opt)
		$(use_enable jack)
		$(use_enable dbus)
		$(use_enable gnome gconf)
		$(use_enable gtk gtk3)
		$(use_enable libsamplerate samplerate)
		$(use_enable orc)
		$(use_enable X x11)
		$(use_enable test default-build-tests)
		$(use_enable udev)
		$(use_with sox soxr)
		$(use_enable systemd systemd-daemon)
		$(use_enable systemd systemd-login)
		$(use_enable systemd systemd-journal)
		$(use_enable ipv6)
		$(use_enable ssl openssl)
		$(use_with caps)
		$(use_with equalizer fftw)
		--with-speex
		--disable-webrtc-aec
		--enable-adrian-aec
		--disable-esound
		--disable-rpath
		--localstatedir="${EPREFIX}"/var
		--with-udev-rules-dir="${EPREFIX}/$(get_udevdir)"/rules.d
		--with-systemduserunitdir=$(systemd_get_userunitdir)
	)

	ECONF_SOURCE=${S} \
	econf "${myconf[@]}"
}

src_test() {
	emake -C src check
}

src_install() {
	default

	use X || rm "${ED}"/usr/bin/start-pulseaudio-x11

	diropts -o pulse -g pulse -m0755

	rm "${ED}"/etc/dbus-1/system.d/pulseaudio-system.conf
}
