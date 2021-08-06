# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson git-r3 flag-o-matic xdg-utils

DESCRIPTION="A lightweight compositor for X11 (previously a compton fork)"
HOMEPAGE="https://github.com/yshui/picom.git"
EGIT_REPO_URI="https://github.com/yshui/picom.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="sanitize dbus opengl +pcre +xinerama"

COMMON_DEPEND="
	lib-dev/libconfig:=
	x11-live-libs/libX11
	x11-live-libs/libXcomposite
	x11-live-libs/libXdamage
	x11-live-libs/libXext
	x11-live-libs/libXfixes
	x11-live-libs/libXrandr
	x11-live-libs/libXrender
	x11-live-libs/xcb-util
	dbus? ( sys-app/dbus )
	opengl? ( lib-media/mesa )
	pcre? ( lib-dev/libpcre:3 )
	xinerama? ( x11-live-libs/libXinerama )"

RDEPEND="${COMMON_DEPEND}
	x11-app/xprop
	x11-app/xwininfo"

DEPEND="${COMMON_DEPEND}
	dev-util/pkgconf
	x11-live-misc/xorgproto
	lib-dev/libev
	lib-dev/uthash
	lib-dev/libxdg-base
	lib-gui/libdrm"

append-cppflags -I/usr/include/xcb
filter-flags -Wl,-z,defs

src_configure() {
	local emesonargs=(
		$(meson_use sanitize)
		$(meson_use xinerama)
		$(meson_use pcre regex)
		$(meson_use opengl)
		$(meson_use dbus)
	)
		meson_src_configure
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
