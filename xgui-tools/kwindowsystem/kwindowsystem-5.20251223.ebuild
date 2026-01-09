# Distributed under the terms of the GNU General Public License v2

EAPI=8

BRANCH_NAME="kf$(ver_cut 1)"

inherit cmake

DESCRIPTION="Framework providing access to properties and features of the window manager"
HOMEPAGE="https://invent.kde.org/frameworks/kwindowsystem"
SNAPSHOT=7b830723f199540e18330bb64a899f905275f956
SRC_URI="https://github.com/KDE/kwindowsystem/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
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
