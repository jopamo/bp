# Distributed under the terms of the GNU General Public License v2

inherit meson

DESCRIPTION="EDID and DisplayID library"
HOMEPAGE="https://gitlab.freedesktop.org/emersion/libdisplay-info/"
SNAPSHOT=70855b14c1d2955910c47d1b7ffbe90457a6cbef
SRC_URI="https://gitlab.freedesktop.org/emersion/libdisplay-info/-/archive/${SNAPSHOT}/${PN}-${SNAPSHOT}.tar.bz2 -> ${PN}-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"
