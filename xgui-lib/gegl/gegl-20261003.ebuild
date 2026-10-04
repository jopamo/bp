# Distributed under the terms of the GNU General Public License v2

inherit meson

DESCRIPTION="Graph-based image processing framework"
HOMEPAGE="https://gegl.org/"
SNAPSHOT=07c4a48305b7a629cb37837d00e72bb76c933a85
SRC_URI="https://gitlab.gnome.org/GNOME/gegl/-/archive/${SNAPSHOT}/gegl-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="LGPL-2+ FTL"
SLOT="0"
KEYWORDS="amd64 arm64"
