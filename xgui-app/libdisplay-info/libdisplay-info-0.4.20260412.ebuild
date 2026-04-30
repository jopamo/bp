# Distributed under the terms of the GNU General Public License v2

inherit meson

DESCRIPTION="EDID and DisplayID library"
HOMEPAGE="https://gitlab.freedesktop.org/emersion/libdisplay-info/"
SNAPSHOT=baa0e5219c457d1ce59848ea2999188f85b56ac9
SRC_URI="https://gitlab.freedesktop.org/emersion/libdisplay-info/-/archive/${SNAPSHOT}/${PN}-${SNAPSHOT}.tar.bz2 -> ${PN}-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"
