# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="Pixel encoding and color space conversion engine"
HOMEPAGE="http://www.pango.org/"
SNAPSHOT=4fb2cafe115908ef3d3ae4b1cde162efd9f4e06d
SRC_URI="https://gitlab.gnome.org/GNOME/babl/-/archive/${SNAPSHOT}/babl-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="LGPL-2+ FTL"
SLOT="0"
KEYWORDS="amd64 arm64"
