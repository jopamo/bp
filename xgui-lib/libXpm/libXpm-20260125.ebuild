# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools dot-a

DESCRIPTION="X.Org Xpm library"
HOMEPAGE="https://www.x.org/wiki/"
SNAPSHOT=5b7e903025a8e162a3ee97c64304b1c55211094e
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

src_configure() {
	use static-libs && lto-guarantee-fat
	default
}

src_install() {
	default
	use static-libs && strip-lto-bytecode
	use static-libs || find "${ED}" -name '*.a' -delete
}
