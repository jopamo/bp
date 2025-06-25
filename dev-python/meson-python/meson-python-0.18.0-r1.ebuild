# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=standalone
PYTHON_COMPAT=( python3_{11..14} pypy3_11 )

inherit distutils-r1

DESCRIPTION="Meson PEP 517 Python build backend"
HOMEPAGE="
	https://pypi.org/project/meson-python/
	https://github.com/mesonbuild/meson-python/
"
SRC_URI="
	https://github.com/mesonbuild/meson-python/archive/${PV}.tar.gz
		-> ${P}.gh.tar.gz
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
	>=dev-python/pyproject-metadata-0.7.1[${PYTHON_USEDEP}]
	>=app-dev/meson-0.63.0
"
BDEPEND="
	${RDEPEND}
	test? (
		>=dev-py/cython-0.29.34
		>=dev-python/packaging-23.1[${PYTHON_USEDEP}]
		dev-python/pytest-mock[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

src_prepare() {
	distutils-r1_src_prepare

	# Strip unnecessary Python-level dependency on meson, it is used
	# as an external executable anyway.
	sed -i -e '/meson >=/d' pyproject.toml || die
}

src_test() {
	# required by tests/test_sdist.py::test_reproducible
	git config --global user.email "test@example.com" || die
	git config --global user.name "The Test Suite" || die
	git init -q || die
	git add -A || die
	git commit -m init -q || die

	distutils-r1_src_test
}

python_test() {
	unset NINJA

	local EPYTEST_DESELECT=()
	if ! has_version "app-dev/meson[${PYTHON_USEDEP}]"; then
		EPYTEST_DESELECT+=(
			tests/test_wheel.py::test_vendored_meson
		)
	fi

	local -x PYTEST_DISABLE_PLUGIN_AUTOLOAD=1
	epytest -p pytest_mock
}
