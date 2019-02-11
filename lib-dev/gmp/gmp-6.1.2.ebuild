# Distributed under the terms of the GNU General Public License v2

EAPI="5"

inherit flag-o-matic eutils libtool multilib-minimal

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

MULTILIB_WRAPPED_HEADERS=( /usr/include/gmp.h )

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

multilib_src_configure() {
	# Because of our 32-bit userland, 1.0 is the only HPPA ABI that works
	# http://gmplib.org/manual/ABI-and-ISA.html#ABI-and-ISA (bug #344613)
	if [[ ${CHOST} == hppa2.0-* ]] ; then
		GMPABI="1.0"
	fi

	# ABI mappings (needs all architectures supported)
	case ${ABI} in
		32|x86)       GMPABI=32;;
		64|amd64|n64) GMPABI=64;;
		[onx]32)      GMPABI=${ABI};;
	esac
	export GMPABI

	#367719
	if [[ ${CHOST} == *-mint* ]]; then
		filter-flags -O?
	fi

	tc-export CC
	ECONF_SOURCE="${S}" econf \
		--localstatedir="${EPREFIX}"/var/state/gmp \
		--enable-shared \
		$(use_enable asm assembly) \
		$(use_enable cxx) \
		$(use_enable static-libs static)
}

multilib_src_compile() {
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

multilib_src_test() {
	emake check
}

multilib_src_install() {
	emake DESTDIR="${D}" install

	# should be a standalone lib
	rm -f "${ED}"/usr/$(get_libdir)/libgmp.la
	# this requires libgmp
	local la="${ED}/usr/$(get_libdir)/libgmpxx.la"
	use static-libs \
		&& sed -i 's:/[^ ]*/libgmp.la:-lgmp:' "${la}" \
		|| rm -f "${la}"
}

multilib_src_install_all() {
	einstalldocs
	use doc && cp "${DISTDIR}"/gmp-man-${MY_PV}.pdf "${ED}"/usr/share/doc/${PF}/
}
