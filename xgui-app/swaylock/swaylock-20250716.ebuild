# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="Screen locker for Wayland"
HOMEPAGE="https://github.com/swaywm/swaylock"
SNAPSHOT=ae26713c9ce780a97f3ee74afdb47a0c5b569ed4
SRC_URI="https://github.com/swaywm/swaylock/archive/${SNAPSHOT}.tar.gz -> swaylock-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/swaylock-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="pam"

DEPEND="
	xgui-lib/wayland
	xgui-lib/cairo
	xgui-lib/libxkbcommon
	xgui-lib/gdk-pixbuf:2
	pam? ( lib-core/pam )"

BDEPEND="
	xgui-lib/wayland-protocols
	app-dev/pkgconf
"

src_configure() {
	local emesonargs=(
		-Dman-pages=disabled
		-Dpam=$(usex pam enabled disabled)
		-Dgdk-pixbuf=enabled
		-Dfish-completion=false
		-Dzsh-completion=false
		-Dbash-completions=false
		-Dwerror=false
	)
	meson_src_configure
}
