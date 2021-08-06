# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="Tool which allows you to compose wallpapers ('root pixmaps') for X"
EGIT_REPO_URI="https://github.com/himdel/hsetroot.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	lib-media/imlib2[X]
	x11-live-lib/libX11
	x11-live-misc/xorgproto
"

src_install() {
	dobin ${PN}
}
