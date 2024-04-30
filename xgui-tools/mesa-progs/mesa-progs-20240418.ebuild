# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake flag-o-matic

DESCRIPTION="Mesa's OpenGL utility and demo programs (glxgears and glxinfo)"
HOMEPAGE="https://www.mesa3d.org/ https://mesa.freedesktop.org/"

SNAPSHOT=d4a924d9e31e8ff86f81e885c123888b6d3ba21e
SRC_URI="https://gitlab.freedesktop.org/mesa/demos/-/archive/${SNAPSHOT}/demos-${SNAPSHOT}.tar.bz2 -> demos-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/demos-${SNAPSHOT}"

LICENSE="LGPL-2"
SLOT="0"
#KEYWORDS="amd64 arm64"

RDEPEND="
	xgui-tools/mesa
	xgui-lib/libX11"
DEPEND="${RDEPEND}
	xmedia-lib/glad
	xmedia-lib/glu
	xgui-tools/xorgproto"

filter-flags -Wl,-z,defs
