# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Plasma-specific protocols for Wayland"

SNAPSHOT=1b1962118fafdd626ff2eaa5ffbef6e6a5baaa08
SRC_URI="https://github.com/KDE/plasma-wayland-protocols/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="|| ( LGPL-2.1 LGPL-3 ) MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="X"

DEPEND="xgui-lib/wayland-protocols"

RESTRICT="test"
