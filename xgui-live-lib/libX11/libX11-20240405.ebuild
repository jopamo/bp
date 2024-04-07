# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="X.Org X11 library"
HOMEPAGE="https://www.x.org/wiki/"

SNAPSHOT=52a191ee096e93cf711f77b6a56c508b68afc0b6
SRC_URI="https://gitlab.freedesktop.org/xorg/lib/libX11/-/archive/${SNAPSHOT}/libX11-${SNAPSHOT}.tar.bz2 -> libX11-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/libX11-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="ipv6 static-libs"

DEPEND="
	xgui-live-lib/libxcb
	xgui-live-lib/xtrans
	xgui-live-app/xorgproto
"

src_prepare() {
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

	rm "${ED}"/usr/include/X11/extensions/XKBgeom.h || die
}
