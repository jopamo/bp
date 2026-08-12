# Distributed under the terms of the GNU General Public License v2

inherit meson

DESCRIPTION="Pixel encoding and color space conversion engine"
HOMEPAGE="https://gegl.org/babl/"
SNAPSHOT=e037995ae7cdcf17923f6d03e76f9539ae144e47
SRC_URI="https://gitlab.gnome.org/GNOME/babl/-/archive/${SNAPSHOT}/babl-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="LGPL-2+ FTL"
SLOT="0"
KEYWORDS="amd64 arm64"
