# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="c_rehash script from OpenSSL"
HOMEPAGE="https://www.openssl.org/ https://github.com/pld-linux/openssl/"
SRC_URI="https://cvs.pld-linux.org/cgi-bin/cvsweb.cgi/packages/openssl/openssl-c_rehash.sh?rev=${PV} -> openssl-c_rehash.sh.${PV}"

LICENSE="openssl"
SLOT="0/1"
KEYWORDS="amd64 arm64"

S=${WORKDIR}

src_prepare() {
	default
	SSL_CNF_DIR="/etc/ssl"
	sed \
		-e "/^DIR=/s:=.*:=${EPREFIX}${SSL_CNF_DIR}:" \
		-e "s:SSL_CMD=/usr:SSL_CMD=${EPREFIX}/usr:" \
		"${DISTDIR}"/openssl-c_rehash.sh.${PV} \
		> "${WORKDIR}"/c_rehash || die #416717
}

src_install() {
	dobin "${WORKDIR}"/c_rehash
}
