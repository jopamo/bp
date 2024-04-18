# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Framework providing access to properties and features of the window manager"

SNAPSHOT=1ba26d818ad51cad08fdeee3462e611e0b7a7ba6
SRC_URI="https://github.com/KDE/kwindowsystem/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/kwindowsystem-${SNAPSHOT}

LICENSE="|| ( LGPL-2.1 LGPL-3 ) MIT"
SLOT="$(ver_cut 1)"
KEYWORDS="amd64 arm64"

IUSE="X"

RESTRICT="test"

DEPEND="
	xgui-tools/extra-cmake-modules
	xgui-misc/plasma-wayland-protocols
"
