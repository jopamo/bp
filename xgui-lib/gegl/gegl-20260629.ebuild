# Distributed under the terms of the GNU General Public License v2

inherit meson

DESCRIPTION="Graph-based image processing framework"
HOMEPAGE="https://gegl.org/"
SNAPSHOT=f55034e487a5397c41e906d381b0e71e6b1f50ca
SRC_URI="https://gitlab.gnome.org/GNOME/gegl/-/archive/${SNAPSHOT}/gegl-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="LGPL-2+ FTL"
SLOT="0"
KEYWORDS="amd64 arm64"
