# Distributed under the terms of the GNU General Public License v2

inherit meson qa-policy

DESCRIPTION="Keymap handling library for Wayland and X11 (xkbcommon)"
HOMEPAGE="https://xkbcommon.org/"
SNAPSHOT=6e4f0fb9e7ee876f14aad07dda4d69a622c58a3b
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
	qa-policy-configure
	local emesonargs=(
		$(meson_use wayland enable-wayland)
		$(meson_use X enable-x11)
		-Denable-docs=false
		-Denable-tools=false
		-Denable-xkbregistry=false
		)
		meson_src_configure
}

src_install() {
	meson_src_install
	qa-policy-install
	use static-libs || find "${ED}" -name '*.a' -delete
}
