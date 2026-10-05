# Distributed under the terms of the GNU General Public License v2

inherit autotools

DESCRIPTION="Tool Command Language"
HOMEPAGE="https://www.tcl.tk/"
SNAPSHOT=0c6bad08d91fa2ad51f05a50a41f8c1ea82ce985
SRC_URI="https://github.com/tcltk/tcl/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/tcl-${SNAPSHOT}/unix"

LICENSE="tcltk"
SLOT="0"
KEYWORDS="amd64 arm64"

PATCHES=( "${FILESDIR}/tcl-8.6.8-conf.patch" )

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	econf --enable-64bit --disable-rpath
}

src_install() {
	emake INSTALL_ROOT="${ED}" install install-private-headers
	dosym -r /usr/bin/tclsh9.1 /usr/bin/tclsh
}
