# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson git-r3 flag-o-matic

DESCRIPTION="3D wayland compositor"
HOMEPAGE="https://github.com/WayfireWM/wayfire"
EGIT_REPO_URI="https://github.com/WayfireWM/wayfire.git"
EGIT_BRANCH="$(ver_cut 1).$(ver_cut 2).x"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	xmedia-live-lib/glm
	xgui-live-lib/wayland
	xgui-live-lib/wayland-protocols
"

filter-flags -Wl,-z,defs
