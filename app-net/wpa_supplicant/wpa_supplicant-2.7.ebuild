# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit qmake-utils systemd toolchain-funcs flag-o-matic

DESCRIPTION="IEEE 802.1X/WPA supplicant for secure wireless transfers"
HOMEPAGE="https://w1.fi/wpa_supplicant/"
SRC_URI="https://w1.fi/releases/${P}.tar.gz"
LICENSE="|| ( GPL-2 BSD )"

SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="ap dbus eapol_test fasteap gnutls +hs2-0 p2p privsep qt5 readline smartcard ssl tdls uncommon-eap-types wps"
REQUIRED_USE="fasteap? ( !ssl ) smartcard? ( ssl )"

CDEPEND="
	dbus? ( sys-app/dbus )
	lib-dev/libnl:3
	qt5? (
		gui-lib/qtcore:5
		gui-lib/qtgui:5
		gui-lib/qtsvg:5
		gui-lib/qtwidgets:5
	)
	readline? (
		lib-sys/ncurses:0=
		lib-sys/readline:0=
	)
	ssl? (
		gnutls? (
			lib-dev/libgcrypt:0=
			lib-net/gnutls:=
		)
		!gnutls? ( lib-dev/openssl:0= )
	)
	!ssl? ( lib-dev/libtommath )
"
DEPEND="${CDEPEND}
	dev-util/pkgconf
"

S="${WORKDIR}/${P}/${PN}"

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

	# net/bpf.h needed for lib-net/libpcap on Gentoo/FreeBSD
	sed -i \
		-e "s:\(#include <pcap\.h>\):#include <net/bpf.h>\n\1:" \
		../src/l2_packet/l2_packet_freebsd.c || die

	# People seem to take the example configuration file too literally (bug #102361)
	sed -i \
		-e "s:^\(opensc_engine_path\):#\1:" \
		-e "s:^\(pkcs11_engine_path\):#\1:" \
		-e "s:^\(pkcs11_module_path\):#\1:" \
		wpa_supplicant.conf || die

	# Change configuration to match Gentoo locations (bug #143750)
	sed -i \
		-e "s:/usr/lib/opensc:/usr/lib64:" \
		-e "s:/usr/lib/pkcs11:/usr/lib64:" \
		wpa_supplicant.conf || die

	# systemd entries to D-Bus service files (bug #372877)
	echo 'SystemdService=wpa_supplicant.service' \
		| tee -a dbus/*.service >/dev/null || die

	cd "${WORKDIR}/${P}" || die

	eapply "${FILESDIR}/wpa_supplicant-2.7-fix-undefined-remove-ie.patch"
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

	# Basic authentication methods
	# NOTE: we don't set GPSK or SAKE as they conflict
	# with the below options
	Kconfig_style_config EAP_GTC
	Kconfig_style_config EAP_MD5
	Kconfig_style_config EAP_OTP
	Kconfig_style_config EAP_PAX
	Kconfig_style_config EAP_PSK
	Kconfig_style_config EAP_TLV
	Kconfig_style_config EAP_EXE
	Kconfig_style_config IEEE8021X_EAPOL
	Kconfig_style_config PKCS12
	Kconfig_style_config PEERKEY
	Kconfig_style_config EAP_LEAP
	Kconfig_style_config EAP_MSCHAPV2
	Kconfig_style_config EAP_PEAP
	Kconfig_style_config EAP_TLS
	Kconfig_style_config EAP_TTLS

	# Enabling background scanning.
	Kconfig_style_config BGSCAN_SIMPLE
	Kconfig_style_config BGSCAN_LEARN

	if use dbus ; then
		Kconfig_style_config CTRL_IFACE_DBUS
		Kconfig_style_config CTRL_IFACE_DBUS_NEW
		Kconfig_style_config CTRL_IFACE_DBUS_INTRO
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

	# SSL authentication methods
	if use ssl ; then
		if use gnutls ; then
			Kconfig_style_config TLS gnutls
			Kconfig_style_config GNUTLS_EXTRA
		else
			Kconfig_style_config TLS openssl
			Kconfig_style_config EAP_PWD

			# Enabling mesh networks.
			Kconfig_style_config MESH
		fi
	else
		Kconfig_style_config TLS internal
	fi

	if use smartcard ; then
		Kconfig_style_config SMARTCARD
	fi

	if use tdls ; then
		Kconfig_style_config TDLS
	fi

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
	fi

	# Wi-Fi Direct (WiDi)
	if use p2p ; then
		Kconfig_style_config P2P
		Kconfig_style_config WIFI_DISPLAY
	fi

	# Access Point Mode
	if use ap ; then
		Kconfig_style_config AP
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

	Kconfig_style_config LIBNL32

	if use qt5 ; then
		pushd "${S}"/wpa_gui-qt4 > /dev/null || die
		eqmake5 wpa_gui.pro
		popd > /dev/null || die
	fi
}

src_compile() {
	einfo "Building wpa_supplicant"
	emake V=1 BINDIR=/usr/sbin

	if use qt5; then
		einfo "Building wpa_gui"
		emake -C "${S}"/wpa_gui-qt4
	fi

	if use eapol_test ; then
		emake eapol_test
	fi
}

src_install() {
	dosbin wpa_supplicant
	use privsep && dosbin wpa_priv
	dobin wpa_cli wpa_passphrase

	exeinto /etc/wpa_supplicant/
	newexe "${FILESDIR}/wpa_cli.sh" wpa_cli.sh


	dodoc wpa_supplicant.conf

	newdoc .config build-config

	doman doc/docbook/*.{5,8}

	if use qt5 ; then
		into /usr
		dobin wpa_gui-qt4/wpa_gui
		doicon wpa_gui-qt4/icons/wpa_gui.svg
		make_desktop_entry wpa_gui "WPA Supplicant Administration GUI" "wpa_gui" "Qt;Network;"
	else
		rm "${ED}"/usr/share/man/man8/wpa_gui.8
	fi

	if use dbus ; then
		pushd "${S}"/dbus > /dev/null || die
		insinto /etc/dbus-1/system.d
		newins dbus-wpa_supplicant.conf wpa_supplicant.conf
		insinto /usr/share/dbus-1/system-services
		doins fi.epitest.hostap.WPASupplicant.service fi.w1.wpa_supplicant1.service
		popd > /dev/null || die

		# This unit relies on dbus support, bug 538600.
		systemd_dounit systemd/wpa_supplicant.service
	fi

	if use eapol_test ; then
		dobin eapol_test
	fi

	systemd_dounit "systemd/wpa_supplicant@.service"
	systemd_dounit "systemd/wpa_supplicant-nl80211@.service"
	systemd_dounit "systemd/wpa_supplicant-wired@.service"
}

pkg_postinst() {


	if [[ -e "${EROOT%/}"/etc/wpa_supplicant.conf ]] ; then
		echo
		ewarn "WARNING: your old configuration file ${EROOT%/}/etc/wpa_supplicant.conf"
		ewarn "needs to be moved to ${EROOT%/}/etc/wpa_supplicant/wpa_supplicant.conf"
	fi

	# Mea culpa, feel free to remove that after some time --mgorny.
	local fn
	for fn in wpa_supplicant{,@wlan0}.service; do
		if [[ -e "${EROOT%/}"/etc/systemd/system/network.target.wants/${fn} ]]
		then
			ebegin "Moving ${fn} to multi-user.target"
			mv "${EROOT%/}"/etc/systemd/system/network.target.wants/${fn} \
				"${EROOT%/}"/etc/systemd/system/multi-user.target.wants/ || die
			eend ${?} \
				"Please try to re-enable ${fn}"
		fi
	done

	systemd_reenable wpa_supplicant.service
}
