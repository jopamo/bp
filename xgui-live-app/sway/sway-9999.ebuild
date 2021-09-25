# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 meson

DESCRIPTION="i3-compatible Wayland window manager"
HOMEPAGE="https://swaywm.org"
EGIT_REPO_URI="https://github.com/swaywm/${PN}.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="+swaybg +swayidle +swaylock +tray +wallpapers"

DEPEND="
	lib-live/json-c
	lib-live/libinput
	lib-core/libpcre
	xgui-live-lib/wayland
	xgui-live-lib/cairo
	xgui-live-lib/libxkbcommon
	xgui-live-lib/pango
	xgui-live-lib/pixman
	|| ( xgui-live-lib/wlroots xgui-live-lib/wlroots-eglstreams )
	xgui-live-lib/gdk-pixbuf:2
	swaybg? ( xgui-live-app/swaybg )
	swayidle? ( xgui-live-app/swayidle )
	swaylock? ( xgui-live-app/swaylock )
	>=app-core/systemd-239
"
RDEPEND="
	xgui-misc/xkeyboard-config
	${DEPEND}
"
BDEPEND="
	xgui-live-lib/wayland-protocols
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
