# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit qmake-utils toolchain-funcs flag-o-matic

DESCRIPTION="IEEE 802.1X/WPA supplicant for secure wireless transfers"
HOMEPAGE="https://w1.fi/wpa_supplicant/"
SNAPSHOT=ea08700a762f13c415e319993720bed83ad9aa2c
SRC_URI="https://github.com/1g4-mirror/hostap/archive/${SNAPSHOT}.tar.gz -> hostap-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/hostap-${SNAPSHOT}/wpa_supplicant"

LICENSE="|| ( GPL-2 BSD )"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="ap dbus eapol_test fasteap gnutls hs2-0 p2p privsep readline smartcard ssl systemd
tdls uncommon-eap-types wps"

REQUIRED_USE="fasteap? ( !ssl ) smartcard? ( ssl )"

CDEPEND="
	dbus? ( app-core/dbus )
	lib-net/libnl
	readline? (
		virtual/curses
		lib-core/readline
	)
	ssl? (
		gnutls? (
			lib-core/libgcrypt
			lib-net/gnutls
		)
		!gnutls? ( virtual/ssl )
	)
	!ssl? ( lib-dev/libtommath )
"
DEPEND="${CDEPEND}
	app-dev/pkgconf
"

Kconfig_style_config() {
		#param 1 is CONFIG_* item
		#param 2 is what to set it = to, defaulting in y
		CONFIG_PARAM="${CONFIG_HEADER:-CONFIG_}$1"
		setting="${2:-y}"

		if [ ! $setting = n ]; then
			#first remove any leading "# " if $2 is not n
			sed -i "/^# *$CONFIG_PARAM=/s/^# *//" .config || echo "Kconfig_style_config error uncommenting $CONFIG_PARAM"
			#set item = $setting (defaulting to y)
			sed -i "/^$CONFIG_PARAM/s/=.*/=$setting/" .config || echo "Kconfig_style_config error setting $CONFIG_PARAM=$setting"
			if [ -z "$( grep ^$CONFIG_PARAM= .config )" ] ; then
				echo "$CONFIG_PARAM=$setting" >>.config
			fi
		else
			#ensure item commented out
			sed -i "/^$CONFIG_PARAM/s/$CONFIG_PARAM/# $CONFIG_PARAM/" .config || echo "Kconfig_style_config error commenting $CONFIG_PARAM"
		fi
}

src_prepare() {
	default

	# net/bpf.h needed for net-libs/libpcap on Gentoo/FreeBSD
	sed -i \
		-e "s:\(#include <pcap\.h>\):#include <net/bpf.h>\n\1:" \
		../src/l2_packet/l2_packet_freebsd.c || die

	# People seem to take the example configuration file too literally (bug #102361)
	sed -i \
		-e "s:^\(opensc_engine_path\):#\1:" \
		-e "s:^\(pkcs11_engine_path\):#\1:" \
		-e "s:^\(pkcs11_module_path\):#\1:" \
		wpa_supplicant.conf || die

	# systemd entries to D-Bus service files (bug #372877)
	echo 'SystemdService=wpa_supplicant.service' \
		| tee -a dbus/*.service >/dev/null || die

	cd "${WORKDIR}/hostap-${SNAPSHOT}" || die

	# bug (640492)
	sed -i 's#-Werror ##' wpa_supplicant/Makefile || die
}

src_configure() {
	# Toolchain setup
	tc-export CC

	cp defconfig .config || die

	# Basic setup
	Kconfig_style_config CTRL_IFACE
	Kconfig_style_config MATCH_IFACE
	Kconfig_style_config BACKEND file
	Kconfig_style_config IBSS_RSN
	Kconfig_style_config IEEE80211W
	Kconfig_style_config IEEE80211R
	Kconfig_style_config HT_OVERRIDES
	Kconfig_style_config VHT_OVERRIDES
	Kconfig_style_config OCV
	Kconfig_style_config TLSV11
	Kconfig_style_config TLSV12
	Kconfig_style_config GETRANDOM
	Kconfig_style_config MBO

	# Basic authentication methods
	# NOTE: we don't set GPSK or SAKE as they conflict
	# with the below options
	Kconfig_style_config EAP_GTC
	Kconfig_style_config EAP_MD5
	Kconfig_style_config EAP_OTP
	Kconfig_style_config EAP_PAX
	Kconfig_style_config EAP_PSK
	Kconfig_style_config IEEE8021X_EAPOL
	Kconfig_style_config PKCS12
	Kconfig_style_config PEERKEY
	Kconfig_style_config EAP_LEAP
	Kconfig_style_config EAP_MSCHAPV2
	Kconfig_style_config EAP_PEAP
	Kconfig_style_config EAP_TEAP
	Kconfig_style_config EAP_TLS
	Kconfig_style_config EAP_TTLS

	# Enabling background scanning.
	Kconfig_style_config BGSCAN_SIMPLE
	Kconfig_style_config BGSCAN_LEARN

	if use dbus ; then
		Kconfig_style_config CTRL_IFACE_DBUS
		Kconfig_style_config CTRL_IFACE_DBUS_NEW
		Kconfig_style_config CTRL_IFACE_DBUS_INTRO
	else
		Kconfig_style_config CTRL_IFACE_DBUS n
		Kconfig_style_config CTRL_IFACE_DBUS_NEW n
		Kconfig_style_config CTRL_IFACE_DBUS_INTRO n
	fi

	if use eapol_test ; then
		Kconfig_style_config EAPOL_TEST
	fi

	# Enable support for writing debug info to a log file and syslog.
	Kconfig_style_config DEBUG_FILE
	Kconfig_style_config DEBUG_SYSLOG

	if use hs2-0 ; then
		Kconfig_style_config INTERWORKING
		Kconfig_style_config HS20
	fi

	if use uncommon-eap-types; then
		Kconfig_style_config EAP_GPSK
		Kconfig_style_config EAP_SAKE
		Kconfig_style_config EAP_GPSK_SHA256
		Kconfig_style_config EAP_IKEV2
		Kconfig_style_config EAP_EKE
	fi

	if use fasteap ; then
		Kconfig_style_config EAP_FAST
	fi

	if use readline ; then
		# readline/history support for wpa_cli
		Kconfig_style_config READLINE
	else
		#internal line edit mode for wpa_cli
		Kconfig_style_config WPA_CLI_EDIT
	fi

	Kconfig_style_config TLS openssl
	Kconfig_style_config FST

	Kconfig_style_config EAP_PWD

	# Enabling mesh networks.
	Kconfig_style_config MESH

	#WPA3
	Kconfig_style_config OWE
	Kconfig_style_config SAE
	Kconfig_style_config DPP
	Kconfig_style_config SUITEB192

	Kconfig_style_config SMARTCARD n

	if use tdls ; then
		Kconfig_style_config TDLS
	fi

	# Linux specific drivers
	Kconfig_style_config DRIVER_ATMEL
	Kconfig_style_config DRIVER_HOSTAP
	Kconfig_style_config DRIVER_IPW
	Kconfig_style_config DRIVER_NL80211
	Kconfig_style_config DRIVER_RALINK
	Kconfig_style_config DRIVER_WEXT
	Kconfig_style_config DRIVER_WIRED

	# Wi-Fi Protected Setup (WPS)
	if use wps ; then
		Kconfig_style_config WPS
		Kconfig_style_config WPS2
		# USB Flash Drive
		Kconfig_style_config WPS_UFD
		# External Registrar
		Kconfig_style_config WPS_ER
		# Universal Plug'n'Play
		Kconfig_style_config WPS_UPNP
		# Near Field Communication
		Kconfig_style_config WPS_NFC
	else
		Kconfig_style_config WPS n
	fi

	# Wi-Fi Direct (WiDi)
	if use p2p ; then
		Kconfig_style_config P2P
		Kconfig_style_config WIFI_DISPLAY
	fi

	# Access Point Mode
	if use ap ; then
		Kconfig_style_config AP
	else
		Kconfig_style_config AP n
	fi

	# Enable essentials for AP/P2P
	if use ap || use p2p ; then
		# Enabling HT support (802.11n)
		Kconfig_style_config IEEE80211N

		# Enabling VHT support (802.11ac)
		Kconfig_style_config IEEE80211AC
	fi

	# Enable mitigation against certain attacks against TKIP
	Kconfig_style_config DELAYED_MIC_ERROR_REPORT

	if use privsep ; then
		Kconfig_style_config PRIVSEP
	fi

	# If we are using libnl 2.0 and above, enable support for it
	# Bug 382159
	# Removed for now, since the 3.2 version is broken, and we don't
	# support it.
	if has_version ">=dev-libs/libnl-3.2"; then
		Kconfig_style_config LIBNL32
	fi
}

src_compile() {
	einfo "Building wpa_supplicant"
	emake V=1 BINDIR=/usr/sbin

	if use eapol_test ; then
		emake eapol_test
	fi
}

src_install() {
	dobin wpa_supplicant
	use privsep && dobin wpa_priv
	dobin wpa_cli wpa_passphrase

	dodoc ChangeLog {eap_testing,todo}.txt README{,-WPS} \
		wpa_supplicant.conf

	newdoc .config build-config

	if use dbus ; then
		pushd "${S}"/dbus > /dev/null || die
		insinto /etc/dbus-1/system.d
		newins dbus-wpa_supplicant.conf wpa_supplicant.conf
		insinto /usr/share/dbus-1/system-services
		doins fi.w1.wpa_supplicant1.service
		popd > /dev/null || die

		if use systemd; then
			insinto /usr/lib/systemd/system
			insopts -m 0644
			doins systemd/wpa_supplicant.service
		fi

	fi

	if use eapol_test ; then
		dobin eapol_test
	fi

	if use systemd; then
		insinto /usr/lib/systemd/system
		insopts -m 0644
		doins "systemd/wpa_supplicant@.service"
		doins "systemd/wpa_supplicant-nl80211@.service"
		doins "systemd/wpa_supplicant-wired@.service"
	fi
}
