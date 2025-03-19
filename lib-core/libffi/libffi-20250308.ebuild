# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="a portable, high level programming interface to various calling conventions"
HOMEPAGE="https://github.com/libffi/libffi"

SNAPSHOT=cf69efabcaefcb6803f6cefd970741d10c17cec1
SRC_URI="https://github.com/libffi/libffi/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="debug static-libs"

src_prepare() {
	rm -rf autom4te.cache/
	rm -f config.log config.cache config.status
	rm -f Makefile Makefile.in
	rm -f aclocal.m4
	rm -f configure
	rm -f *.o *.lo *.la *.a
	rm -f libtool ltmain.sh
	sed -i '/AX_ENABLE_BUILDDIR/d' configure.ac

	default
	eautoreconf
}

src_configure() {
	local myconf=(
		$(use_enable static-libs static)
		$(use_enable debug)
		--enable-pax_emutramp
		--enable-portable-binary
		--disable-exec-static-tramp
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
