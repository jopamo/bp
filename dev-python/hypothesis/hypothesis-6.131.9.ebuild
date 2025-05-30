# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
CLI_COMPAT=( pypy3 python3_{10..13} )
PYTHON_COMPAT=( "${CLI_COMPAT[@]}" pypy3_11 python3_13t )
PYTHON_REQ_USE="threads(+),sqlite"

inherit distutils-r1 

TAG=hypothesis-python-${PV}
MY_P=hypothesis-${TAG}
DESCRIPTION="A library for property based testing"
HOMEPAGE="
	https://github.com/HypothesisWorks/hypothesis/
	https://pypi.org/project/hypothesis/
"
SRC_URI="
	https://github.com/HypothesisWorks/hypothesis/archive/${TAG}.tar.gz
		-> ${P}.gh.tar.gz
"
S="${WORKDIR}/${MY_P}/hypothesis-python"

LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="cli"

RDEPEND="
	>=dev-python/attrs-22.2.0[${PYTHON_USEDEP}]
	>=dev-python/sortedcontainers-2.1.0[${PYTHON_USEDEP}]
	$(python_gen_cond_dep '
		>=dev-python/exceptiongroup-1.0.0_rc8[${PYTHON_USEDEP}]
	' 3.9 3.10)
	cli? (
		$(python_gen_cond_dep '
			dev-python/black[${PYTHON_USEDEP}]
			dev-python/click[${PYTHON_USEDEP}]
		' "${CLI_COMPAT[@]}")
	)
"
BDEPEND="
	test? (
		dev-python/pexpect[${PYTHON_USEDEP}]
		>=dev-python/pytest-8[${PYTHON_USEDEP}]
		dev-python/pytest-rerunfailures[${PYTHON_USEDEP}]
		dev-python/pytest-xdist[${PYTHON_USEDEP}]
	)
"

EPYTEST_XDIST=1
distutils_enable_tests pytest

python_test() {
	# subtests are broken by warnings from random plugins
	local -x PYTEST_DISABLE_PLUGIN_AUTOLOAD=1
	local -x PYTEST_PLUGINS=xdist.plugin,_hypothesis_pytestplugin
	local -x HYPOTHESIS_NO_PLUGINS=1

	# NB: paths need to be relative to pytest.ini,
	# i.e. start with hypothesis-python/
	local EPYTEST_DESELECT=()
	case ${EPYTHON} in
		pypy3)
			EPYTEST_DESELECT+=(
				# failing due to warnings from numpy/cython
				hypothesis-python/tests/pytest/test_fixtures.py::test_given_plus_overridden_fixture
			)
			;;
		python3.13t)
			EPYTEST_DESELECT+=(
				# TODO: missing warning
				'hypothesis-python/tests/cover/test_random_module.py::test_passing_referenced_instance_within_function_scope_warns'
			)
			;&
		python3.1[23]*)
			EPYTEST_DESELECT+=(
				# TODO
				'hypothesis-python/tests/cover/test_reflection.py::test_clean_source[case-5]'
			)
			;;
	esac

	epytest -o filterwarnings= -p rerunfailures --reruns=5 \
		tests/cover tests/pytest tests/quality
}

src_install() {
	local HAD_CLI=

	distutils-r1_src_install

	if [[ ! ${HAD_CLI} ]]; then
		rm -r "${ED}/usr/bin" || die
	fi
}

python_install() {
	distutils-r1_python_install
	if use cli && has "${EPYTHON}" "${CLI_COMPAT[@]/_/.}"; then
		HAD_CLI=1
	else
		rm -r "${D}$(python_get_scriptdir)" || die
	fi
}

pkg_postinst() {
 "datetime support" dev-python/pytz
 "dateutil support" dev-python/python-dateutil
 "numpy support" dev-python/numpy
 "django support" dev-python/django dev-python/pytz
 "pandas support" dev-python/pandas
 "pytest support" dev-python/pytest
}
