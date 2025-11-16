# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="Keymap handling library for Wayland and X11 (xkbcommon)"
HOMEPAGE="https://xkbcommon.org/"
SNAPSHOT=42c4490cc9473f675820e71aa72e8f5d10a0b393
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
