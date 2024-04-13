# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="library for multiple-precision floating-point computations with exact rounding"
HOMEPAGE="http://www.mpfr.org/"

SNAPSHOT=6ae53c72741be67631000611b969bb2bfe88a37c
SRC_URI="https://gitlab.inria.fr/mpfr/mpfr/-/archive/${SNAPSHOT}/mpfr-${SNAPSHOT}.tar.bz2 -> ${P}.tar.bz2"
S=${WORKDIR}/mpfr-${SNAPSHOT}

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

RDEPEND="lib-core/gmp[static-libs?]"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	ECONF_SOURCE=${S} user_redefine_cc=yes \
		econf $(use_enable static-libs static)
}
