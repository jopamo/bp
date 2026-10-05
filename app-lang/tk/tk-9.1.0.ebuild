# Distributed under the terms of the GNU General Public License v2

inherit autotools

DESCRIPTION="Tk Widget Set"
HOMEPAGE="https://www.tcl.tk/"
SNAPSHOT=3f45110c0a568b70f2ebd5412f215e87d199bc7d
SRC_URI="https://github.com/tcltk/tk/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/tk-${SNAPSHOT}/unix"

LICENSE="tcltk"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="debug truetype"

DEPEND="
	>=app-lang/tcl-9.1:0=
	xgui-lib/libX11
	truetype? (
		fonts/fontconfig
		xgui-lib/libXft
	)
"
RDEPEND="${DEPEND}"
BDEPEND="app-dev/pkgconf"

PATCHES=( "${FILESDIR}/tk-9.1-soname.patch" )

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	econf \
		--with-tcl="${ESYSROOT}/usr/lib" \
		--enable-64bit \
		--disable-rpath \
		$(use_enable truetype xft) \
		$(use_enable debug symbols)
}

src_install() {
	emake INSTALL_ROOT="${ED}" install install-private-headers
	dosym -r /usr/bin/wish9.1 /usr/bin/wish
}
