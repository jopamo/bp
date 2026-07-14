# Distributed under the terms of the GNU General Public License v2

inherit meson

DESCRIPTION="Pixel encoding and color space conversion engine"
HOMEPAGE="https://gegl.org/babl/"
SNAPSHOT=2f6ccc8fda4cdc7671c0585b0b69aee4a36804ba
SRC_URI="https://gitlab.gnome.org/GNOME/babl/-/archive/${SNAPSHOT}/babl-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="LGPL-2+ FTL"
SLOT="0"
KEYWORDS="amd64 arm64"
