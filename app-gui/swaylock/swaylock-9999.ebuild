# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit fcaps meson git-r3

DESCRIPTION="Screen locker for Wayland"
HOMEPAGE="https://github.com/swaywm/swaylock"
EGIT_REPO_URI="https://github.com/swaywm/${PN}.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="pam"

DEPEND="
	lib-dev/wayland
	lib-gui/cairo
	lib-gui/libxkbcommon
	x11-live-libs/gdk-pixbuf:2
	pam? ( lib-sys/pam )"

BDEPEND="
	lib-dev/wayland-protocols
	dev-util/pkgconf
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

pkg_postinst() {
	if ! use pam; then
		fcaps cap_sys_admin usr/bin/swaylock
	fi
}
