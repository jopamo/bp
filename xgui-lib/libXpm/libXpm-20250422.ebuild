# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="X.Org Xpm library"
HOMEPAGE="https://www.x.org/wiki/"

SNAPSHOT=7ce39592bce4d57fa3cd07e4ee1aab3b47cd0436
SRC_URI="https://gitlab.freedesktop.org/xorg/lib/libXpm/-/archive/${SNAPSHOT}/libXpm-${SNAPSHOT}.tar.bz2 -> libXpm-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/libxpm-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

DEPEND="
	xgui-lib/libX11
	xgui-lib/libXext
	xgui-lib/libXt
"

src_prepare() {
	eautoreconf
	default
}

src_install() {
	default
	use static-libs || find "${ED}" -name '*.a' -delete
}
