# Distributed under the terms of the GNU General Public License v2

inherit autotools toolchain-funcs flag-o-matic qa-policy

DESCRIPTION="Library for arbitrary-precision arithmetic on different type of numbers"
HOMEPAGE="http://gmplib.org/"

SNAPSHOT=d778d5a4a1c033ac9c9fc3f98be6022baf93e24d
SRC_URI="https://gitlab.com/pjo/gmp/-/archive/${SNAPSHOT}/${PN}-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="|| ( LGPL-3+ GPL-2+ )"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="asm pgo static-libs"

DEPEND="
	app-build/m4
	app-compression/xz-utils
"

src_prepare() {
	qa-policy-configure
	use arm64 && filter-flags -flto*

	default
	eautoreconf
}

src_configure() {
	tc-export CC

	local myconf=(
		--localstatedir="${EPREFIX}"/var/state/gmp
		--enable-shared
		--enable-cxx
    	--enable-fat
		$(use_enable asm assembly)
		$(use_enable static-libs static)
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
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
	qa-policy-install

	# this requires libgmp
	local la="${ED}/usr/lib/libgmpxx.la"
	use static-libs \
		&& sed -i 's:/[^ ]*/libgmp.la:-lgmp:' "${la}" \
		|| rm -f "${la}"
}
