# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="The OpenGL Utility Library"
HOMEPAGE="https://cgit.freedesktop.org/mesa/glu/"

SNAPSHOT=a2b96c7bba8db8fec3e02fb4227a7f7b02cabad1
SRC_URI="https://gitlab.freedesktop.org/mesa/glu/-/archive/${SNAPSHOT}/glu-${SNAPSHOT}.tar.bz2 -> glu-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/glu-${SNAPSHOT}"

LICENSE="SGI-B-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

DEPEND="xgui-tools/mesa"

src_install() {
	meson_src_install
	use static-libs || find "${ED}" -name '*.a' -delete
}
