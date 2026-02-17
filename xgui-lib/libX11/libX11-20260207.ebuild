# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools flag-o-matic dot-a

DESCRIPTION="X.Org X11 library"
HOMEPAGE="https://www.x.org/wiki/"
SNAPSHOT=6c75545a1deb51f5903992c52af6bc35cc9bc103
SRC_URI="https://gitlab.freedesktop.org/xorg/lib/libX11/-/archive/${SNAPSHOT}/libX11-${SNAPSHOT}.tar.bz2 -> libX11-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/libx11-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="ipv6 static-libs"

DEPEND="
	xgui-lib/libxcb
	xgui-lib/xtrans
	xgui-tools/xorgproto
"

src_prepare() {
	use static-libs && lto-guarantee-fat

	filter-flags -Wl,-z,defs

	default
	eautoreconf

	# currently failing
	sed -i "s/\ \-Werror\=array\-bounds//g" configure
}

src_configure() {
	local myconf=(
		$(use_enable ipv6)
		$(use_enable static-libs static)
		--disable-specs
		--disable-xf86bigfont
		--without-fop
		--without-xmlto
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_install() {
	default
	use static-libs && strip-lto-bytecode

	rm "${ED}"/usr/include/X11/extensions/XKBgeom.h || die
}
