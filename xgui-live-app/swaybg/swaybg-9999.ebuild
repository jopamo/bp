# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson git-r3

DESCRIPTION="A wallpaper utility for Wayland"
HOMEPAGE="https://github.com/swaywm/swaybg"
EGIT_REPO_URI="https://github.com/swaywm/${PN}.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="xgui-live-lib/wayland"

BDEPEND="
	xgui-live-lib/wayland-protocols
	xgui-live-lib/gdk-pixbuf
	xgui-live-lib/cairo
	dev-util/pkgconf
"

src_configure() {
	local emesonargs=(
		-Dman-pages=disabled
		"-Dwerror=false"
	)

	meson_src_configure
}
