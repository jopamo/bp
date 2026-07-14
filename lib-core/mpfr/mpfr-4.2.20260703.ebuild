# Distributed under the terms of the GNU General Public License v2

BRANCH_NAME="$(ver_cut 1-2)"

inherit autotools qa-policy

DESCRIPTION="library for multiple-precision floating-point computations with exact rounding"
HOMEPAGE="http://www.mpfr.org/"
SNAPSHOT=0ca6ce4d255304efb5cf0e972b8a90b8f09dceb5
SRC_URI="https://gitlab.inria.fr/mpfr/mpfr/-/archive/${SNAPSHOT}/mpfr-${SNAPSHOT}.tar.bz2 -> ${PN}-${SNAPSHOT}.tar.bz2"
S=${WORKDIR}/mpfr-${SNAPSHOT}

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

RDEPEND="lib-core/gmp[static-libs?]"

src_prepare() {
	qa-policy-configure
	default
	eautoreconf
}

src_configure() {
	ECONF_SOURCE=${S} user_redefine_cc=yes \
		econf $(use_enable static-libs static)
}

src_install() {
	default
	qa-policy-install
}
