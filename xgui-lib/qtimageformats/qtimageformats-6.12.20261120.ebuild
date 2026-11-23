# Distributed under the terms of the GNU General Public License v2

BRANCH_NAME="$(ver_cut 1-2)"

inherit cmake

DESCRIPTION="Additional format plugins for the Qt image I/O system"
HOMEPAGE="https://www.qt.io/"

SNAPSHOT=a87c27938042758cdd0d6acfbb064b9fa67282c3
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
