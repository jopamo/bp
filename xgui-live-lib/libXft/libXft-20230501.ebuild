# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="X.Org Xft library"
HOMEPAGE="https://www.x.org/wiki/"

SNAPSHOT=4e4210c86019b42c3819cc18b59f86752fcd8b13
SRC_URI="https://gitlab.freedesktop.org/xorg/lib/libXft/-/archive/${SNAPSHOT}/libXft-${SNAPSHOT}.tar.bz2 -> libXft-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/libXft-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

DEPEND="
	xgui-live-lib/libXrender
	xgui-misc/freetype
	fonts/fontconfig
	xgui-live-app/xorgproto
	fonts/liberation-fonts"

src_prepare() {
	default
	eautoreconf
}

src_install() {
	default
	use static-libs || find "${ED}" -name '*.a' -delete
}
