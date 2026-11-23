# Distributed under the terms of the GNU General Public License v2

inherit autotools qa-policy

DESCRIPTION="X.Org Xft library"
HOMEPAGE="https://www.x.org/wiki/"
SNAPSHOT=dd919aa3b1f8705465a3d4cfb34085ec3af160ef
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
	qa-policy-configure
	default
}

src_install() {
	default
	qa-policy-install
	use static-libs || find "${ED}" -name '*.a' -delete
}
