# Distributed under the terms of the GNU General Public License v2

SNAPSHOT=6853e0c278f0047a05667113963f6af0175a3118
SHORT=${SNAPSHOT:0:7}

inherit autotools qa-policy

DESCRIPTION="A library for manipulating integer points bounded by linear constraints"
HOMEPAGE="http://isl.gforge.inria.fr/"
SRC_URI="https://repo.or.cz/isl.git/snapshot/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/isl-${SHORT}

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="gdb.py static-libs"

PATCHES=( "${FILESDIR}/${PN}-20261003-exception-header.patch" )

DEPEND="
	lib-core/gmp
	app-compression/xz-utils
"

src_prepare() {
	qa-policy-configure
	default
	eautoreconf
	sed -i -e '/Libs:/s:@LDFLAGS@ ::' configure || die
}

src_configure() {
	ECONF_SOURCE=${S} econf CFLAGS="${CFLAGS}" $(use_enable static-libs static)
}

src_install() {
	default
	qa-policy-install
	use gdb.py || rm "${ED}"/usr/lib/libisl.so.*-gdb.py || die
}
