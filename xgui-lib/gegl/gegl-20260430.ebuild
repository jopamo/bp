# Distributed under the terms of the GNU General Public License v2

inherit meson

DESCRIPTION="Graph-based image processing framework"
HOMEPAGE="https://gegl.org/"
SNAPSHOT=8a0fa125b99b3c95fc64aa8b708ab04ba2ca3ef3
SRC_URI="https://gitlab.gnome.org/GNOME/gegl/-/archive/${SNAPSHOT}/gegl-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="LGPL-2+ FTL"
SLOT="0"
KEYWORDS="amd64 arm64"
