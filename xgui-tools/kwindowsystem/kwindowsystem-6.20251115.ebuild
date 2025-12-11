# Distributed under the terms of the GNU General Public License v2

EAPI=8

BRANCH_NAME="master"

inherit cmake

DESCRIPTION="Framework providing access to properties and features of the window manager"
HOMEPAGE="https://invent.kde.org/frameworks/kwindowsystem"
SNAPSHOT=48ec9f56965d95ec429704d6a4b98865d8c7c39a
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
