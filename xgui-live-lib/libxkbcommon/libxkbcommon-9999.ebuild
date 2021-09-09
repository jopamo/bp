# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson git-r3

DESCRIPTION="X.Org xkbcommon library"
HOMEPAGE="https://xkbcommon.org/"

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="https://github.com/xkbcommon/${PN}.git"
	inherit git-r3
else
	SRC_URI="https://xkbcommon.org/download/${P}.tar.xz"
fi

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="wayland X static-libs"

DEPEND="sys-devel/bison
	X? ( xgui-live-app/xorgproto )"
RDEPEND="X? ( xgui-live-lib/libxcb[xkb] )"

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
