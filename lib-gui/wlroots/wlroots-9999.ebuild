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
	lib-dev/libinput
	lib-dev/wayland
	lib-media/mesa
	lib-gui/libdrm
	lib-gui/libxkbcommon
	lib-gui/pixman
	icccm? ( x11-libs/xcb-util-wm )
	sys-app/systemd[logind]
	lib-sys/libcap
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
