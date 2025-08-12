# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="X.Org Xft library"
HOMEPAGE="https://www.x.org/wiki/"
SNAPSHOT=5ba83f8ff76ae72a22d0a3a10e4159570e8c893d
SRC_URI="https://gitlab.freedesktop.org/xorg/lib/libXft/-/archive/${SNAPSHOT}/libXft-${SNAPSHOT}.tar.bz2 -> libXft-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/libxft-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	fonts/fontconfig
	xgui-lib/libX11
	xgui-lib/libXrender
"

IUSE="static-libs"

src_prepare() {
	default
	eautoreconf
}

src_install() {
	default
	use static-libs || find "${ED}" -name '*.a' -delete
}
