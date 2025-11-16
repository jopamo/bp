# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="i3-compatible Wayland window manager"
HOMEPAGE="https://swaywm.org"
SNAPSHOT=d735bb99a9e97619e633257ea001b42e2bfe95a5
SRC_URI="https://github.com/swaywm/sway/archive/${SNAPSHOT}.tar.gz -> sway-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/sway-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="swaybg swayidle swaylock tray wallpapers"

DEPEND="
	lib-core/libpcre
	lib-dev/json-c
	lib-util/libinput
	xgui-lib/cairo
	xgui-lib/gdk-pixbuf
	xgui-lib/libxkbcommon
	xgui-lib/pango
	xgui-lib/pixman
	xgui-lib/wayland
	xgui-lib/wlroots
	swaybg? ( xgui-app/swaybg )
	swayidle? ( xgui-app/swayidle )
	swaylock? ( xgui-app/swaylock )
"
RDEPEND="xgui-misc/xkeyboard-config"
BDEPEND="
	xgui-lib/wayland-protocols
	app-dev/pkgconf
"

src_configure() {
	local emesonargs=(
		-Dbash-completions=false
		-Dgdk-pixbuf=enabled
		-Dman-pages=disabled
		-Dwerror=false
		-Dxwayland=enabled
		$(meson_use wallpapers default-wallpaper)
		-Dtray=$(usex tray enabled disabled)
	)

	meson_src_configure
}
