# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit

DESCRIPTION="Cryptographic library for embedded systems"
HOMEPAGE="https://tls.mbed.org/"
SNAPSHOT=9343c6d3232b131c0295886a5949a673ee0a8c5f
SRC_URI="https://github.com/ARMmbed/mbedtls/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/mbedtls-${SNAPSHOT}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

src_install() {
	emake DESTDIR="${ED}"/usr install
}
