# Distributed under the terms of the GNU General Public License v2

BRANCH_NAME="$(ver_cut 1-2)"

inherit cmake flag-o-matic

DESCRIPTION="SVG image format support module for Qt 6"
HOMEPAGE="https://www.qt.io/"

SNAPSHOT=38cb5f90ccbd491468355a8da7f981c3f2571940
SRC_URI="https://invent.kde.org/qt/qt/${PN}/-/archive/${SNAPSHOT}/${PN}-${SNAPSHOT}.tar.bz2"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="|| ( GPL-2 GPL-3 LGPL-3 ) FDL-1.3"
SLOT="$(ver_cut 1)"
KEYWORDS="amd64 arm64"

IUSE="test"
RESTRICT="!test? ( test )"

DEPEND=">=xgui-lib/qtbase-6.12:6="
RDEPEND="${DEPEND}"

append-flags -ffat-lto-objects

src_configure() {
	local mycmakeargs=(
		-DQT_BUILD_TESTS=$(usex test ON OFF)
		-DCMAKE_PROJECT_QtSvg_INCLUDE="${FILESDIR}/qtsvg-pic-link.cmake"
	)
	cmake_src_configure

	if use test; then
		# The standalone header test inherits the toolchain, but not Qt6_DIR.
		local qt6_dir
		qt6_dir=$(sed -n 's/^Qt6_DIR:PATH=//p' "${BUILD_DIR}/CMakeCache.txt") || die
		[[ -f ${qt6_dir}/Qt6Config.cmake ]] || die "Cannot locate the selected Qt6 package"
		printf 'set(Qt6_DIR [==[%s]==] CACHE PATH "Qt6 package directory")\n' \
			"${qt6_dir}" >> "${BUILD_DIR}/1g4_toolchain.cmake" || die
	fi
}

src_test() {
	local -x QT_QPA_PLATFORM=offscreen
	cmake_src_test
}
