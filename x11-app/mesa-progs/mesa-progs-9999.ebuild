# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake git-r3 flag-o-matic

DESCRIPTION="Mesa's OpenGL utility and demo programs (glxgears and glxinfo)"
HOMEPAGE="https://www.mesa3d.org/ https://mesa.freedesktop.org/"
EGIT_REPO_URI="https://gitlab.freedesktop.org/mesa/demos.git"

LICENSE="LGPL-2"
SLOT="0"
#KEYWORDS="amd64 arm64"

RDEPEND="
	lib-media/mesa
	x11-live-libs/libX11"
DEPEND="${RDEPEND}
	lib-media/glad
	lib-media/glu
	x11-live-misc/xorgproto"

filter-flags -Wl,-z,defs
