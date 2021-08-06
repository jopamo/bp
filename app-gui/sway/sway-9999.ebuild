# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 meson

DESCRIPTION="i3-compatible Wayland window manager"
HOMEPAGE="https://swaywm.org"
EGIT_REPO_URI="https://github.com/swaywm/${PN}.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="+swaybg +swayidle +swaylock +tray +wallpapers"

DEPEND="
	>=lib-dev/json-c-0.13:0=
	>=lib-dev/libinput-1.6.0:0=
	lib-dev/libpcre
	lib-dev/wayland
	lib-gui/cairo
	lib-gui/libxkbcommon
	x11-libs/pango
	lib-gui/pixman
	|| ( lib-gui/wlroots lib-gui/wlroots-eglstreams )
	x11-libs/gdk-pixbuf:2
	swaybg? ( app-gui/swaybg )
	swayidle? ( app-gui/swayidle )
	swaylock? ( app-gui/swaylock )
	>=sys-app/systemd-239
"
RDEPEND="
	x11-misc/xkeyboard-config
	${DEPEND}
"
BDEPEND="
	lib-dev/wayland-protocols
	dev-util/pkgconf
"

src_configure() {
	local emesonargs=(
		-Dman-pages=disabled
		-Dtray=$(usex tray enabled disabled)
		-Dxwayland=disabled
		$(meson_use wallpapers default-wallpaper)
		-Dfish-completion=false
		-Dzsh-completion=false
		"-Dbash-completions=false"
		"-Dwerror=false"
		-Dgdk-pixbuf=enabled
	)

	meson_src_configure
}
