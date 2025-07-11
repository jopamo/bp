# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( pypy3_11 python3_{11..14} )

inherit distutils-r1 pypi

DESCRIPTION="Reusable constraint types to use with typing.Annotated"
HOMEPAGE="
	https://github.com/annotated-types/annotated-types/
	https://pypi.org/project/annotated-types/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

BDEPEND="
	test? (
		dev-python/pytest-mock[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

python_test() {
	local EPYTEST_DESELECT=()

	case ${EPYTHON} in
		pypy3*)
			EPYTEST_DESELECT+=(
				# https://github.com/annotated-types/annotated-types/issues/71
				'tests/test_main.py::test_predicate_repr[pred2-Predicate(math.isfinite)]'
			)
			;;
	esac

	epytest
}
