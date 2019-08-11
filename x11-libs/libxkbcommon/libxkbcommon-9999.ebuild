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
SLOT="0/1"
KEYWORDS="amd64 arm64"

IUSE="wayland X doc test static-libs"

DEPEND="sys-devel/bison
	X? ( x11-misc/xorgproto )
	doc? ( app-text/doxygen )"
RDEPEND="X? ( >=x11-libs/libxcb-1.10[xkb] )"

src_configure() {
	local emesonargs=(
		$(meson_use wayland enable-wayland)
		$(meson_use X enable-x11)
		-Denable-docs=false
		)
		meson_src_configure
}
