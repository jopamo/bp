# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="A library for multiprecision complex arithmetic with exact rounding"
HOMEPAGE="http://mpc.multiprecision.org/"
SRC_URI="https://ftp.gnu.org/gnu/mpc/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0/3"
KEYWORDS="amd64 arm64"
IUSE="static-libs"

DEPEND=">=lib-dev/gmp-5.0.0:0=[static-libs?]
	>=lib-dev/mpfr-3.0.0:0=[static-libs?]"

src_configure() {
	ECONF_SOURCE=${S} econf $(use_enable static-libs static)
}

src_install() {
	default
	find "${D}" -name '*.la' -delete || die
}
