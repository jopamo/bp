# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="tcltk/tcl - Tool Command Language"
HOMEPAGE="http://www.tcl.tk/"

SNAPSHOT=8b940282b38f2730ed5d203196704af111dc9aa6
SRC_URI="https://github.com/tcltk/tcl/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/tcl-${SNAPSHOT}/unix

LICENSE="tcltk"
SLOT="0"
KEYWORDS="amd64 arm64"

BDEPEND="app-dev/patchelf"

src_prepare() {
	eautoreconf
	default
}

src_configure() {
	ECONF_SOURCE=${S} econf --enable-64bit
}

src_install() {
	emake INSTALL_ROOT="${ED}" install install-private-headers

	for x in libtcl$(ver_cut 1-2).so.1 libtcl.so libtcl.so.$(ver_cut 1-2).0 ; do
		dosym libtcl$(ver_cut 1-2).so usr/lib/${x}
	done

	patchelf --set-soname libtcl.so.$(ver_cut 1-2).0 "${ED}"/usr/lib/libtcl8.6.so

	 _tclver=$(ver_cut 1-2)
    sed -i "s#${S}/unix#/usr/lib#" "${ED}/usr/lib/tclConfig.sh"
    sed -i "s#${S}#/usr/include#" "${ED}/usr/lib/tclConfig.sh"
    sed -i "s#'{/usr/lib} '#'/usr/lib/tcl${_tclver}'#" "${ED}/usr/lib/tclConfig.sh"
    sed -i "s#TCL_SRC_DIR='${S%/*}'#TCL_SRC_DIR='/usr/include/tcl${_tclver}'#" "${ED}/usr/lib/tclConfig.sh"
}
