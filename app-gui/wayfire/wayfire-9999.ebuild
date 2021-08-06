# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson git-r3 flag-o-matic

DESCRIPTION="3D wayland compositor"
HOMEPAGE="https://github.com/WayfireWM/wayfire"
EGIT_REPO_URI="https://github.com/WayfireWM/wayfire.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	lib-media/glm
	lib-dev/wayland
	lib-dev/wayland-protocols
"

filter-flags -Wl,-z,defs
