# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic toolchain-funcs

DESCRIPTION="IEEE 802.11 wireless LAN Host AP daemon"
HOMEPAGE="https://w1.fi/ https://w1.fi/cgit/hostap/"

SNAPSHOT=96e48a05aa0a82e91e3cab75506297e433e253d0
SRC_URI="https://w1.fi/cgit/hostap/snapshot/hostap-${SNAPSHOT}.tar.bz2 -> ${P}.tar.bz2"
S="${WORKDIR}/hostap-${SNAPSHOT}/${PN}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="netlink selinux systemd"

DEPEND="
	lib-core/sqlite
	lib-net/libnl
"
src_prepare() {
	# Allow users to apply patches to src/drivers for example,
	# i.e. anything outside ${S}/${PN}
	pushd ../ >/dev/null || die
	default
	popd >/dev/null || die

	sed -i -e "s:/etc/hostapd:/etc/hostapd/hostapd:g" \
		"${S}/hostapd.conf" || die
}

src_configure() {
	local CONFIG="${S}"/.config

	# toolchain setup
	echo "CC = $(tc-getCC)" > "${CONFIG}" || die

	echo "CONFIG_ACS=n" >> "${CONFIG}" || die   # Disable Automatic Channel Selection
	echo "CONFIG_DEBUG_FILE=n" >> "${CONFIG}" || die   # Disable Debug file support
	echo "CONFIG_DPP=y" >> "${CONFIG}" || die   # Device Provisioning Protocol (for WPA3)
	echo "CONFIG_DRIVER_HOSTAP=y" >> "${CONFIG}" || die   # Host AP driver
	echo "CONFIG_DRIVER_NL80211=y" >> "${CONFIG}" || die   # nl80211 driver
	echo "CONFIG_DRIVER_NONE=n" >> "${CONFIG}" || die   # Disable unused drivers
	echo "CONFIG_DRIVER_WIRED=n" >> "${CONFIG}" || die   # Disable wired driver (since you're focusing on wireless AP)
	echo "CONFIG_EAP=y" >> "${CONFIG}" || die   # Enable EAP (Extensible Authentication Protocol)
	echo "CONFIG_EAP_AKA=n" >> "${CONFIG}" || die   # Disable SIM-based EAP
	echo "CONFIG_EAP_AKA_PRIME=n" >> "${CONFIG}" || die
	echo "CONFIG_EAP_EKE=n" >> "${CONFIG}" || die   # Disable EAP-EKE (uncommon)
	echo "CONFIG_EAP_FAST=y" >> "${CONFIG}" || die   # Enable EAP-FAST (for WPA3 transition)
	echo "CONFIG_EAP_GPSK=n" >> "${CONFIG}" || die   # GPSK not needed for WPA2/3
	echo "CONFIG_EAP_GTC=y" >> "${CONFIG}" || die   # Enable Generic Token Card support
	echo "CONFIG_EAP_IKEV2=n" >> "${CONFIG}" || die   # Disable IKEv2 (not required)
	echo "CONFIG_EAP_MD5=y" >> "${CONFIG}" || die   # Basic EAP-MD5 support
	echo "CONFIG_EAP_MSCHAPV2=y" >> "${CONFIG}" || die   # Enable MSCHAPv2
	echo "CONFIG_EAP_PEAP=y" >> "${CONFIG}" || die   # Enable PEAP
	echo "CONFIG_EAP_PSK=n" >> "${CONFIG}" || die   # Disable PSK (not needed)
	echo "CONFIG_EAP_PWD=y" >> "${CONFIG}" || die   # Enable EAP-pwd (for WPA3)
	echo "CONFIG_EAP_SAKE=n" >> "${CONFIG}" || die   # Disable SAKE
	echo "CONFIG_EAP_SIM=n" >> "${CONFIG}" || die   # Disable SIM-based EAP
	echo "CONFIG_EAP_TLS=y" >> "${CONFIG}" || die   # Enable EAP-TLS
	echo "CONFIG_EAP_TNC=n" >> "${CONFIG}" || die   # Disable TNC
	echo "CONFIG_EAP_TTLS=y" >> "${CONFIG}" || die   # Enable TTLS
	echo "CONFIG_ELOOP_EPOLL=y" >> "${CONFIG}" || die   # Use epoll for event handling
	echo "CONFIG_ERP=y" >> "${CONFIG}" || die   # Enable EAP Re-authentication Protocol
	echo "CONFIG_FST=n" >> "${CONFIG}" || die   # Disable Fast Session Transfer
	echo "CONFIG_FULL_DYNAMIC_VLAN=n" >> "${CONFIG}" || die   # Disable Dynamic VLAN
	echo "CONFIG_HS20=n" >> "${CONFIG}" || die   # Disable Hotspot 2.0
	echo "CONFIG_IAPP=n" >> "${CONFIG}" || die   # Disable Inter-Access Point Protocol
	echo "CONFIG_IEEE80211AC=y" >> "${CONFIG}" || die   # Enable 802.11ac (WPA2)
	echo "CONFIG_IEEE80211AX=y" >> "${CONFIG}" || die   # Enable 802.11ax (WPA3)
	echo "CONFIG_IEEE80211N=y" >> "${CONFIG}" || die   # Enable 802.11n
	echo "CONFIG_IEEE80211R=y" >> "${CONFIG}" || die   # Enable fast BSS transition (WPA2/3)
	echo "CONFIG_IEEE80211W=y" >> "${CONFIG}" || die   # Enable Management Frame Protection (for WPA3)
	echo "CONFIG_INTERWORKING=n" >> "${CONFIG}" || die   # Disable interworking (not needed)
	echo "CONFIG_IPV6=n" >> "${CONFIG}" || die   # Disable IPv6 support
	echo "CONFIG_LIBNL32=y" >> "${CONFIG}" || die   # Use libnl version 3.2
	echo "CONFIG_OCV=n" >> "${CONFIG}" || die   # Disable Operating Channel Validation
	echo "CONFIG_OWE=y" >> "${CONFIG}" || die   # Opportunistic Wireless Encryption (for WPA3)
	echo "CONFIG_PEERKEY=n" >> "${CONFIG}" || die   # Disable PeerKey (not needed for WPA2/3)
	echo "CONFIG_PKCS12=y" >> "${CONFIG}" || die   # Enable PKCS#12 support for certificates
	echo "CONFIG_RADIUS_SERVER=n" >> "${CONFIG}" || die   # Disable RADIUS server (not needed)
	echo "CONFIG_RSN_PREAUTH=y" >> "${CONFIG}" || die   # Enable Pre-authentication for WPA2
	echo "CONFIG_SAE=y" >> "${CONFIG}" || die   # Enable Simultaneous Authentication of Equals (for WPA3)
	echo "CONFIG_SQLITE=y" >> "${CONFIG}" || die   # Enable SQLite (optional)
	echo "CONFIG_TLSV11=y" >> "${CONFIG}" || die   # Enable TLS 1.1
	echo "CONFIG_TLSV12=y" >> "${CONFIG}" || die   # Enable TLS 1.2
	echo "CONFIG_VLAN_NETLINK=n" >> "${CONFIG}" || die   # Disable VLAN handling via netlink
	echo "CONFIG_WNM=n" >> "${CONFIG}" || die   # Disable Wireless Network Management

	default
}

src_compile() {
	emake V=1

	emake V=1 nt_password_hash
	emake V=1 hlr_auc_gw
}

src_install() {
	insinto /etc/${PN}
	doins ${PN}.{conf,accept,deny,eap_user,radius_clients,sim_db,wpa_psk}

	fperms -R 600 /etc/${PN}

	dosbin ${PN}
	dobin ${PN}_cli
	dobin nt_password_hash hlr_auc_gw

	if use systemd; then
		insinto /usr/lib/systemd/system
		insopts -m 0644
		doins "${FILESDIR}"/${PN}.service
	fi

	doman ${PN}{.8,_cli.1}
}
