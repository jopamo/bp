# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="X.Org xkbfile library"
HOMEPAGE="https://www.x.org/wiki/"

SNAPSHOT=f6592c6f272587456f69aef6e1db6a1aef5731ca
SRC_URI="https://gitlab.freedesktop.org/xorg/lib/libxkbfile/-/archive/${SNAPSHOT}/libxkbfile-${SNAPSHOT}.tar.bz2 -> libxkbfile-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/libxkbfile-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

DEPEND="
	xgui-lib/libX11
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
