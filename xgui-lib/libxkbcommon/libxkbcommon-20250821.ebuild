# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="X.Org xkbcommon library"
HOMEPAGE="https://xkbcommon.org/"
SNAPSHOT=934d4fd8fff39e984eb998bb17b502699d1f958f
SRC_URI="https://github.com/xkbcommon/libxkbcommon/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/libxkbcommon-${SNAPSHOT}

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="wayland X static-libs"

DEPEND="app-build/bison
	X? ( xgui-tools/xorgproto )"
RDEPEND="X? ( xgui-lib/libxcb[xkb] )"

src_configure() {
	local emesonargs=(
		$(meson_use wayland enable-wayland)
		$(meson_use X enable-x11)
		-Denable-docs=false
		)
		meson_src_configure
}

src_install() {
	meson_src_install
	use static-libs || find "${ED}" -name '*.a' -delete
}
