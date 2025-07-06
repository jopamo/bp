# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="bash version of c_rehash script from OpenSSL"
HOMEPAGE="https://www.openssl.org/"

LICENSE="openssl"
SLOT="0"
KEYWORDS="amd64 arm64"

S=${WORKDIR}

src_prepare() {
	default
	SSL_CNF_DIR="/etc/ssl"
	sed \
		-e "/^DIR=/s:=.*:=${EPREFIX}${SSL_CNF_DIR}:" \
		-e "s:SSL_CMD=/usr:SSL_CMD=${EPREFIX}/usr:" \
		"${FILESDIR}"/openssl-c_rehash.sh \
		> "${WORKDIR}"/c_rehash || die #416717
}

src_install() {
	dobin "${WORKDIR}"/c_rehash
}
