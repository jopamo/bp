# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="X.Org Xpresent library"
HOMEPAGE="https://www.x.org/wiki/"

SNAPSHOT=a155b75589c5fdf173069dc8c21f70d46178578e
SRC_URI="https://gitlab.freedesktop.org/xorg/lib/libXpresent/-/archive/${SNAPSHOT}/libXpresent-${SNAPSHOT}.tar.bz2 -> libXpresent-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/libxpresent-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

BDEPEND="xgui-tools/util-macros"
DEPEND="
	xgui-lib/libX11
	xgui-lib/libXext
	xgui-lib/libXrandr
	xgui-lib/libXfixes
	xgui-tools/xorgproto
"

src_prepare() {
	default
	eautoreconf
}

src_install() {
	default
	use static-libs || find "${ED}" -name '*.a' -delete
}
