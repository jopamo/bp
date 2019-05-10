# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit meson git-r3 flag-o-matic

EGIT_REPO_URI="https://gitlab.freedesktop.org/xorg/xserver.git"
EGIT_BRANCH="server-1.20-branch"
DESCRIPTION="X.Org X servers"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

IUSE="${IUSE_SERVERS} debug +glamor ipv6 minimal systemd +udev unwind wayland xcsecurity"

CDEPEND="
	lib-dev/openssl:0=
	>=x11/iceauth-1.0.2
	>=x11/rgb-1.0.3
	>=x11/xauth-1.0.3
	x11/xkbcomp
	>=x11-libs/libdrm-2.4.46
	>=x11-libs/libpciaccess-0.12.901
	>=x11-libs/libXau-1.0.4
	>=x11-libs/libXdmcp-1.0.2
	>=x11-libs/libXfont2-2.0.1
	>=x11-libs/libxkbfile-1.0.4
	>=x11-libs/libxshmfence-1.1
	>=x11-libs/pixman-0.27.2
	>=x11-libs/xtrans-1.3.5
	>=x11/xbitmaps-1.0.1
	>=x11/xkeyboard-config-2.4.1-r3
	glamor? (
		lib-media/libepoxy[X]
		lib-media/mesa
	)
	!minimal? (
		>=x11-libs/libX11-1.1.5
		>=x11-libs/libXext-1.0.5
		>=lib-media/mesa-10.3.4-r1
	)
	udev? ( >=sys-app/systemd-150 )
	unwind? ( lib-sys/libunwind )
	wayland? (
		>=lib-dev/wayland-1.3.0
		lib-media/libepoxy
		>=lib-dev/wayland-protocols-1.1
	)
	>=x11/xinit-1.3.3-r1
	systemd? (
		sys-app/dbus
		sys-app/systemd
	)"

DEPEND="${CDEPEND}
	sys-devel/flex
	x11/xorgproto
"

PDEPEND="x11/xf86-input-libinput"

filter-flags -flto -Wl,-z,defs -Wl,-z,relro

src_configure() {
        local emesonargs=(
        		$(meson_use glamor)
        		$(meson_use ipv6)
        )
        meson_src_configure
}
