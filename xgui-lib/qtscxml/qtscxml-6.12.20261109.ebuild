# Distributed under the terms of the GNU General Public License v2

BRANCH_NAME="$(ver_cut 1-2)"

inherit cmake

DESCRIPTION="SCXML and state machine libraries for Qt 6"
HOMEPAGE="https://www.qt.io/"
SNAPSHOT=b921d407e44f6d570e0a0405cdd479b9fc6fdbed
SRC_URI="https://invent.kde.org/qt/qt/${PN}/-/archive/${SNAPSHOT}/${PN}-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="|| ( GPL-2 GPL-3 LGPL-3 ) FDL-1.3"
SLOT="$(ver_cut 1)"
KEYWORDS="amd64 arm64"

IUSE="test"
RESTRICT="!test? ( test )"

DEPEND=">=xgui-lib/qtbase-6.12:6="
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		-DCMAKE_PROJECT_QtScxml_INCLUDE="${FILESDIR}/qtscxml-pic-link.cmake"
		-DCMAKE_DISABLE_FIND_PACKAGE_Qt6Qml=ON
		-DCMAKE_DISABLE_FIND_PACKAGE_Qt6QuickTest=ON
		-DQT_BUILD_EXAMPLES=OFF
		-DQT_BUILD_TESTS=$(usex test ON OFF)
	)
	cmake_src_configure
}

src_test() {
	local -x QT_QPA_PLATFORM=offscreen
	cmake_src_test
}
