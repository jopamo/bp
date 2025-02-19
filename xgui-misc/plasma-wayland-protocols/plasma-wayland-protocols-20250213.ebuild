# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Plasma-specific protocols for Wayland"

SNAPSHOT=5843146206c64de08997969ae9479f3bd5fb4c8c
SRC_URI="https://github.com/KDE/plasma-wayland-protocols/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="|| ( LGPL-2.1 LGPL-3 ) MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="X"

DEPEND="xgui-lib/wayland-protocols"

RESTRICT="test"
