# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="X11 server performance test program"
HOMEPAGE="https://gitlab.freedesktop.org/xorg/app/x11perf"
SNAPSHOT=0c3597b6ecd43008092db8472779ab2d7aa111fe
SRC_URI="https://gitlab.freedesktop.org/xorg/test/x11perf/-/archive//${SNAPSHOT}/x11perf-/${SNAPSHOT}.tar.bz2"
S=${WORKDIR}/${PN}-${SNAPSHOT}

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
