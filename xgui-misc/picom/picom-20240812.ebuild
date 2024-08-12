# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson flag-o-matic

DESCRIPTION="A lightweight compositor for X11 (previously a compton fork)"
HOMEPAGE="https://github.com/yshui/picom.git"

SNAPSHOT=f97776330c65192673ba8848889a9fed571ecf02
SRC_URI="https://github.com/yshui/picom/archive/${SNAPSHOT}.tar.gz -> picom-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/picom-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="sanitize dbus opengl +pcre"

COMMON_DEPEND="
	lib-dev/libconfig
	xgui-lib/libX11
	xgui-lib/libXcomposite
	xgui-lib/libXdamage
	xgui-lib/libXext
	xgui-lib/libXfixes
	xgui-lib/libXinerama
	xgui-lib/libXrandr
	xgui-lib/libXrender
	xgui-lib/xcb-util
	dbus? ( app-core/dbus )
	opengl? ( xgui-tools/mesa )
	pcre? ( lib-core/libpcre )
"

RDEPEND="${COMMON_DEPEND}
	xgui-tools/xprop
	xgui-tools/xwininfo"

DEPEND="${COMMON_DEPEND}
	app-dev/pkgconf
	xgui-tools/xorgproto
	lib-dev/libev
	lib-dev/uthash
	lib-misc/libxdg-base
	xgui-lib/libdrm"

filter-flags -Wl,-z,defs

src_configure() {
	local emesonargs=(
		$(meson_use sanitize)
		$(meson_use pcre regex)
		$(meson_use opengl)
		$(meson_use dbus)
	)
		meson_src_configure
}

src_install() {
	meson_src_install
	rm -rf "${ED}"/usr/share/icons
}
