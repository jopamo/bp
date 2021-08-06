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
	xgui-live-lib/cairo
	xgui-live-lib/libxkbcommon
	x11-live-lib/pango
	xgui-live-lib/pixman
	|| ( xgui-live-lib/wlroots xgui-live-lib/wlroots-eglstreams )
	x11-live-lib/gdk-pixbuf:2
	swaybg? ( xgui-live-app/swaybg )
	swayidle? ( xgui-live-app/swayidle )
	swaylock? ( xgui-live-app/swaylock )
	>=app-core/systemd-239
"
RDEPEND="
	x11-app/xkeyboard-config
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
