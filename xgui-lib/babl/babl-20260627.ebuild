# Distributed under the terms of the GNU General Public License v2

inherit meson

DESCRIPTION="Pixel encoding and color space conversion engine"
HOMEPAGE="https://gegl.org/babl/"
SNAPSHOT=43f501a1acd9ee46fbcc5822ed7a0dec539cc4cd
SRC_URI="https://gitlab.gnome.org/GNOME/babl/-/archive/${SNAPSHOT}/babl-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="LGPL-2+ FTL"
SLOT="0"
KEYWORDS="amd64 arm64"
