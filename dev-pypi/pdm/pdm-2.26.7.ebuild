# Distributed under the terms of the GNU General Public License v2

DISTUTILS_USE_PEP517=pdm-backend
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 pypi
# lockstep-pypi-managed: true
# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/blinker
	dev-pypi/certifi
	dev-pypi/dep-logic
	dev-pypi/filelock
	dev-pypi/findpython
	dev-pypi/hishel
	dev-pypi/httpcore
	dev-pypi/httpx
	dev-pypi/id
	dev-pypi/installer
	dev-pypi/packaging
	dev-pypi/pbs-installer
	dev-pypi/platformdirs
	dev-pypi/pyproject-hooks
	dev-pypi/python-dotenv
	dev-pypi/resolvelib
	dev-pypi/rich
	dev-pypi/shellingham
	dev-pypi/tomlkit
	dev-pypi/truststore
	dev-pypi/unearth
	dev-pypi/virtualenv
"
# lockstep-pypi-deps: end
DESCRIPTION="Python package and dependency manager supporting the latest PEP standards"
HOMEPAGE="
	https://pdm-project.org/
	https://github.com/pdm-project/pdm/
	https://pypi.org/project/pdm/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
	dev-pypi/certifi[${PYTHON_USEDEP}]
	>=dev-py/dep-logic-0.5[${PYTHON_USEDEP}]
	<dev-py/findpython-1[${PYTHON_USEDEP}]
	>=dev-py/findpython-0.7.0[${PYTHON_USEDEP}]
	dev-pypi/blinker[${PYTHON_USEDEP}]
	dev-pypi/filelock[${PYTHON_USEDEP}]
	>=dev-py/hishel-1.0.0[${PYTHON_USEDEP}]
	>=dev-pypi/httpcore-1.0.6[${PYTHON_USEDEP}]
	dev-pypi/httpx[${PYTHON_USEDEP}]
	>=dev-py/id-1.5.0[${PYTHON_USEDEP}]
	dev-pypi/installer[${PYTHON_USEDEP}]
	>=dev-pypi/packaging-22.1[${PYTHON_USEDEP}]
	>=dev-py/pbs-installer-2025.10.07[${PYTHON_USEDEP}]
	dev-pypi/platformdirs[${PYTHON_USEDEP}]
	dev-pypi/pyproject-hooks[${PYTHON_USEDEP}]
	dev-pypi/python-dotenv[${PYTHON_USEDEP}]
	>=dev-pypi/resolvelib-1.2.0[${PYTHON_USEDEP}]
	dev-pypi/rich[${PYTHON_USEDEP}]
	dev-pypi/shellingham[${PYTHON_USEDEP}]
	dev-pypi/tomlkit[${PYTHON_USEDEP}]
	>=dev-pypi/truststore-0.10.4[${PYTHON_USEDEP}]
	>=dev-py/unearth-0.17.5[${PYTHON_USEDEP}]
	dev-pypi/virtualenv[${PYTHON_USEDEP}]
"
BDEPEND="
	${RDEPEND}
	test? (
		dev-pypi/msgpack[${PYTHON_USEDEP}]
		dev-py/uv
	)
"

EPYTEST_PLUGINS=( pytest-{httpserver,httpx,mock,rerunfailures} )
EPYTEST_RERUNS=5
EPYTEST_XDIST=1
distutils_enable_tests pytest

src_prepare() {
	distutils-r1_src_prepare

	# unpin deps
	sed -i -e 's:,<[0-9.a]*::' pyproject.toml || die
	# remove pkgutil namespace magic, as it doesn't work and makes
	# dev-pypi/pdm-backend tests test the wrong package
	rm src/pdm/__init__.py || die
}

python_test() {
	local EPYTEST_DESELECT=(
		# Internet
		'tests/models/test_candidates.py::test_expand_project_root_in_url[demo @ file:///${PROJECT_ROOT}/tests/fixtures/artifacts/demo-0.0.1.tar.gz]'
		# unhappy about extra packages being installed?
		# (also fails randomly in venv)
		tests/cli/test_build.py::test_build_with_no_isolation
		# TODO: random regression?
		tests/cli/test_python.py::test_find_python
		# TODO
		tests/test_formats.py::test_export_from_pylock_not_empty
	)

	epytest -m "not network and not integration and not path"
}
