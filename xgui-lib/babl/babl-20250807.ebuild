# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="Pixel encoding and color space conversion engine"
HOMEPAGE="http://www.pango.org/"

SNAPSHOT=f1e72053ad492dde809140fadb7c4ec545127a18
SRC_URI="https://gitlab.gnome.org/GNOME/babl/-/archive/${SNAPSHOT}/babl-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="LGPL-2+ FTL"
SLOT="0"
KEYWORDS="amd64 arm64"
