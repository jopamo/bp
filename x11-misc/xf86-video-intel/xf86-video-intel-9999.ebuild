# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson git-r3

DESCRIPTION="X.Org driver for Intel cards"
HOMEPAGE="https://www.x.org"
EGIT_REPO_URI="https://gitlab.freedesktop.org/xorg/driver/xf86-video-intel.git"

LICENSE="MIT"
SLOT="0/1"
KEYWORDS="amd64 arm64"

IUSE="+sna +uxa +xaa +ums +kms +dri1 +dri2 +dri3 +present xvmc valgrind +tools backlight backlight-helper +tearfree use-create2 async-swap"

RDEPEND="
	dev-util/valgrind
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXScrnSaver
	>=lib-gui/pixman-0.27.1
	>=lib-gui/libdrm-2.4.52[video_cards_intel]
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
	xvmc? (
		x11-libs/libXvMC
		>=x11-libs/libxcb-1.5
		x11-libs/xcb-util
	)
"
DEPEND="${RDEPEND}
	x11-misc/xorgproto"

src_configure() {
        local emesonargs=(
        		$(meson_use sna)
				$(meson_use uxa)
				$(meson_use xaa)
				$(meson_use ums)
				$(meson_use kms)
				$(meson_use dri1)
				$(meson_use dri2)
				$(meson_use dri3)
				$(meson_use present)
				$(meson_use xvmc)
				$(meson_use valgrind)
				$(meson_use tools)
				$(meson_use backlight)
				$(meson_use backlight-helper)
				$(meson_use tearfree)
				$(meson_use use-create2)
				$(meson_use async-swap)
				-Ddefault-dri=3
				-Ddefault-accel=sna
        )
        meson_src_configure
}
