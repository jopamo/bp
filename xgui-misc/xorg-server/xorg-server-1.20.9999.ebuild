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

CDEPEND="
	virtual/ssl
	>=xgui-live-app/iceauth-1.0.2
	>=xgui-live-app/rgb-1.0.3
	>=xgui-live-app/xauth-1.0.3
	xgui-misc/xkbcomp
	>=xgui-live-lib/libdrm-2.4.46
	xgui-live-lib/libpciaccess
	>=xgui-live-lib/libXau-1.0.4
	>=xgui-live-lib/libXdmcp-1.0.2
	>=xgui-live-lib/libXfont2-2.0.1
	>=xgui-live-lib/libxkbfile-1.0.4
	>=xgui-live-lib/libxshmfence-1.1
	>=xgui-live-lib/pixman-0.27.2
	>=xgui-live-lib/xtrans-1.3.5
	>=xgui-live-app/xbitmaps-1.0.1
	xgui-misc/xkeyboard-config
	glamor? (
		xmedia-live-lib/libepoxy
		xmedia-live-lib/mesa
	)
	!minimal? (
		>=xgui-live-lib/libX11-1.1.5
		>=xgui-live-lib/libXext-1.0.5
		>=xmedia-live-lib/mesa-10.3.4-r1
	)
	udev? ( >=app-core/systemd-150 )
	wayland? (
		>=xgui-live-lib/wayland-1.3.0
		xmedia-live-lib/libepoxy
		>=xgui-live-lib/wayland-protocols-1.1
		xgui-live-lib/egl-wayland
	)
	>=xgui-live-app/xinit-1.3.3-r1
	systemd? (
		app-core/dbus
		app-core/systemd
	)"

DEPEND="${CDEPEND}
	sys-devel/flex
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
