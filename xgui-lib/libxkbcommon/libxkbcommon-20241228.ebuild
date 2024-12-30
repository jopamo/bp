# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="X.Org xkbcommon library"
HOMEPAGE="https://xkbcommon.org/"

SNAPSHOT=bf03b4b5a46e3bfef7c567f227e5f8c2077e9d0b
SRC_URI="https://github.com/xkbcommon/libxkbcommon/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/${PN}-${SNAPSHOT}

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
