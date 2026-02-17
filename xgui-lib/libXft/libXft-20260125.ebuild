# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools dot-a

DESCRIPTION="X.Org Xft library"
HOMEPAGE="https://www.x.org/wiki/"
SNAPSHOT=6b333a36e41b81b98961de1d10af9a627d28841e
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

src_configure() {
	use static-libs && lto-guarantee-fat
	default
}

src_install() {
	default
	use static-libs && strip-lto-bytecode
	use static-libs || find "${ED}" -name '*.a' -delete
}
