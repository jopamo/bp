# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson flag-o-matic

DESCRIPTION="A lightweight compositor for X11 (previously a compton fork)"
HOMEPAGE="https://github.com/yshui/picom.git"

SNAPSHOT=38d2c4a4ed263e10e868a1f86efc89fab6a36a30
SRC_URI="https://github.com/yshui/picom/archive/${SNAPSHOT}.tar.gz -> picom-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/picom-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="sanitize dbus +regex opengl"

DEPEND="
	dbus? ( app-core/dbus )
	lib-dev/libconfig
	lib-dev/libev
	lib-dev/uthash
	lib-misc/libxdg-base
	opengl? ( xgui-tools/mesa )
	xgui-lib/libdrm
	xgui-lib/xcb-util
	xgui-tools/xorgproto
	xgui-tools/xprop
	xgui-tools/xwininfo
	xmedia-lib/libepoxy
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

src_install() {
	meson_src_install
	rm -rf "${ED}"/usr/share/icons
}
