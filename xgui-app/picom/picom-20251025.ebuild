# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson flag-o-matic

DESCRIPTION="A lightweight compositor for X11 (previously a compton fork)"
HOMEPAGE="https://github.com/yshui/picom.git"
SNAPSHOT=a8ef63dbc7543d2951c1a204732f1fe9189aa93c
SRC_URI="https://github.com/yshui/picom/archive/${SNAPSHOT}.tar.gz -> picom-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/picom-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="sanitize dbus regex opengl"

DEPEND="
	lib-dev/libconfig
	lib-dev/libev
	lib-dev/uthash
	lib-misc/libxdg-base
	xgui-lib/libdrm
	xgui-lib/xcb-util
	xgui-tools/xorgproto
	xgui-tools/xprop
	xgui-tools/xwininfo
	xmedia-lib/libepoxy
	dbus? ( app-core/dbus )
	opengl? ( xgui-tools/mesa )
"

src_configure() {
	filter-flags -Wl,-z,defs

	local emesonargs=(
		$(meson_use sanitize)
		$(meson_use regex)
		$(meson_use opengl)
		$(meson_use dbus)
		-Dcompton=false
	)
		meson_src_configure
}
