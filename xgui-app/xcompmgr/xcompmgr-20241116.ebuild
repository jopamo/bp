# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="sample X compositing manager"
HOMEPAGE="https://gitlab.freedesktop.org/xorg/app/xcompmgr"

SNAPSHOT=56da505d9c464fb2fb139c28c40d0001f240cf24
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
