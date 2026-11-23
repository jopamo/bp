# Distributed under the terms of the GNU General Public License v2

inherit meson

DESCRIPTION="Graph-based image processing framework"
HOMEPAGE="https://gegl.org/"
SNAPSHOT=838e2ce9c5624f4a5af9eb6c88482184147000e0
SRC_URI="https://gitlab.gnome.org/GNOME/gegl/-/archive/${SNAPSHOT}/gegl-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="LGPL-2+ FTL"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
	lib-core/glib
	lib-dev/json-glib
	xgui-lib/babl
	xmedia-lib/libjpeg-turbo
	xmedia-lib/libpng
"
DEPEND="${RDEPEND}"
BDEPEND="app-dev/pkgconf"
