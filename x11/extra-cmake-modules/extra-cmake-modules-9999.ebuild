# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{6,7,8} )

inherit cmake-utils python-any-r1 git-r3

DESCRIPTION="Extra modules and scripts for CMake"
HOMEPAGE="https://cgit.kde.org/extra-cmake-modules.git"
EGIT_REPO_URI="https://github.com/KDE/extra-cmake-modules.git"
SLOT=0

LICENSE="BSD"
KEYWORDS="amd64 arm64"
IUSE="doc test"

DEPEND="
	doc? (
		${PYTHON_DEPS}
		$(python_gen_any_dep 'dev-python/sphinx[${PYTHON_USEDEP}]')
	)
	test? (
		gui-lib/qtcore
		gui-lib/linguist-tools
	)
"
RDEPEND="
	app-compression/libarchive
"

python_check_deps() {
	has_version "dev-python/sphinx[${PYTHON_USEDEP}]"
}

pkg_setup() {
	use doc && python-any-r1_pkg_setup
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_HTML_DOCS="$(usex doc)"
		-DBUILD_MAN_DOCS="$(usex doc)"
		-DDOC_INSTALL_DIR="/usr/share/doc/${PF}"
	)
	use test && mycmakeargs+=( -DCMAKE_DISABLE_FIND_PACKAGE_PythonModuleGeneration=ON )

	cmake-utils_src_configure
}
