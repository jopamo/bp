# Distributed under the terms of the GNU General Public License v2

inherit meson qa-policy

DESCRIPTION="The OpenGL Utility Library"
HOMEPAGE="https://cgit.freedesktop.org/mesa/glu/"

SNAPSHOT=2318f592b712724a48dd8561b8e7397bb91d7eb7
SRC_URI="https://gitlab.freedesktop.org/mesa/glu/-/archive/${SNAPSHOT}/glu-${SNAPSHOT}.tar.bz2 -> glu-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/glu-${SNAPSHOT}"

LICENSE="SGI-B-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

DEPEND="xgui-tools/mesa"

src_configure() {
	qa-policy-configure
	meson_src_configure
}

src_install() {
	meson_src_install
	qa-policy-install
	use static-libs || find "${ED}" -name '*.a' -delete
}
