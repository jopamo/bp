# Distributed under the terms of the GNU General Public License v2

EAPI=8

BRANCH_NAME="master"

inherit cmake

DESCRIPTION="Framework providing access to properties and features of the window manager"
SNAPSHOT=32fb4f1ea61b7c2ff0642f80f4f6e99cd5eec3de
SRC_URI="https://github.com/KDE/kwindowsystem/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/kwindowsystem-${SNAPSHOT}

LICENSE="|| ( LGPL-2.1 LGPL-3 ) MIT"
SLOT="$(ver_cut 1)"
KEYWORDS="amd64 arm64"

IUSE="X"

RESTRICT="test"

DEPEND="
	xgui-lib/qttools:6
	xgui-tools/extra-cmake-modules
	xgui-misc/plasma-wayland-protocols
	xgui-lib/qtwayland:6
"
