# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit meson git-r3 

DESCRIPTION="X.Org driver for Intel cards"

KEYWORDS="amd64 arm64 x86"
IUSE="debug dri3 +sna tools +udev uxa xvmc"
EGIT_REPO_URI="https://anongit.freedesktop.org/git/xorg/driver/xf86-video-intel.git"
SLOT=0

REQUIRED_USE="
	|| ( sna uxa )
"
RDEPEND="
	dev-util/valgrind
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXScrnSaver
	>=x11-libs/pixman-0.27.1
	>=x11-libs/libdrm-2.4.52[video_cards_intel]
	dri3? (
		>=x11-app/xorg-server-1.18
		!<=lib-media/mesa-12.0.4
	)
	sna? (
		>=x11-app/xorg-server-1.10
	)
	tools? (
		x11-libs/libX11
		x11-libs/libxcb
		x11-libs/libXcursor
		x11-libs/libXdamage
		x11-libs/libXinerama
		x11-libs/libXrandr
		x11-libs/libXrender
		x11-libs/libxshmfence
		x11-libs/libXtst
	)
	udev? (
		sys-app/systemd
	)
	xvmc? (
		x11-libs/libXvMC
		>=x11-libs/libxcb-1.5
		x11-libs/xcb-util
	)
"
DEPEND="${RDEPEND}
	x11/xorgproto"

src_configure() {
        local emesonargs=(
        		$(meson_use xvmc)
        )
        meson_src_configure
}
