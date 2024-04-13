# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="A modular Wayland compositor library"
HOMEPAGE="https://github.com/swaywm/wlroots"

SNAPSHOT="b1b34cd6653d51f3bf8e331e6ae7b39290ae820e"
SRC_URI="https://gitlab.freedesktop.org/wlroots/wlroots/-/archive/${SNAPSHOT}/wlroots-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/wlroots-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	app-core/systemd[logind]
	app-live/seatd
	lib-core/libcap
	lib-live/libinput
	xgui-live-lib/libdrm
	xgui-live-lib/libxkbcommon
	xgui-live-lib/pixman
	xgui-live-lib/wayland
	xgui-misc/mesa
"
BDEPEND="
	xgui-live-lib/wayland-protocols
	app-dev/pkgconf
"

src_configure() {
	local emesonargs=(
		-Dxcb-errors=disabled
		-Dxwayland=enabled
		-Dexamples=false
		-Dwerror=false
	)

	meson_src_configure
}
