# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson git-r3

DESCRIPTION="The OpenGL Utility Library"
HOMEPAGE="https://cgit.freedesktop.org/mesa/glu/"
EGIT_REPO_URI="https://gitlab.freedesktop.org/mesa/glu.git"

LICENSE="SGI-B-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

DEPEND="xmedia-live-lib/mesa"

src_install() {
	meson_src_install
	use static-libs || find "${ED}" -name '*.a' -delete
}
