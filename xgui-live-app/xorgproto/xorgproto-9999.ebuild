# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 meson

DESCRIPTION="X.Org combined protocol headers"
HOMEPAGE="https://www.x.org"
EGIT_REPO_URI="https://gitlab.freedesktop.org/xorg/proto/xorgproto.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="lib-core/libxml2"

src_install() {
	meson_src_install

	insinto usr/include/X11/extensions
	doins include/X11/extensions/XKBgeom.h
}
