# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson git-r3

DESCRIPTION="A modular Wayland compositor library with EGLStreams support"
HOMEPAGE="https://github.com/danvd/wlroots-eglstreams.git"
EGIT_REPO_URI="https://github.com/danvd/wlroots-eglstreams.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	lib-dev/libinput
	lib-dev/wayland
	lib-media/mesa
	xgui-live-lib/libdrm
	xgui-live-lib/libxkbcommon
	xgui-live-lib/pixman
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
		-Dxcb-errors=disabled
		-Dlibcap=enabled
		-Dxwayland=disabled
		-Dx11-backend=disabled
		-Dexamples=false
		-Dwerror=false
	)

	meson_src_configure
}
