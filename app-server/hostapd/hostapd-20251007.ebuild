# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic toolchain-funcs

DESCRIPTION="IEEE 802.11 wireless LAN Host AP daemon"
HOMEPAGE="https://w1.fi/ https://w1.fi/cgit/hostap/"
SNAPSHOT=31dc1462a11aaea02cc1e0e8ed3458ce8655e791
SRC_URI="https://github.com/1g4-mirror/hostap/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/hostap-${SNAPSHOT}/hostapd"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="netlink selinux systemd"

DEPEND="
	app-net/wpa_supplicant
	lib-core/sqlite
	lib-net/libnl
"
src_prepare() {
	filter-lto

	# Allow users to apply patches to src/drivers for example,
	# i.e. anything outside ${S}/hostapd
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

	echo "CONFIG_ACS=y" >> "${CONFIG}" || die                 # Disable Automatic Channel Selection
	echo "CONFIG_AIRTIME_POLICY=y" >> "${CONFIG}" || die     # Enable Airtime Policy Support
	echo "CONFIG_AP=y" >> "${CONFIG}" || die                 # Enable Access Point mode
	echo "CONFIG_DEBUG_FILE=y" >> "${CONFIG}" || die         # Enable debug file
	echo "CONFIG_DPP2=y" >> "${CONFIG}" || die               # Device Provisioning Protocol v2
	echo "CONFIG_DPP=y" >> "${CONFIG}" || die                # Device Provisioning Protocol (WPA3)
	echo "CONFIG_DRIVER_HOSTAP=y" >> "${CONFIG}" || die      # Host AP driver
	echo "CONFIG_DRIVER_NL80211=y" >> "${CONFIG}" || die     # nl80211 driver
	echo "CONFIG_DRIVER_NONE=n" >> "${CONFIG}" || die        # Disable unused drivers
	echo "CONFIG_DRIVER_WIRED=n" >> "${CONFIG}" || die       # Disable wired driver
	echo "CONFIG_EAP=y" >> "${CONFIG}" || die                # Enable EAP (Extensible Authentication Protocol)
	echo "CONFIG_EAP_AKA=n" >> "${CONFIG}" || die            # Disable SIM-based EAP
	echo "CONFIG_EAP_FAST=y" >> "${CONFIG}" || die           # Enable EAP-FAST
	echo "CONFIG_EAP_GTC=y" >> "${CONFIG}" || die            # Enable Generic Token Card support
	echo "CONFIG_EAP_MD5=y" >> "${CONFIG}" || die            # Enable EAP-MD5
	echo "CONFIG_EAP_MSCHAPV2=y" >> "${CONFIG}" || die       # Enable MSCHAPv2
	echo "CONFIG_EAP_PEAP=y" >> "${CONFIG}" || die           # Enable PEAP
	echo "CONFIG_EAP_PWD=y" >> "${CONFIG}" || die            # Enable EAP-pwd (for WPA3)
	echo "CONFIG_EAP_TLS=y" >> "${CONFIG}" || die            # Enable EAP-TLS
	echo "CONFIG_EAP_TTLS=y" >> "${CONFIG}" || die           # Enable TTLS
	echo "CONFIG_ELOOP_EPOLL=y" >> "${CONFIG}" || die        # Use epoll for event handling
	echo "CONFIG_ERP=y" >> "${CONFIG}" || die                # Enable EAP Re-authentication Protocol
	echo "CONFIG_FILS=y" >> "${CONFIG}" || die               # Fast Initial Link Setup for efficient roaming
	echo "CONFIG_FILS_SK_PFS=y" >> "${CONFIG}" || die        # FILS with PFS
	echo "CONFIG_FULL_DYNAMIC_VLAN=y" >> "${CONFIG}" || die  # Enable Dynamic VLAN
	echo "CONFIG_IEEE80211AC=y" >> "${CONFIG}" || die        # Enable 802.11ac (Wi-Fi 5)
	echo "CONFIG_IEEE80211AX=y" >> "${CONFIG}" || die        # Enable 802.11ax (Wi-Fi 6)
	echo "CONFIG_IEEE80211BE=y" >> "${CONFIG}" || die        # Enable 802.11be (Wi-Fi 7, if supported)
	echo "CONFIG_IEEE80211N=y" >> "${CONFIG}" || die         # Enable 802.11n (Wi-Fi 4)
	echo "CONFIG_IEEE80211R=y" >> "${CONFIG}" || die          # Enable Fast BSS Transition
	echo "CONFIG_IEEE80211R=y" >> "${CONFIG}" || die         # Enable Fast BSS Transition for WPA3
	echo "CONFIG_IEEE80211W=y" >> "${CONFIG}" || die         # Enable Management Frame Protection
	echo "CONFIG_LIBNL32=y" >> "${CONFIG}" || die            # Use libnl version 3.2
	echo "CONFIG_MBO=y" >> "${CONFIG}" || die                # Multiband Operation Support
	echo "CONFIG_MLO=y" >> "${CONFIG}" || die                # Multi-Link Operation for Wi-Fi 7
	echo "CONFIG_OWE=y" >> "${CONFIG}" || die                # Opportunistic Wireless Encryption
	echo "CONFIG_PASN=y" >> "${CONFIG}" || die               # Pre-Association Security Negotiation
	echo "CONFIG_PKCS12=y" >> "${CONFIG}" || die             # Enable PKCS#12 support for certificates
	echo "CONFIG_RSN_PREAUTH=y" >> "${CONFIG}" || die        # Enable Pre-authentication for WPA2
	echo "CONFIG_SAE=y" >> "${CONFIG}" || die                # Support for WPA3 SAE
	echo "CONFIG_SQLITE=y" >> "${CONFIG}" || die             # Enable SQLite
	echo "CONFIG_TLSV11=y" >> "${CONFIG}" || die             # Enable TLS v1.1
	echo "CONFIG_TLSV12=y" >> "${CONFIG}" || die             # Enable TLS v1.2
	echo "CONFIG_WPA3_SAE=y" >> "${CONFIG}" || die           # Enable WPA3 SAE
	echo "CONFIG_OCV=n" >> "${CONFIG}" || die           # Enable WPA3 SAE

	default
}

src_compile() {
	emake V=1

	emake V=1 nt_password_hash
	emake V=1 hlr_auc_gw
}

src_install() {
	insinto /etc/hostapd
	doins hostapd.{conf,accept,deny,eap_user,radius_clients,sim_db,wpa_psk}

	fperms -R 600 /etc/hostapd

	dobin hostapd
	dobin hostapd_cli
	dobin nt_password_hash hlr_auc_gw

	if use systemd; then
		insinto /usr/lib/systemd/system
		insopts -m 0644
		doins "${FILESDIR}"/hostapd.service
	fi

	doman hostapd{.8,_cli.1}
}
