# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} pypy3_11 )

inherit distutils-r1

DESCRIPTION="Pure python reader and writer of Excel OpenXML files"
HOMEPAGE="
	https://openpyxl.readthedocs.io/en/stable/
	https://foss.heptapod.net/openpyxl/openpyxl/
"
SRC_URI="
	https://foss.heptapod.net/openpyxl/openpyxl/-/archive/${PV}/${P}.tar.bz2
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
	dev-python/et-xmlfile[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		>=dev-py/lxml-5.0.3[${PYTHON_USEDEP}]
		xgui-app/pillow[${PYTHON_USEDEP},tiff,jpeg]
	)
"

distutils_enable_sphinx doc \
	dev-python/sphinx-rtd-theme
distutils_enable_tests pytest

python_test() {
	local EPYTEST_DESELECT=(
		# GC assumptions (pypy)
		openpyxl/tests/test_iter.py::test_file_descriptor_leak
	)

	local -x PYTEST_DISABLE_PLUGIN_AUTOLOAD=1
	epytest
}
