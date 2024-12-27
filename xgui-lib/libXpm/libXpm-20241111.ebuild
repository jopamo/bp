# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="X.Org Xpm library"
HOMEPAGE="https://www.x.org/wiki/"

SNAPSHOT=b7309b497b592beb23c841b6ccad324a3d3cc2d4
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
