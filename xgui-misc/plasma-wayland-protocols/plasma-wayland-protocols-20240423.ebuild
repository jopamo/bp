# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Plasma-specific protocols for Wayland"

SNAPSHOT=bb8df19db98dba1596ee533fe0575d662ecfb86c
SRC_URI="https://github.com/KDE/plasma-wayland-protocols/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="|| ( LGPL-2.1 LGPL-3 ) MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="X"

RESTRICT="test"
