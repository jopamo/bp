# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson flag-o-matic

DESCRIPTION="implementation of the X Window System display server"
HOMEPAGE="https://www.x.org/wiki/"

if [[ ${PV} == *9999* ]]; then
	EGIT_REPO_URI="https://gitlab.freedesktop.org/xorg/xserver.git"
	EGIT_BRANCH="server-$(ver_cut 1).$(ver_cut 2)-branch"
	inherit git-r3
else
	SNAPSHOT=
	SRC_URI="https://github.com/freedesktop/xorg-xserver/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
	S=${WORKDIR}/xorg-xserver-${SNAPSHOT}
fi

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="debug +glamor ipv6 minimal systemd suid_wrapper +udev
	wayland xcsecurity X"

DEPEND="
	virtual/ssl
	xgui-live-app/iceauth
	xgui-live-app/rgb
	xgui-live-app/xauth
	xgui-live-app/xbitmaps
	xgui-live-app/xinit
	xgui-live-lib/libXau
	xgui-live-lib/libXdmcp
	xgui-live-lib/libXfont2
	xgui-live-lib/libdrm
	xgui-live-lib/libpciaccess
	xgui-live-lib/libxkbfile
	xgui-live-lib/libxshmfence
	xgui-live-lib/pixman
	xgui-live-lib/xtrans
	xgui-misc/xkbcomp
	xgui-misc/xkeyboard-config
	glamor? (
		xmedia-live-lib/libepoxy
		xmedia-live-lib/mesa
	)
	!minimal? (
		xgui-live-lib/libX11
		xgui-live-lib/libXext
		xmedia-live-lib/mesa
	)
	udev? ( app-core/systemd )
	systemd? (
		app-core/dbus
		app-core/systemd
	)"
BDEPEND="
	app-build/flex
	xgui-live-app/xorgproto
"

PDEPEND="xgui-live-app/xf86-input-libinput"

filter-flags -Wl,-z,defs -Wl,-z,now

src_configure() {
        local emesonargs=(
		$(meson_use glamor)
		$(meson_use ipv6)
		$(meson_use udev)
		$(meson_use systemd systemd_logind)
		$(meson_use wayland xwayland)
		$(meson_use wayland xwayland_eglstream)
		$(meson_use xcsecurity)
		$(meson_use suid_wrapper)
		$(meson_use X xorg)
		-Ddri1=false
		-Ddri2=false
		-Ddri3=false
        )
        meson_src_configure
}

src_install() {
	meson_src_install
	dosym Xorg usr/bin/X
}
