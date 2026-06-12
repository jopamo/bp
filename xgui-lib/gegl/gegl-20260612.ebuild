# Distributed under the terms of the GNU General Public License v2

inherit meson

DESCRIPTION="Graph-based image processing framework"
HOMEPAGE="https://gegl.org/"
SNAPSHOT=af3c50dc53704d9befeb0ddd9f725a0aed9a24ce
SRC_URI="https://gitlab.gnome.org/GNOME/gegl/-/archive/${SNAPSHOT}/gegl-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="LGPL-2+ FTL"
SLOT="0"
KEYWORDS="amd64 arm64"
