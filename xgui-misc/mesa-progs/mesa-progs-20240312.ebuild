# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake flag-o-matic

DESCRIPTION="Mesa's OpenGL utility and demo programs (glxgears and glxinfo)"
HOMEPAGE="https://www.mesa3d.org/ https://mesa.freedesktop.org/"

SNAPSHOT=292e6a81e35e3807bf968f0692ea7586056ad2b3
SRC_URI="https://gitlab.freedesktop.org/mesa/demos/-/archive/${SNAPSHOT}/demos-${SNAPSHOT}.tar.bz2 -> demos-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/demos-${SNAPSHOT}"

LICENSE="LGPL-2"
SLOT="0"
#KEYWORDS="amd64 arm64"

RDEPEND="
	xgui-misc/mesa
	xgui-live-lib/libX11"
DEPEND="${RDEPEND}
	xmedia-live-lib/glad
	xmedia-live-lib/glu
	xgui-live-app/xorgproto"

filter-flags -Wl,-z,defs
