# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit libtool toolchain-funcs flag-o-matic

DESCRIPTION="Library for arbitrary-precision arithmetic on different type of numbers"
HOMEPAGE="http://gmplib.org/"
SRC_URI="https://gmplib.org/download/snapshot/gmp-next/gmp-$(ver_cut 1-2).0-$(ver_cut 3).tar.zst"
S="${WORKDIR}/gmp-$(ver_cut 1-2).0-$(ver_cut 3)"

LICENSE="|| ( LGPL-3+ GPL-2+ )"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="asm pgo static-libs"

DEPEND="
	app-build/m4
	app-compression/xz-utils
"

PATCHES=( "${FILESDIR}"/${PN}-6.1.0-noexecstack-detect.patch	)

src_unpack() {
	tar xvf "${DISTDIR}/gmp-$(ver_cut 1-2).0-$(ver_cut 3).tar.zst"
}


src_prepare() {
	use arm64 && filter-flags -flto*

	default
	elibtoolize

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

	# this requires libgmp
	local la="${ED}/usr/lib/libgmpxx.la"
	use static-libs \
		&& sed -i 's:/[^ ]*/libgmp.la:-lgmp:' "${la}" \
		|| rm -f "${la}"
}
