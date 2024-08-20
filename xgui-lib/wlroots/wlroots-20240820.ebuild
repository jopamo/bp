# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="A modular Wayland compositor library"
HOMEPAGE="https://github.com/swaywm/wlroots"

SNAPSHOT=62cc96b3a4eee779f6dbd92f39ebdb828fec43aa
SRC_URI="https://gitlab.freedesktop.org/wlroots/wlroots/-/archive/${SNAPSHOT}/wlroots-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/wlroots-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	app-core/systemd[logind]
	app-net/seatd
	lib-core/libcap
	lib-util/libinput
	xgui-lib/libdrm
	xgui-lib/libxkbcommon
	xgui-lib/pixman
	xgui-lib/wayland
	xgui-tools/mesa
"
BDEPEND="
	xgui-lib/wayland-protocols
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
