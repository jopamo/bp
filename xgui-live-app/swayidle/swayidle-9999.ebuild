# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson git-r3

DESCRIPTION="Idle management daemon for Wayland"
HOMEPAGE="https://github.com/swaywm/swayidle"
EGIT_REPO_URI="https://github.com/swaywm/${PN}.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	lib-dev/wayland
	app-core/systemd[logind]
"

BDEPEND="
	lib-dev/wayland-protocols
	dev-util/pkgconf
"

src_configure() {
	local emesonargs=(
		-Dman-pages=disabled
		-Dfish-completion=false
		-Dzsh-completion=false
		"-Dbash-completions=true"
		"-Dwerror=false"
		"-Dlogind=enabled"
		"-Dlogind-provider=systemd"
	)
	meson_src_configure
}
