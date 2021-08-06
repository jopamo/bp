# Distributed under the terms of the GNU General Public License v2

EAPI=7

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
	>=x11-app/iceauth-1.0.2
	>=x11-app/rgb-1.0.3
	>=x11-app/xauth-1.0.3
	x11-app/xkbcomp
	>=xgui-live-lib/libdrm-2.4.46
	x11-live-lib/libpciaccess
	>=x11-live-lib/libXau-1.0.4
	>=x11-live-lib/libXdmcp-1.0.2
	>=x11-live-lib/libXfont2-2.0.1
	>=x11-live-lib/libxkbfile-1.0.4
	>=x11-live-lib/libxshmfence-1.1
	>=xgui-live-lib/pixman-0.27.2
	>=x11-live-lib/xtrans-1.3.5
	>=x11-live-misc/xbitmaps-1.0.1
	>=x11-app/xkeyboard-config-2.4.1-r3
	glamor? (
		xmedia-live-lib/libepoxy[X]
		xmedia-live-lib/mesa
	)
	!minimal? (
		>=x11-live-lib/libX11-1.1.5
		>=x11-live-lib/libXext-1.0.5
		>=xmedia-live-lib/mesa-10.3.4-r1
	)
	udev? ( >=sys-app/systemd-150 )
	wayland? (
		>=lib-dev/wayland-1.3.0
		xmedia-live-lib/libepoxy
		>=lib-dev/wayland-protocols-1.1
		xgui-live-lib/egl-wayland
	)
	>=x11-app/xinit-1.3.3-r1
	systemd? (
		sys-app/dbus
		sys-app/systemd
	)"

DEPEND="${CDEPEND}
	sys-devel/flex
	x11-live-misc/xorgproto
"

PDEPEND="x11-live-misc/xf86-input-libinput"

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
		-Dos_vendor="1g4 Linux"
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
