# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson flag-o-matic

DESCRIPTION="Mesa's OpenGL utility and demo programs (glxgears and glxinfo)"
HOMEPAGE="https://www.mesa3d.org/ https://mesa.freedesktop.org/"
SNAPSHOT=d5d06d4c573a65230229831cb7d35e1d563f1829
SRC_URI="https://gitlab.freedesktop.org/mesa/demos/-/archive/${SNAPSHOT}/demos-${SNAPSHOT}.tar.bz2 -> demos-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/demos-${SNAPSHOT}"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="wayland X"

RDEPEND="
	xgui-tools/mesa
	xgui-lib/libX11"
DEPEND="${RDEPEND}
	xgui-lib/freeglut
	xmedia-lib/glad
	xmedia-lib/glu
	xgui-tools/xorgproto"

src_configure() {
	filter-flags -Wl,-z,defs

	local emesonargs=(
		$(meson_feature X x11)
		$(meson_feature wayland)
	)
	meson_src_configure
}

src_install() {
	meson_src_install
	mv "${ED}"/usr/bin/line "${ED}"/usr/bin/mesa-line
}

