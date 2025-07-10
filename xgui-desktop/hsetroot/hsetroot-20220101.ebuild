# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Tool which allows you to compose wallpapers ('root pixmaps') for X"
HOMEPAGE="https://www.x.org/wiki/"

SNAPSHOT=a402d5323f45c058810c0d66d61d278d101d3610
SRC_URI="https://github.com/himdel/hsetroot/archive/${SNAPSHOT}.tar.gz -> hsetroot-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/hsetroot-${SNAPSHOT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	xgui-lib/imlib2[X]
	xgui-lib/libX11
	xgui-tools/xorgproto
"

src_install() {
	dobin hsetroot
}
