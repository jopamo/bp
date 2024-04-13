# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="X.Org Xcomposite library"
HOMEPAGE="https://www.x.org/wiki/"

SNAPSHOT=af3df13591f172aa4b0e74101574ca29ff879ba6
SRC_URI="https://gitlab.freedesktop.org/xorg/lib/libXcomposite/-/archive/${SNAPSHOT}/libXcomposite-${SNAPSHOT}.tar.bz2 -> libXcomposite-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/libxcomposite-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

DEPEND="
	xgui-lib/libX11
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
