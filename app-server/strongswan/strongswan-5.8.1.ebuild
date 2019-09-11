# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit linux-info user flag-o-matic

DESCRIPTION="IPsec-based VPN solution focused on security and ease of use"
HOMEPAGE="http://www.strongswan.org/"
SRC_URI="http://download.strongswan.org/${P}.tar.bz2"

LICENSE="GPL-2 RSA DES"
SLOT="0/1"
KEYWORDS="amd64 arm64"

IUSE="+caps curl +constraints debug dhcp eap farp +gmp ldap mysql networkmanager +non-root sqlite systemd pam pkcs11"

STRONGSWAN_PLUGINS_STD="led lookip systime-fix unity vici"
STRONGSWAN_PLUGINS_OPT="blowfish ccm ctr gcm ha ipseckey ntru padlock rdrand unbound whitelist"
for mod in $STRONGSWAN_PLUGINS_STD; do
	IUSE="${IUSE} +strongswan_plugins_${mod}"
done

for mod in $STRONGSWAN_PLUGINS_OPT; do
	IUSE="${IUSE} strongswan_plugins_${mod}"
done

COMMON_DEPEND="!app-net/openswan
	gmp? ( >=lib-dev/gmp-4.1.5:= )
	lib-dev/libgcrypt:0
	caps? ( lib-sys/libcap )
	curl? ( app-net/curl )
	ldap? ( app-net/openldap )
	mysql? ( app-server/mariadb )
	sqlite? ( >=lib-sys/sqlite-3.3.1 )
	networkmanager? ( app-net/networkmanager )
	pam? ( lib-sys/pam )
	strongswan_plugins_unbound? ( app-server/unbound lib-net/ldns )"
DEPEND="${COMMON_DEPEND}
	sys-kernel/linux-headers"
RDEPEND="${COMMON_DEPEND}
	app-net/iproute2
"

UGID="ipsec"

filter-flags -flto\=\* -Wl,-z,defs -Wl,-z,relro

pkg_setup() {
	linux-info_pkg_setup

	if ! kernel_is -ge 2 6 16; then
		eerror
		eerror "This ebuild currently only supports ${PN} with the"
		eerror "native Linux 2.6 IPsec stack on kernels >= 2.6.16."
		eerror
	fi

	if use non-root; then
		enewgroup ${UGID}
		enewuser ${UGID} -1 -1 -1 ${UGID}
	fi
}

src_configure() {
	local myconf=""

	if use non-root; then
		myconf="${myconf} --with-user=${UGID} --with-group=${UGID}"
	fi

	# If a user has already enabled db support, those plugins will
	# most likely be desired as well. Besides they don't impose new
	# dependencies and come at no cost (except for space).
	if use mysql || use sqlite; then
		myconf="${myconf} --enable-attr-sql --enable-sql"
	fi

	# strongSwan builds and installs static libs by default which are
	# useless to the user (and to strongSwan for that matter) because no
	# header files or alike get installed... so disabling them is safe.
	if use pam && use eap; then
		myconf="${myconf} --enable-eap-gtc"
	else
		myconf="${myconf} --disable-eap-gtc"
	fi

	for mod in $STRONGSWAN_PLUGINS_STD; do
		if use strongswan_plugins_${mod}; then
			myconf+=" --enable-${mod}"
		fi
	done

	for mod in $STRONGSWAN_PLUGINS_OPT; do
		if use strongswan_plugins_${mod}; then
			myconf+=" --enable-${mod}"
		fi
	done

	econf \
		--disable-static \
		--enable-ikev1 \
		--enable-ikev2 \
		--enable-swanctl \
		--enable-socket-dynamic \
		$(use_with caps capabilities libcap) \
		$(use_enable curl) \
		$(use_enable constraints) \
		$(use_enable ldap) \
		$(use_enable debug leak-detective) \
		$(use_enable dhcp) \
		$(use_enable eap eap-sim) \
		$(use_enable eap eap-sim-file) \
		$(use_enable eap eap-simaka-sql) \
		$(use_enable eap eap-simaka-pseudonym) \
		$(use_enable eap eap-simaka-reauth) \
		$(use_enable eap eap-identity) \
		$(use_enable eap eap-md5) \
		$(use_enable eap eap-aka) \
		$(use_enable eap eap-aka-3gpp2) \
		$(use_enable eap md4) \
		$(use_enable eap eap-mschapv2) \
		$(use_enable eap eap-radius) \
		$(use_enable eap eap-tls) \
		$(use_enable eap xauth-eap) \
		$(use_enable eap eap-dynamic) \
		$(use_enable farp) \
		$(use_enable gmp) \
		--enable-gcrypt \
		$(use_enable mysql) \
		$(use_enable networkmanager nm) \
		--disable-openssl \
		$(use_enable pam xauth-pam) \
		$(use_enable pkcs11) \
		$(use_enable sqlite) \
		$(use_enable systemd) \
		${myconf}
}

src_install() {
	default

	local dir_ugid
	if use non-root; then
		fowners ${UGID}:${UGID} \
			/etc/ipsec.conf \
			/etc/strongswan.conf

		dir_ugid="${UGID}"
	else
		dir_ugid="root"
	fi

	diropts -m 0750 -o ${dir_ugid} -g ${dir_ugid}
	dodir /etc/ipsec.d \
		/etc/ipsec.d/aacerts \
		/etc/ipsec.d/acerts \
		/etc/ipsec.d/cacerts \
		/etc/ipsec.d/certs \
		/etc/ipsec.d/crls \
		/etc/ipsec.d/ocspcerts \
		/etc/ipsec.d/private \
		/etc/ipsec.d/reqs
}
