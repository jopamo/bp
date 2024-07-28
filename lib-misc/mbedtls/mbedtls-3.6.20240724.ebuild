# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Cryptographic library for embedded systems"
HOMEPAGE="https://tls.mbed.org/"

SNAPSHOT=b38e960f24df88d84ea65259d5daef61f8b23787
SRC_URI="https://github.com/Mbed-TLS/mbedtls/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/mbedtls-${SNAPSHOT}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

src_install() {
	emake DESTDIR="${ED}"/usr install
}
