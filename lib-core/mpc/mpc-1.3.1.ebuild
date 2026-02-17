# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dot-a

DESCRIPTION="A library for multiprecision complex arithmetic with exact rounding"
HOMEPAGE="http://mpc.multiprecision.org/"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

DEPEND="lib-core/mpfr[static-libs?]"

src_prepare() {
	use static-libs && lto-guarantee-fat
	default
}

src_configure() {
	ECONF_SOURCE=${S} econf $(use_enable static-libs static)
}

src_install() {
	default
	use static-libs && strip-lto-bytecode
}
