# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

DESCRIPTION="a small, fast, portable implementation of TLS/SSL"
HOMEPAGE="https://www.wolfssl.com/"
SRC_URI="https://github.com/wolfSSL/wolfssl/archive/v${PV}-stable.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${P}-stable"

LICENSE="GPLv2"
SLOT="0"
KEYWORDS="amd64 arm64"

src_prepare() {
	default
	eautoreconf
}
