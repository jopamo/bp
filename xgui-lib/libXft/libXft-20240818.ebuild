# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="X.Org Xft library"
HOMEPAGE="https://www.x.org/wiki/"

SNAPSHOT=e787bf2f9e3a9eafc36eb668d060f8fed1283a44
SRC_URI="https://gitlab.freedesktop.org/xorg/lib/libXft/-/archive/${SNAPSHOT}/libXft-${SNAPSHOT}.tar.bz2 -> libXft-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/libxft-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	xgui-lib/libXrender
	xgui-lib/libX11
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
