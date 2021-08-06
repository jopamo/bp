# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 autotools

DESCRIPTION="X.Org Xpm library"
EGIT_REPO_URI="https://gitlab.freedesktop.org/xorg/lib/${PN}.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

DEPEND="
	x11-live-libs/libX11
	x11-live-libs/libXext
	x11-live-libs/libXt
"

src_prepare() {
	eautoreconf
	default
}

src_install() {
	default
	use static-libs || find "${ED}" -name '*.a' -delete
}
