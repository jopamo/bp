# Distributed under the terms of the GNU General Public License v2

BRANCH_NAME="master"

inherit cmake

DESCRIPTION="Framework providing access to properties and features of the window manager"
HOMEPAGE="https://invent.kde.org/frameworks/kwindowsystem"
SNAPSHOT=7eb2bb0bb9135c1857115701f19d86e2e6c368c6
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
