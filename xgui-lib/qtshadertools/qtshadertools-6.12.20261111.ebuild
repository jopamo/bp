# Distributed under the terms of the GNU General Public License v2

BRANCH_NAME="$(ver_cut 1-2)"

inherit cmake

DESCRIPTION="Shader tools module for the Qt framework"
HOMEPAGE="https://www.qt.io/"

SNAPSHOT=f2616a2fb96c520775682bc4e1a82e2b9e8c3929
SRC_URI="https://invent.kde.org/qt/qt/${PN}/-/archive/${SNAPSHOT}/${PN}-${SNAPSHOT}.tar.bz2"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="|| ( GPL-2 GPL-3 LGPL-3 ) FDL-1.3"
SLOT="$(ver_cut 1)"
KEYWORDS="amd64 arm64"

IUSE="test"
RESTRICT="!test? ( test )"

DEPEND="
	>=xgui-lib/qtbase-6.12:6=
"

PATCHES=( "${FILESDIR}/${PN}-spirv-cross-namespace.patch" )

src_configure() {
	local mycmakeargs=(
		-DQT_BUILD_TESTS=$(usex test ON OFF)
	)
	cmake_src_configure
}
