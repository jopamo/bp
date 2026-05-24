# Distributed under the terms of the GNU General Public License v2

inherit autotools

DESCRIPTION="sample X compositing manager"
HOMEPAGE="https://gitlab.freedesktop.org/xorg/app/xcompmgr"
SNAPSHOT=bfb36c8d4f75d3af8a094dbd9786df20b2045d5f
SRC_URI="https://gitlab.freedesktop.org/xorg/app/xcompmgr/-/archive/${SNAPSHOT}/xcompmgr-${SNAPSHOT}.tar.bz2"
S=${WORKDIR}/xcompmgr-${SNAPSHOT}

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
	xgui-lib/libX11
	xgui-lib/libXmu
"
DEPEND="
	${RDEPEND}
	xgui-tools/xorgproto
	xgui-lib/libXt
"

src_prepare() {
	default
	eautoreconf
}
