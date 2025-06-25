# Distributed under the terms of the GNU General Public License v2

EAPI=8

BRANCH_NAME="xwayland-$(ver_cut 1-2)"

inherit meson flag-o-matic

DESCRIPTION="implementation of the X Window System display server"
HOMEPAGE="https://www.x.org/wiki/"
SNAPSHOT=34ef671aa5ae0df3a499ae0852e1ffbfe7086888
SRC_URI="https://gitlab.freedesktop.org/xorg/xserver/-/archive/${SNAPSHOT}/xserver-${SNAPSHOT}.tar.bz2 -> ${PN}-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/xserver-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

IUSE="glamor ipv6 xcsecurity"

DEPEND="
	virtual/ssl
	xgui-lib/libX11
	xgui-lib/libXau
	xgui-lib/libXdmcp
	xgui-lib/libXext
	xgui-lib/libXfont2
	xgui-lib/libdrm
	xgui-lib/libpciaccess
	xgui-lib/libxcvt
	xgui-lib/libxkbfile
	xgui-lib/libxshmfence
	xgui-lib/pixman
	xgui-lib/rgb
	xgui-lib/xbitmaps
	xgui-lib/xtrans
	xgui-misc/iceauth
	xgui-misc/xkbcomp
	xgui-misc/xkeyboard-config
	xgui-tools/mesa
	xgui-tools/xauth
	xgui-tools/xinit
	glamor? (
		xmedia-lib/libepoxy
		xgui-tools/mesa
	)
"
BDEPEND="
	app-build/flex
	xgui-tools/xorgproto
"

PDEPEND="xgui-misc/xf86-input-libinput"

src_configure() {
	filter-flags -Wl,-z,defs -Wl,-z,now

	local emesonargs=(
		$(meson_use glamor)
		$(meson_use ipv6)
		$(meson_use xcsecurity)
		-Ddri3=false
	)
	meson_src_configure
}

src_install() {
	meson_src_install
	dosym Xorg usr/bin/X
}
