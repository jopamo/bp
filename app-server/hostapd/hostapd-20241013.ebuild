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

IUSE="ipv6 netlink selinux sqlite +suiteb systemd +wps"

DEPEND="
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

	# EAP authentication methods
	echo "CONFIG_EAP=y" >> "${CONFIG}" || die
	echo "CONFIG_ERP=y" >> "${CONFIG}" || die
	echo "CONFIG_EAP_MD5=y" >> "${CONFIG}" || die

	if use suiteb; then
		echo "CONFIG_SUITEB=y" >> "${CONFIG}" || die
		echo "CONFIG_SUITEB192=y" >> "${CONFIG}" || die
	fi

	echo "CONFIG_DPP=y" >> "${CONFIG}" || die
	echo "CONFIG_EAP_FAST=y" >> "${CONFIG}" || die
	echo "CONFIG_EAP_MSCHAPV2=y" >> "${CONFIG}" || die
	echo "CONFIG_EAP_PEAP=y" >> "${CONFIG}" || die
	echo "CONFIG_EAP_PWD=y" >> "${CONFIG}" || die
	echo "CONFIG_EAP_TLS=y" >> "${CONFIG}" || die
	echo "CONFIG_EAP_TTLS=y" >> "${CONFIG}" || die
	echo "CONFIG_OWE=y" >> "${CONFIG}" || die
	echo "CONFIG_SAE=y" >> "${CONFIG}" || die
	echo "CONFIG_TLSV11=y" >> "${CONFIG}" || die
	echo "CONFIG_TLSV12=y" >> "${CONFIG}" || die

	if use wps; then
		# Enable Wi-Fi Protected Setup
		echo "CONFIG_WPS=y" >> "${CONFIG}" || die
		echo "CONFIG_WPS2=y" >> "${CONFIG}" || die
		echo "CONFIG_WPS_UPNP=y" >> "${CONFIG}" || die
		echo "CONFIG_WPS_NFC=y" >> "${CONFIG}" || die
		einfo "Enabling Wi-Fi Protected Setup support"
	fi

	echo "CONFIG_EAP_IKEV2=y" >> "${CONFIG}" || die
	echo "CONFIG_EAP_TNC=y" >> "${CONFIG}" || die
	echo "CONFIG_EAP_GTC=y" >> "${CONFIG}" || die
	echo "CONFIG_EAP_SIM=y" >> "${CONFIG}" || die
	echo "CONFIG_EAP_AKA=y" >> "${CONFIG}" || die
	echo "CONFIG_EAP_AKA_PRIME=y" >> "${CONFIG}" || die
	echo "CONFIG_EAP_EKE=y" >> "${CONFIG}" || die
	echo "CONFIG_EAP_PAX=y" >> "${CONFIG}" || die
	echo "CONFIG_EAP_PSK=y" >> "${CONFIG}" || die
	echo "CONFIG_EAP_SAKE=y" >> "${CONFIG}" || die
	echo "CONFIG_EAP_GPSK=y" >> "${CONFIG}" || die
	echo "CONFIG_EAP_GPSK_SHA256=y" >> "${CONFIG}" || die

	einfo "Enabling drivers: "

	# drivers
	echo "CONFIG_DRIVER_HOSTAP=y" >> "${CONFIG}" || die
	einfo "  HostAP driver enabled"
	echo "CONFIG_DRIVER_WIRED=y" >> "${CONFIG}" || die
	einfo "  Wired driver enabled"
	echo "CONFIG_DRIVER_NONE=y" >> "${CONFIG}" || die
	einfo "  None driver enabled"

	einfo "  nl80211 driver enabled"
	echo "CONFIG_DRIVER_NL80211=y" >> "${CONFIG}" || die

	# epoll
	echo "CONFIG_ELOOP_EPOLL=y" >> "${CONFIG}" || die

	# misc
	echo "CONFIG_DEBUG_FILE=y" >> "${CONFIG}" || die
	echo "CONFIG_PKCS12=y" >> "${CONFIG}" || die
	echo "CONFIG_RADIUS_SERVER=y" >> "${CONFIG}" || die
	echo "CONFIG_IAPP=y" >> "${CONFIG}" || die
	echo "CONFIG_IEEE80211R=y" >> "${CONFIG}" || die
	echo "CONFIG_IEEE80211W=y" >> "${CONFIG}" || die
	echo "CONFIG_IEEE80211N=y" >> "${CONFIG}" || die
	echo "CONFIG_IEEE80211AC=y" >> "${CONFIG}" || die
	echo "CONFIG_IEEE80211AX=y" >> "${CONFIG}" || die
	echo "CONFIG_OCV=y" >> "${CONFIG}" || die
	echo "CONFIG_PEERKEY=y" >> "${CONFIG}" || die
	echo "CONFIG_RSN_PREAUTH=y" >> "${CONFIG}" || die
	echo "CONFIG_INTERWORKING=y" >> "${CONFIG}" || die
	echo "CONFIG_FULL_DYNAMIC_VLAN=y" >> "${CONFIG}" || die
	echo "CONFIG_HS20=y" >> "${CONFIG}" || die
	echo "CONFIG_WNM=y" >> "${CONFIG}" || die
	echo "CONFIG_FST=y" >> "${CONFIG}" || die
	echo "CONFIG_FST_TEST=y" >> "${CONFIG}" || die
	echo "CONFIG_ACS=y" >> "${CONFIG}" || die

	if use netlink; then
		# Netlink support
		echo "CONFIG_VLAN_NETLINK=y" >> "${CONFIG}" || die
	fi

	if use ipv6; then
		# IPv6 support
		echo "CONFIG_IPV6=y" >> "${CONFIG}" || die
	fi

	if use sqlite; then
		# Sqlite support
		echo "CONFIG_SQLITE=y" >> "${CONFIG}" || die
	fi

	if use kernel_linux; then
		echo "CONFIG_LIBNL32=y" >> "${CONFIG}" || die
		append-cflags "$($(tc-getPKG_CONFIG) --cflags libnl-3.0)"
	fi

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
