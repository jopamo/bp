# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils python-any-r1 git-r3

DESCRIPTION="Extra modules and scripts for CMake"
HOMEPAGE="https://cgit.kde.org/extra-cmake-modules.git"
EGIT_REPO_URI="https://github.com/KDE/extra-cmake-modules.git"

LICENSE="BSD"
SLOT="0/1"
KEYWORDS="amd64 arm64"

IUSE="test"

DEPEND="app-compression/libarchive
		test? (
			gui-lib/qtcore
			gui-lib/linguist-tools
		)
"

python_check_deps() {
	has_version "dev-python/sphinx[${PYTHON_USEDEP}]"
}

src_configure() {
	use test && mycmakeargs+=( -DCMAKE_DISABLE_FIND_PACKAGE_PythonModuleGeneration=ON )
	cmake-utils_src_configure
}
