# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Plasma-specific protocols for Wayland"

SNAPSHOT=9123b73204cd82f404a538125e553de1bb52cc5b
SRC_URI="https://github.com/KDE/plasma-wayland-protocols/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="|| ( LGPL-2.1 LGPL-3 ) MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="X"

DEPEND="xgui-lib/wayland-protocols"

RESTRICT="test"
