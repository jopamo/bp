# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="X.Org Xpm library"
HOMEPAGE="https://www.x.org/wiki/"
SNAPSHOT=10070a4e998c1a223dec437847c38dc27dbe85d4
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
