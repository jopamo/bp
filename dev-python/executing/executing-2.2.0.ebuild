# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_TESTED=( pypy3 python3_{10..13} )
PYTHON_COMPAT=( "${PYTHON_TESTED[@]}" pypy3_11 )

inherit distutils-r1 

DESCRIPTION="Get information about what a Python frame is currently doing"
HOMEPAGE="
	https://github.com/alexmojaki/executing/
	https://pypi.org/project/executing/
"
SRC_URI="
	https://github.com/alexmojaki/executing/archive/v${PV}.tar.gz
		-> ${P}.gh.tar.gz
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

BDEPEND="
	dev-py/setuptools-scm[${PYTHON_USEDEP}]
	test? (
		>=dev-python/asttokens-2.1.0[${PYTHON_USEDEP}]
		dev-python/littleutils[${PYTHON_USEDEP}]
		dev-python/rich[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

export SETUPTOOLS_SCM_PRETEND_VERSION=${PV}

python_test() {
	if ! has "${EPYTHON}" "${PYTHON_TESTED[@]/_/.}"; then
		einfo "Skipping tests on ${EPYTHON}"
		return
	fi

	local EPYTEST_DESELECT=()
	case ${EPYTHON} in
		pypy3)
			EPYTEST_DESELECT+=(
				"tests/test_main.py::test_small_samples[22bc344a43584c051d8962116e8fd149d72e7e68bcb54caf201ee6e78986b167.py]"
				"tests/test_main.py::test_small_samples[46597f8f896f11c5d7f432236344cc7e5645c2a39836eb6abdd2437c0422f0f4.py]"
			)
			;;
	esac
	if ! has_version "dev-python/ipython[${PYTHON_USEDEP}]"; then
		EPYTEST_DESELECT+=(
			tests/test_ipython.py
		)
	fi

	local -x PYTEST_DISABLE_PLUGIN_AUTOLOAD=1
	epytest
}

pkg_postinst() {
 "getting node's source code" dev-python/asttokens
}
