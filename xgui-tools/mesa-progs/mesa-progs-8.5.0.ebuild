# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="${PN/progs/demos}"
MY_P="${MY_PN}-${PV}"

inherit meson toolchain-funcs

DESCRIPTION="Mesa's OpenGL utility and demo programs (glxgears and glxinfo)"
HOMEPAGE="https://www.mesa3d.org/ https://mesa.freedesktop.org/"
SRC_URI="https://mesa.freedesktop.org/archive/demos/${MY_P}.tar.bz2
		https://mesa.freedesktop.org/archive/demos/${PV}/${MY_P}.tar.bz2"
S="${WORKDIR}/${MY_P}"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

BDEPEND="
	xgui-misc/freeglut
	xgui-tools/mesa
	xmedia-lib/glu
"
DEPEND="xgui-lib/libX11"
