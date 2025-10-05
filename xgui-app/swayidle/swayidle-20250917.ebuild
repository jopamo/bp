# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="Idle management daemon for Wayland"
HOMEPAGE="https://github.com/swaywm/swayidle"
SNAPSHOT=afcce4303d447f12b20e035fcb9ff09b4a0b948b
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
