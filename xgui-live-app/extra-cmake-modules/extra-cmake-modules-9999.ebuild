# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake git-r3

DESCRIPTION="Extra modules and scripts for CMake"
HOMEPAGE="https://cgit.kde.org/extra-cmake-modules.git"
EGIT_REPO_URI="https://github.com/KDE/extra-cmake-modules.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="test"

DEPEND="app-compression/libarchive
		test? (	xgui-live-lib/qtbase )
"

src_configure() {
	local mycmakeargs=(
		-DBUILD_HTML_DOCS=OFF
		-DBUILD_MAN_DOCS=OFF
		-DBUILD_QTHELP_DOCS=OFF
		-DBUILD_TESTING="$(usex test)"
	)

	use test && mycmakeargs+=( -DCMAKE_DISABLE_FIND_PACKAGE_PythonModuleGeneration=ON )
	cmake_src_configure
}
