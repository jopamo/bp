# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson xdg-utils git-r3

DESCRIPTION="Enlightenment window manager"
HOMEPAGE="https://www.enlightenment.org"
EGIT_REPO_URI="https://git.enlightenment.org/core/${PN}.git"

LICENSE="BSD-2"
SLOT="0/1"
KEYWORDS="amd64 arm64"

IUSE="bluetooth connman doc geolocation nls packagekit pam systemd udisks wayland wifi xwayland"

REQUIRED_USE="xwayland? ( wayland )"

RDEPEND="
	>=lib-dev/efl-1.20.5[eet,X]
	sys-app/systemd
	x11-libs/libXext
	x11-libs/libxcb
	x11-libs/xcb-util-keysyms
	x11-misc/xkeyboard-config
	bluetooth? ( app-net/bluez )
	connman? ( lib-dev/efl[connman] )
	geolocation? ( app-misc/geoclue:2.0 )
	packagekit? ( sys-app/packagekit-base )
	pam? ( lib-sys/pam )
	systemd? ( sys-app/systemd )
	udisks? ( sys-fs/udisks:2 )
	wayland? (
		>=lib-dev/efl-1.22.0[drm,wayland]
		lib-dev/wayland
		x11-libs/libxkbcommon
		x11-libs/pixman
	)
	xwayland? (
		lib-dev/efl[X,wayland]
		x11-misc/xorg-server[wayland]
	)
"
BDEPEND="
	dev-util/pkgconf
	nls? ( sys-devel/gettext )
"
DEPEND="${RDEPEND}"

src_configure() {
	local emesonargs=(
		-D device-udev=true
		-D install-sysactions=false

		$(meson_use udisks mount-udisks)
		$(meson_use bluetooth bluez4)
		$(meson_use connman)
		$(meson_use geolocation)
		$(meson_use nls)
		$(meson_use packagekit)
		$(meson_use pam)
		$(meson_use systemd)
		$(meson_use wayland)
		$(meson_use wifi wireless)
		$(meson_use xwayland)
	)

	if ! use wayland; then
		emesonargs+=(
			-D wl-buffer=false
			-D wl-desktop-shell=false
			-D wl-drm=false
			-D wl-text-input=false
			-D wl-weekeyboard=false
			-D wl-wl=false
			-D wl-x11=false
		)
	fi

	meson_src_configure
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}
