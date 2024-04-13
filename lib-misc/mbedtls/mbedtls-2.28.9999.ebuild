# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="Cryptographic library for embedded systems"
HOMEPAGE="https://tls.mbed.org/"
EGIT_REPO_URI="https://github.com/ARMmbed/mbedtls.git"
EGIT_BRANCH="mbedtls-$(ver_cut 1).$(ver_cut 2)"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

src_install() {
	emake DESTDIR="${ED}"/usr install
}
