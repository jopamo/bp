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

PATCHES=( ${FILESDIR}/p1.patch )

src_prepare() {
	default
	find . -type f -exec touch -r configure {} +
	elibtoolize
}

src_configure() {
	# Make sure mpfr doesn't go probing toolchains it shouldn't #476336#19
	ECONF_SOURCE=${S} \
	user_redefine_cc=yes \
	econf \
		--docdir="\$(datarootdir)/doc/${PF}" \
		$(use_enable static-libs static)
}

src_install() {
	default
	use static-libs || find "${ED}"/usr -name '*.la' -delete
}
