# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson flag-o-matic

DESCRIPTION="implementation of the X Window System display server"
HOMEPAGE="https://www.x.org/wiki/"
EGIT_BRANCH="xwayland-$(ver_cut 1-2)"

SNAPSHOT=
SRC_URI="https://gitlab.freedesktop.org/xorg/xserver/-/archive/${SNAPSHOT}/xserver-${SNAPSHOT}.tar.bz2 -> ${P}.tar.bz2"
S="${WORKDIR}/xorg-xserver-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
#KEYWORDS="amd64 arm64"

IUSE="+glamor ipv6 minimal systemd suid_wrapper +udev wayland xcsecurity X"

DEPEND="
	virtual/ssl
	xgui-misc/iceauth
	xgui-lib/rgb
	xgui-tools/xauth
	xgui-lib/xbitmaps
	xgui-tools/xinit
	xgui-lib/libXau
	xgui-lib/libXdmcp
	xgui-lib/libXfont2
	xgui-lib/libdrm
	xgui-lib/libpciaccess
	xgui-lib/libxcvt
	xgui-lib/libxkbfile
	xgui-lib/libxshmfence
	xgui-lib/pixman
	xgui-lib/xtrans
	xgui-misc/xkbcomp
	xgui-misc/xkeyboard-config
	glamor? (
		xmedia-lib/libepoxy
		xgui-tools/mesa
	)
	!minimal? (
		xgui-lib/libX11
		xgui-lib/libXext
		xgui-tools/mesa
	)
	udev? ( app-core/systemd )
	systemd? (
		app-core/dbus
		app-core/systemd
	)"
BDEPEND="
	app-build/flex
	xgui-tools/xorgproto
"

PDEPEND="xgui-misc/xf86-input-libinput"

filter-flags -Wl,-z,defs -Wl,-z,now

src_configure() {
        local emesonargs=(
		$(meson_use glamor)
		$(meson_use ipv6)
		$(meson_use xcsecurity)
		-Ddri3=true
        )
        meson_src_configure
}
