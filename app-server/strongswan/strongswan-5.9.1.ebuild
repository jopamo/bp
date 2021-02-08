# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit flag-o-matic

DESCRIPTION="IPsec-based VPN solution, supporting IKEv1/IKEv2 and MOBIKE"
HOMEPAGE="https://www.strongswan.org/"
SRC_URI="https://download.strongswan.org/${P}.tar.bz2"

LICENSE="GPL-2 RSA DES"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="app-net/iptables"

filter-flags -Wl,-z,defs -flto\=\*

src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/lib
		--libexecdir="${EPREFIX}"/usr/libexec
		--localstatedir="${EPREFIX}"/var
		--prefix="${EPREFIX}"/usr
    	--with-ipsecdir="${EPREFIX}"/usr/lib/strongswan
    	--with-nm-ca-dir="${EPREFIX}"/etc/ssl/certs
    	--enable-integrity-test
    	--enable-sqlite
    	--enable-pkcs11
    	--enable-openssl
    	--enable-curl
    	--enable-sql
    	--enable-attr-sql
    	--enable-farp
    	--enable-dhcp
    	--enable-eap-sim
    	--enable-eap-sim-file
    	--enable-eap-simaka-pseudonym
    	--enable-eap-simaka-reauth
    	--enable-eap-identity
    	--enable-eap-md5
    	--enable-eap-gtc
    	--enable-eap-aka
    	--enable-eap-aka-3gpp2
    	--enable-eap-mschapv2
    	--enable-eap-radius
    	--enable-xauth-eap
    	--enable-ha
    	--enable-vici
    	--enable-swanctl
    	--enable-systemd
    	--enable-ext-auth
    	--disable-mysql
    	--disable-ldap
    	--enable-cmd
    	--enable-forecast
    	--enable-connmark
    	--enable-aesni
    	--enable-eap-ttls
    	--enable-radattr
    	--enable-xauth-pam
    	--enable-xauth-noauth
    	--enable-eap-dynamic
    	--enable-eap-peap
    	--enable-eap-tls
    	--enable-chapoly
    	--enable-unity
    	--with-capabilities=libcap
    	--enable-newhope
    	--enable-ntru
    	--enable-mgf1
    	--enable-sha3
    	--enable-bliss
    	--enable-dnscert
    	--disable-nm
    	--enable-agent
    	--enable-bypass-lan
    	--disable-ruby-gems
    	--enable-python-eggs
	)

	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
