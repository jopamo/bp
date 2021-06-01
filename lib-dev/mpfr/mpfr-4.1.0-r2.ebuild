# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit libtool

DESCRIPTION="library for multiple-precision floating-point computations with exact rounding"
HOMEPAGE="http://www.mpfr.org/"
SRC_URI="http://www.mpfr.org/mpfr-${PV}/${P}.tar.xz"

LICENSE="LGPL-2.1"
SLOT="0/6" # libmpfr.so version
KEYWORDS="amd64 arm64"

IUSE="static-libs"

RDEPEND=">=lib-dev/gmp-5.0.0[static-libs?]"

PATCHES=( "${FILESDIR}"/20210517.patch )

src_prepare() {
	default
	find . -type f -exec touch -r configure {} +
	elibtoolize
}

src_configure() {
	local myconf=(
		$(use_enable static-libs static)
	)
	ECONF_SOURCE=${S} user_redefine_cc=yes econf "${myconf[@]}"
}
