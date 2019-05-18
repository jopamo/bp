# Distributed under the terms of the GNU General Public License v2

EAPI="5"

inherit flag-o-matic libtool

MY_PV=${PV/_p*}
MY_PV=${MY_PV/_/-}
MY_P=${PN}-${MY_PV}
PLEVEL=${PV/*p}
DESCRIPTION="Library for arbitrary-precision arithmetic on different type of numbers"
HOMEPAGE="http://gmplib.org/"
SRC_URI="ftp://ftp.gmplib.org/pub/${MY_P}/${MY_P}.tar.xz
	mirror://gnu/${PN}/${MY_P}.tar.xz
	doc? ( http://gmplib.org/${PN}-man-${MY_PV}.pdf )"

LICENSE="|| ( LGPL-3+ GPL-2+ )"
# The subslot reflects the C & C++ SONAMEs.
SLOT="0/10.4"
KEYWORDS="amd64 arm64"
IUSE="+asm doc cxx pgo static-libs"

DEPEND="sys-devel/m4
	app-compression/xz-utils"
RDEPEND=""

S=${WORKDIR}/${MY_P%a}

src_prepare() {
	elibtoolize

	epatch "${FILESDIR}"/${PN}-6.1.0-noexecstack-detect.patch

	mv configure configure.wrapped || die
	cat <<-\EOF > configure
	#!/usr/bin/env sh
	exec env ABI="${GMPABI}" "$0.wrapped" "$@"
	EOF
	# Patches to original configure might have lost the +x bit.
	chmod a+rx configure{,.wrapped}
}

src_configure() {
	export GMPABI=64

	tc-export CC
	ECONF_SOURCE="${S}" econf \
		--localstatedir="${EPREFIX}"/var/state/gmp \
		--enable-shared \
		$(use_enable asm assembly) \
		$(use_enable cxx) \
		$(use_enable static-libs static)
}

src_compile() {
	emake

	if use pgo ; then
		emake -j1 -C tune tuneup
		ebegin "Trying to generate tuned data"
		./tune/tuneup | tee gmp.mparam.h.new
		if eend $(( 0 + ${PIPESTATUS[*]/#/+} )) ; then
			mv gmp.mparam.h.new gmp-mparam.h || die
			emake clean
			emake
		fi
	fi
}

src_test() {
	emake check
}

src_install() {
	emake DESTDIR="${D}" install

	# should be a standalone lib
	rm -f "${ED}"/usr/lib64/libgmp.la
	# this requires libgmp
	local la="${ED}/usr/lib64/libgmpxx.la"
	use static-libs \
		&& sed -i 's:/[^ ]*/libgmp.la:-lgmp:' "${la}" \
		|| rm -f "${la}"
}
