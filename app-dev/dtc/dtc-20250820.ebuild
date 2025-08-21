# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="Open Firmware device tree compiler"
HOMEPAGE="https://devicetree.org/ https://git.kernel.org/cgit/utils/dtc/dtc.git/"
SNAPSHOT=e1284ee5dc20f94097bc6424ede9c3e433dba77d
SRC_URI="https://github.com/dgibson/dtc/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/dtc-${SNAPSHOT}

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

DEPEND="
	app-build/bison
	app-build/flex
"

src_prepare() {
	default

	sed -i \
		-e '/^CFLAGS =/s:=:+=:' \
		-e '/^CPPFLAGS =/s:=:+=:' \
		-e 's:-Werror::' \
		-e 's:-g -Os::' \
		-e "/^PREFIX =/s:=.*:= ${EPREFIX}/usr:" \
		-e "/^LIBDIR =/s:=.*:= \$(PREFIX)/lib:" \
		Makefile || die

	tc-export AR CC
	export V=1
}

src_install() {
	default

	use static-libs || find "${ED}" -name '*.a' -delete
}
