# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Small RSA key management package, based on OpenSSL"
HOMEPAGE="https://openvpn.net/"
SRC_URI="https://github.com/OpenVPN/easy-rsa/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

PATCHES=( "${FILESDIR}"/0001-fix-paths.patch )

src_prepare() {
	default

	# fix output of help command, we have it in PATH
	sed -i 's|./easyrsa|easyrsa|' easyrsa3/easyrsa
}

src_install() {
	dobin easyrsa3/easyrsa

	insinto etc/easy-rsa/
	doins easyrsa3/openssl-easyrsa.cnf
}
