# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="A wallpaper utility for Wayland"
HOMEPAGE="https://github.com/swaywm/swaybg"

SNAPSHOT=975d1858f4893d69b6b2df4ef4b3b5ff76031b92
SRC_URI="https://github.com/swaywm/swaybg/archive/${SNAPSHOT}.tar.gz -> swaybg-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/swaybg-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="xgui-lib/wayland"

BDEPEND="
	xgui-lib/wayland-protocols
	xgui-lib/gdk-pixbuf
	xgui-lib/cairo
	app-dev/pkgconf
"

src_configure() {
	local emesonargs=(
		-Dman-pages=disabled
		"-Dwerror=false"
	)

	meson_src_configure
}
