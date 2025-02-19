# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Framework providing access to properties and features of the window manager"

SNAPSHOT=311d3de07e4563a84d7b09fa77ff392aced21571
SRC_URI="https://github.com/KDE/kwindowsystem/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/kwindowsystem-${SNAPSHOT}

LICENSE="|| ( LGPL-2.1 LGPL-3 ) MIT"
SLOT="$(ver_cut 1)"
KEYWORDS="amd64 arm64"

IUSE="X"

RESTRICT="test"

DEPEND="
	xgui-lib/qttools
	xgui-tools/extra-cmake-modules
	xgui-misc/plasma-wayland-protocols
"
