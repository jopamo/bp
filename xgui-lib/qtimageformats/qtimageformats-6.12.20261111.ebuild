# Distributed under the terms of the GNU General Public License v2

BRANCH_NAME="$(ver_cut 1-2)"

inherit cmake

DESCRIPTION="Additional format plugins for the Qt image I/O system"
HOMEPAGE="https://www.qt.io/"

SNAPSHOT=3d4e16faae1a04821105eea0a9c9f5c28ced1d52
SRC_URI="https://invent.kde.org/qt/qt/${PN}/-/archive/${SNAPSHOT}/${PN}-${SNAPSHOT}.tar.bz2"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="|| ( GPL-2 GPL-3 LGPL-3 ) FDL-1.3"
SLOT="$(ver_cut 1)"
KEYWORDS="amd64 arm64"

IUSE="test"
RESTRICT="!test? ( test )"

DEPEND=">=xgui-lib/qtbase-6.12:6="

src_configure() {
	local mycmakeargs=(
		-DQT_BUILD_TESTS=$(usex test ON OFF)
	)
	cmake_src_configure
}
