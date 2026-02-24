# Distributed under the terms of the GNU General Public License v2

EAPI=8
SNAPSHOT=38cf72a41b708475fc22dc9fc62c7caae1ac29f6
SHORT=${SNAPSHOT:0:7}

inherit autotools dot-a

DESCRIPTION="A library for manipulating integer points bounded by linear constraints"
HOMEPAGE="http://isl.gforge.inria.fr/"
SRC_URI="https://repo.or.cz/isl.git/snapshot/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/isl-${SHORT}

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="gdb.py static-libs"

DEPEND="
	lib-core/gmp
	app-compression/xz-utils
"

src_prepare() {
	use static-libs && lto-guarantee-fat

	default
	eautoreconf
	sed -i -e '/Libs:/s:@LDFLAGS@ ::' configure || die
}

src_configure() {
	ECONF_SOURCE=${S} econf CFLAGS="${CFLAGS}" $(use_enable static-libs static)
}

src_install() {
	default
	use static-libs && strip-lto-bytecode
	use gdb.py || rm "${ED}"/usr/lib/libisl.so.*-gdb.py || die
}
