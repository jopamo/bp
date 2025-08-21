# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="Idle management daemon for Wayland"
HOMEPAGE="https://github.com/swaywm/swayidle"
SNAPSHOT=71005e9182a04969424c9b8a32b9e1b756505051
SRC_URI="https://github.com/swaywm/swayidle/archive/${SNAPSHOT}.tar.gz -> swayidle-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/swayidle-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	xgui-lib/wayland
	app-core/systemd[logind]
"

BDEPEND="
	xgui-lib/wayland-protocols
	app-dev/pkgconf
"

src_configure() {
	local emesonargs=(
		-Dman-pages=disabled
		-Dbash-completions=true
		-Dwerror=false
		-Dlogind=enabled
		-Dlogind-provider=systemd
	)
	meson_src_configure
}
