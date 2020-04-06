# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="c_rehash script from OpenSSL"
HOMEPAGE="https://www.openssl.org/ https://github.com/pld-linux/openssl/"
EGIT_REPO_URI="https://github.com/pld-linux/openssl.git"

LICENSE="openssl"
SLOT="0"
KEYWORDS="amd64 arm64"

src_prepare() {
	default
	SSL_CNF_DIR="/etc/ssl"
	sed \
		-e "/^DIR=/s:=.*:=${EPREFIX}${SSL_CNF_DIR}:" \
		-e "s:SSL_CMD=/usr:SSL_CMD=${EPREFIX}/usr:" \
		"${S}"/openssl-c_rehash.sh \
		> "${WORKDIR}"/c_rehash || die #416717
}

src_install() {
	dobin "${WORKDIR}"/c_rehash
}
