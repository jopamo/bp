# Distributed under the terms of the GNU General Public License v2

inherit autotools qa-policy

DESCRIPTION="X.Org Xpresent library"
HOMEPAGE="https://www.x.org/wiki/"
SNAPSHOT=091d658c935e55d99d2705609837e5faeaf78f58
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

src_configure() {
	qa-policy-configure
	default
}

src_install() {
	default
	qa-policy-install
	use static-libs || find "${ED}" -name '*.a' -delete
}
