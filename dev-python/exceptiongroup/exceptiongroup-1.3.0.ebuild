# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=flit_scm
PYTHON_COMPAT=( pypy3_11 python3_{11..14} )

inherit distutils-r1 pypi

DESCRIPTION="Backport of PEP 654 (exception groups)"
HOMEPAGE="
	https://github.com/agronholm/exceptiongroup/
	https://pypi.org/project/exceptiongroup/
"

LICENSE="MIT PSF-2.4"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
	$(python_gen_cond_dep '
		>=dev-python/typing-extensions-4.6.0[${PYTHON_USEDEP}]
	' 3.11 3.12)
"

distutils_enable_tests pytest

python_test() {
	local EPYTEST_DESELECT=()
	case ${EPYTHON} in
		python3.14*)
			EPYTEST_DESELECT+=(
				# https://github.com/agronholm/exceptiongroup/issues/148
				tests/test_exceptions.py::DeepRecursionInSplitAndSubgroup::test_deep_split
				tests/test_exceptions.py::DeepRecursionInSplitAndSubgroup::test_deep_subgroup
			)
			;;
	esac

	local -x PYTEST_DISABLE_PLUGIN_AUTOLOAD=1
	epytest
}
