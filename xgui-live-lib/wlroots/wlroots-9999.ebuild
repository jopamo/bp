# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson git-r3

DESCRIPTION="Pluggable, composable, unopinionated modules for building a Wayland compositor"
HOMEPAGE="https://github.com/swaywm/wlroots"
EGIT_REPO_URI="https://github.com/swaywm/${PN}.git"
#EGIT_BRANCH=$(ver_cut 1).$(ver_cut 2)

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="icccm"

DEPEND="
	lib-live/libinput
	lib-dev/wayland
	xmedia-live-lib/mesa
	xgui-live-lib/libdrm
	xgui-live-lib/libxkbcommon
	xgui-live-lib/pixman
	icccm? ( x11-live-lib/xcb-util-wm )
	app-core/systemd[logind]
	lib-core/libcap
	app-misc/seatd
"

BDEPEND="
	lib-dev/wayland-protocols
	dev-util/pkgconf
"

src_configure() {
	local emesonargs=(
		"-Dxcb-errors=disabled"
		-Dlibcap=enabled
		-Dxcb-icccm=$(usex icccm enabled disabled)
		-Dxwayland=disabled
		-Dx11-backend=disabled
		"-Dexamples=false"
		"-Dwerror=false"
		"-Dlogind=enabled"
		"-Dlogind-provider=systemd"
	)

	meson_src_configure
}
