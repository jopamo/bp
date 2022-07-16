# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="Tool which allows you to compose wallpapers ('root pixmaps') for X"
EGIT_REPO_URI="https://github.com/himdel/hsetroot.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	xgui-misc/imlib2[X]
	xgui-live-lib/libX11
	xgui-live-app/xorgproto
"

src_install() {
	dobin ${PN}
}
