# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit multilib-minimal

DESCRIPTION="A library for multiprecision complex arithmetic with exact rounding"
HOMEPAGE="http://mpc.multiprecision.org/"
SRC_URI="https://ftp.gnu.org/gnu/mpc/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0/3"
KEYWORDS="amd64 arm64 x86"
IUSE="static-libs"

DEPEND=">=lib-dev/gmp-5.0.0:0=[${MULTILIB_USEDEP},static-libs?]
	>=lib-dev/mpfr-3.0.0:0=[${MULTILIB_USEDEP},static-libs?]"
RDEPEND="${DEPEND}"

multilib_src_configure() {
	ECONF_SOURCE=${S} econf $(use_enable static-libs static)
}

multilib_src_install_all() {
	einstalldocs
	find "${D}" -name '*.la' -delete || die
}
