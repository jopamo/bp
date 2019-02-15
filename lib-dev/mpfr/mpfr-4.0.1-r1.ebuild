# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit libtool

MY_PV=${PV/_p*}
MY_P=${PN}-${MY_PV}
PLEVEL=${PV/*p}
DESCRIPTION="library for multiple-precision floating-point computations with exact rounding"
HOMEPAGE="http://www.mpfr.org/"
SRC_URI="http://www.mpfr.org/mpfr-${MY_PV}/${MY_P}.tar.xz
		https://www.mpfr.org/mpfr-current/allpatches"

LICENSE="LGPL-2.1"
SLOT="0/6" # libmpfr.so version
KEYWORDS="amd64 arm64"
IUSE="static-libs"

RDEPEND=">=lib-dev/gmp-5.0.0[static-libs?]"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${MY_P}

PATCHES=(
		"${DISTDIR}/allpatches"
		)
src_prepare() {
	if [[ ${PLEVEL} != ${PV} ]] ; then
		local i
		for (( i = 1; i <= PLEVEL; ++i )) ; do
			epatch "${FILESDIR}"/${MY_PV}/patch$(printf '%02d' ${i})
		done
	fi
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

src_install_all() {
	use static-libs || find "${ED}"/usr -name '*.la' -delete
}
