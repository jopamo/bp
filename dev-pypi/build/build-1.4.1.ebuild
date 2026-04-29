# Distributed under the terms of the GNU General Public License v2

DISTUTILS_USE_PEP517=flit
PYTHON_TESTED=( python3_{11..14} pypy3_11 )
PYTHON_COMPAT=( "${PYTHON_TESTED[@]}" python3_{13,14}t )

inherit distutils-r1
# lockstep-pypi-managed: true
# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/packaging
	dev-pypi/pyproject-hooks
"
# lockstep-pypi-deps: end
MY_P=${P/_p/.post}
DESCRIPTION="A simple, correct PEP517 package builder"
HOMEPAGE="
	https://pypi.org/project/build/
	https://github.com/pypa/build/
"
SRC_URI="
	https://github.com/pypa/build/archive/${PV/_p/.post}.tar.gz
		-> ${MY_P}.gh.tar.gz
"
S=${WORKDIR}/${MY_P}

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="test test-rust"
RESTRICT="!test? ( test )"

RDEPEND="
	>=dev-pypi/packaging-24.0[${PYTHON_USEDEP}]
	dev-pypi/pyproject-hooks[${PYTHON_USEDEP}]
"
BDEPEND="
	>=dev-py/setuptools-scm-6[${PYTHON_USEDEP}]
	test? (
		${RDEPEND}
		$(python_gen_cond_dep '
			>=dev-pypi/filelock-3[${PYTHON_USEDEP}]
			dev-pypi/pytest[${PYTHON_USEDEP}]
			>=dev-py/pytest-mock-2[${PYTHON_USEDEP}]
			>=dev-py/pytest-rerunfailures-9.1[${PYTHON_USEDEP}]
			>=dev-pypi/pytest-xdist-1.34[${PYTHON_USEDEP}]
			>=dev-pypi/setuptools-56.0.0[${PYTHON_USEDEP}]
			>=dev-pypi/virtualenv-20.0.35[${PYTHON_USEDEP}]
			>=dev-pypi/wheel-0.36.0[${PYTHON_USEDEP}]
			
		' "${PYTHON_TESTED[@]}")
	)
"

python_test() {
	if ! has "${EPYTHON/./_}" "${PYTHON_TESTED[@]}"; then
		einfo "Skipping tests on ${EPYTHON}"
		return
	fi

	local EPYTEST_DESELECT=(
		# broken by uv being installed outside venv
		tests/test_env.py::test_external_uv_detection_success
	)

	if ! has_version "dev-py/uv"; then
		EPYTEST_DESELECT+=(
			tests/test_env.py::test_uv_impl_install_cmd_well_formed
			'tests/test_env.py::test_venv_creation[uv-venv+uv-None]'
		)
	fi

	local EPYTEST_PLUGINS=( pytest-{mock,rerunfailures} )
	local EPYTEST_XDIST=1
	epytest -m "not network"
}
