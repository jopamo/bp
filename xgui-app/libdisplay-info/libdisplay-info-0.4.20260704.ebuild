# Distributed under the terms of the GNU General Public License v2

inherit meson

DESCRIPTION="EDID and DisplayID library"
HOMEPAGE="https://gitlab.freedesktop.org/emersion/libdisplay-info/"
SNAPSHOT=772d506015f4b6182f19ad879c2fbf28f41c9a6a
SRC_URI="https://gitlab.freedesktop.org/emersion/libdisplay-info/-/archive/${SNAPSHOT}/${PN}-${SNAPSHOT}.tar.bz2 -> ${PN}-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"
