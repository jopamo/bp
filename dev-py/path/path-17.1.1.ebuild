# Distributed under the terms of the GNU General Public License v2

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} pypy3_11 )

inherit distutils-r1 pypi
# lockstep-pypi-managed: true
# lockstep-pypi-deps: begin
RDEPEND+="
"
# lockstep-pypi-deps: end
DESCRIPTION="A module wrapper for os.path"
HOMEPAGE="
	https://github.com/jaraco/path/
	https://pypi.org/project/path/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
	dev-py/appdirs[${PYTHON_USEDEP}]
"
BDEPEND="
	dev-py/setuptools-scm[${PYTHON_USEDEP}]
	test? (
		dev-py/more-itertools[${PYTHON_USEDEP}]
		dev-py/packaging[${PYTHON_USEDEP}]
	)
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest

EPYTEST_DESELECT=(
	# unreliable, not really meaningful for end users
	test_path.py::TestPerformance
)
