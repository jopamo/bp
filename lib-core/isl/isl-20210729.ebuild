# Distributed under the terms of the GNU General Public License v2

EAPI=8

SNAPSHOT=ac60ef1fb99a90c9ab579fdec03f52a540ab56e2
SHORT=${SNAPSHOT:0:7}

inherit autotools

DESCRIPTION="A library for manipulating integer points bounded by linear constraints"
HOMEPAGE="http://isl.gforge.inria.fr/"
SRC_URI="https://repo.or.cz/isl.git/snapshot/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
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
	default
	eautoreconf
	sed -i -e '/Libs:/s:@LDFLAGS@ ::' configure || die #382737
}

src_configure() {
	ECONF_SOURCE=${S} econf CFLAGS="${CFLAGS}" $(use_enable static-libs static)
}

src_install() {
	default
	use gdb.py || rm "${ED}"/usr/lib/libisl.so.23.1.0-gdb.py || die
}
