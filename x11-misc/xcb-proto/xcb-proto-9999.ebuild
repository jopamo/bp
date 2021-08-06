# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 autotools

DESCRIPTION="X C-language Bindings protocol headers"
HOMEPAGE="https://xcb.freedesktop.org/"
EGIT_REPO_URI="https://gitlab.freedesktop.org/xorg/proto/xcbproto.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="${RDEPEND}
	lib-core/libxml2"

src_prepare() {
	default
	eautoreconf
}
