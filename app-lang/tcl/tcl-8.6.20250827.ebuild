# Distributed under the terms of the GNU General Public License v2

EAPI=8

BRANCH_NAME="core-$(ver_cut 1)-$(ver_cut 2)-branch"

inherit autotools

DESCRIPTION="tcltk/tcl - Tool Command Language"
HOMEPAGE="http://www.tcl.tk/"
SNAPSHOT=9f4d27365595b1a66b01473a9e3d5a23a4e54eea
SRC_URI="https://github.com/tcltk/tcl/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/tcl-${SNAPSHOT}/unix

LICENSE="tcltk"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="lib-core/sqlite"

PATCHES=(
	"${FILESDIR}"/${PN}-8.6.8-conf.patch
	"${FILESDIR}"/${PN}-8.6.9-include-spec.patch
)

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	ECONF_SOURCE=${S} econf --enable-64bit
}

src_install() {
	emake INSTALL_ROOT="${ED}" install install-private-headers

	local v1=$(ver_cut 1-2)

	for x in lib${PN}${v1}.so.1 lib${PN}.so lib${PN}.so.${v1}.0 ; do
		dosym lib${PN}${v1}.so usr/lib/${x}
	done

	patchelf --set-soname lib${PN}.so.${v1}.0 "${ED}"/usr/lib/lib${PN}${v1}.so

	 _tclver=$(ver_cut 1-2)
    sed -i "s#${S}/unix#/usr/lib#" "${ED}/usr/lib/tclConfig.sh"
    sed -i "s#${S}#/usr/include#" "${ED}/usr/lib/tclConfig.sh"
    sed -i "s#'{/usr/lib} '#'/usr/lib/tcl${_tclver}'#" "${ED}/usr/lib/tclConfig.sh"
    sed -i "s#TCL_SRC_DIR='${S%/*}'#TCL_SRC_DIR='/usr/include/tcl${_tclver}'#" "${ED}/usr/lib/tclConfig.sh"

    dosym -r /usr/lib/pkgconfig/tcl.pc /usr/lib/pkgconfig/tcl$(ver_cut 1)$(ver_cut 2).pc
}
