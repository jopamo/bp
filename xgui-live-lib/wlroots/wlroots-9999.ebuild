# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="A modular Wayland compositor library"
HOMEPAGE="https://github.com/swaywm/wlroots"
EGIT_REPO_URI="https://github.com/swaywm/wlroots"

if [[ ${PV} == *9999 ]]; then
	EGIT_REPO_URI="https://github.com/swaywm/${PN}.git"
	inherit git-r3
else
	SRC_URI="https://github.com/swaywm/${PN}/releases/download/${PV}/${P}.tar.gz"
fi

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
