# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson flag-o-matic

DESCRIPTION="A lightweight compositor for X11 (previously a compton fork)"
HOMEPAGE="https://github.com/yshui/picom.git"

SNAPSHOT=d8c34ed4f753f75280d262d7126cb573dcee6663
SRC_URI="https://github.com/yshui/picom/archive/${SNAPSHOT}.tar.gz -> picom-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/picom-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="sanitize dbus opengl +pcre"

COMMON_DEPEND="
	lib-live/libconfig
	xgui-live-lib/libX11
	xgui-live-lib/libXcomposite
	xgui-live-lib/libXdamage
	xgui-live-lib/libXext
	xgui-live-lib/libXfixes
	xgui-live-lib/libXinerama
	xgui-live-lib/libXrandr
	xgui-live-lib/libXrender
	xgui-live-lib/xcb-util
	dbus? ( app-core/dbus )
	opengl? ( xgui-misc/mesa )
	pcre? ( lib-core/libpcre )
"

RDEPEND="${COMMON_DEPEND}
	xgui-live-app/xprop
	xgui-live-app/xwininfo"

DEPEND="${COMMON_DEPEND}
	app-dev/pkgconf
	xgui-live-app/xorgproto
	lib-dev/libev
	lib-live/uthash
	lib-live/libxdg-base
	xgui-live-lib/libdrm"

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
