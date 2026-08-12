# Distributed under the terms of the GNU General Public License v2

BRANCH_NAME="master"

inherit cmake

DESCRIPTION="Framework providing access to properties and features of the window manager"
HOMEPAGE="https://invent.kde.org/frameworks/kwindowsystem"
SNAPSHOT=48ce84f88a0ef13cc533662e7caac1dc9bc9e67f
SRC_URI="https://github.com/KDE/kwindowsystem/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/kwindowsystem-${SNAPSHOT}

LICENSE="|| ( LGPL-2.1 LGPL-3 ) MIT"
SLOT="$(ver_cut 1)"
KEYWORDS="amd64 arm64"

IUSE="X"

RESTRICT="test"

DEPEND="
	xgui-lib/qtdeclarative:6
	xgui-lib/qttools:6
	xgui-tools/extra-cmake-modules
"

src_configure() {
	local mycmakeargs=(
		-D KWINDOWSYSTEM_WAYLAND=OFF
	)


	cmake_src_configure
}
