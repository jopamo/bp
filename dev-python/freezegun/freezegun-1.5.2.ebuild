# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} python3_{13,14}t pypy3_11 )

inherit distutils-r1 pypi

DESCRIPTION="Let your Python tests travel through time"
HOMEPAGE="
	https://github.com/spulec/freezegun/
	https://pypi.org/project/freezegun/
"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
	>dev-python/python-dateutil-2.7[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		$(python_gen_impl_dep sqlite)
	)
"

distutils_enable_tests pytest

python_test() {
	local EPYTEST_DESELECT=()
	case ${EPYTHON} in
		python3.1[34]*)
			EPYTEST_DESELECT+=(
				# https://github.com/spulec/freezegun/issues/547
				tests/test_datetimes.py::TestUnitTestMethodDecorator::test_method_decorator_works_on_unittest_kwarg_frozen_time
				tests/test_datetimes.py::TestUnitTestMethodDecorator::test_method_decorator_works_on_unittest_kwarg_frozen_time_with_func
				tests/test_datetimes.py::TestUnitTestMethodDecorator::test_method_decorator_works_on_unittest_kwarg_hello
			)
			;;
	esac

	local -x PYTEST_DISABLE_PLUGIN_AUTOLOAD=1
	epytest
}
