# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 autotools

DESCRIPTION="X.Org Xpresent library"
EGIT_REPO_URI="https://gitlab.freedesktop.org/xorg/lib/${PN}.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

src_prepare() {
	default
	eautoreconf
}

src_install() {
	default
	use static-libs || find "${ED}" -name '*.a' -delete
}
