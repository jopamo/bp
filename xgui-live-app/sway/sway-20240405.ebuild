# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="i3-compatible Wayland window manager"
HOMEPAGE="https://swaywm.org"

SNAPSHOT=bc258a3be2f946c1c93bcbe40735b2db068e0ea8
SRC_URI="https://github.com/swaywm/sway/archive/${SNAPSHOT}.tar.gz -> sway-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/sway-${SNAPSHOT}"

if [[ ${PV} == *9999 ]]; then
	EGIT_REPO_URI="https://github.com/swaywm/sway"
	inherit
else
	SRC_URI="https://github.com/swaywm/${PN}/releases/download/${PV}/${P}.tar.gz"
fi

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="+swaybg +swayidle +swaylock +tray +wallpapers"

DEPEND="
	lib-core/libpcre
	lib-live/json-c
	lib-live/libinput
	xgui-live-lib/cairo
	xgui-live-lib/gdk-pixbuf
	xgui-live-lib/libxkbcommon
	xgui-live-lib/pango
	xgui-live-lib/pixman
	xgui-live-lib/wayland
	xgui-live-lib/wlroots
	swaybg? ( xgui-live-app/swaybg )
	swayidle? ( xgui-live-app/swayidle )
	swaylock? ( xgui-live-app/swaylock )
"
RDEPEND="xgui-misc/xkeyboard-config"
BDEPEND="
	xgui-live-lib/wayland-protocols
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
