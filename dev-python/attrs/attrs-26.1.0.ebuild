# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{11..14} python3_{13,14}t pypy3_11 )

inherit distutils-r1 pypi

DESCRIPTION="Attributes without boilerplate"
HOMEPAGE="
	https://github.com/python-attrs/attrs/
	https://attrs.readthedocs.io/
	https://pypi.org/project/attrs/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

BDEPEND="
	>=dev-python/hatchling-1.26.0[${PYTHON_USEDEP}]
	>=dev-python/hatch-fancy-pypi-readme-23.2.0[${PYTHON_USEDEP}]
	dev-python/hatch-vcs[${PYTHON_USEDEP}]
	test? (
		$(python_gen_impl_dep sqlite)
		$(python_gen_cond_dep '
			dev-python/cloudpickle[${PYTHON_USEDEP}]
		' python3_{11..14})
		$(python_gen_cond_dep '
			dev-python/zope-interface[${PYTHON_USEDEP}]
		' python3_{11..14} pypy3_11)
	)
"

EPYTEST_PLUGINS=( hypothesis )
distutils_enable_tests pytest

python_test() {
	local EPYTEST_DESELECT=()

	case ${EPYTHON} in
		pypy3*)
			EPYTEST_DESELECT+=(
				# https://github.com/python-attrs/attrs/issues/1418
				tests/test_make.py::TestClassBuilder::test_handles_missing_meta_on_class
			)
			;;
	esac

	epytest
}
