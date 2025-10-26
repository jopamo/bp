# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=meson-python
PYTHON_COMPAT=( pypy3_11 python3_{11..14} )

inherit distutils-r1

DESCRIPTION="Python library for calculating contours in 2D quadrilateral grids"
HOMEPAGE="
	https://pypi.org/project/contourpy/
	https://github.com/contourpy/contourpy/
"
SRC_URI="
	https://github.com/contourpy/contourpy/archive/v${PV}.tar.gz
		-> ${P}.gh.tar.gz
"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
	>=dev-python/numpy-1.25[${PYTHON_USEDEP}]
"
BDEPEND="
	>=dev-python/pybind11-2.13.4[${PYTHON_USEDEP}]
	test? (
		dev-py/matplotlib[${PYTHON_USEDEP}]
		xgui-app/pillow[${PYTHON_USEDEP}]
		dev-python/wurlitzer[${PYTHON_USEDEP}]
	)
"

DISTUTILS_ARGS=(
	-Dwerror=false
)

EPYTEST_PLUGINS=( pytest-rerunfailures )
EPYTEST_XDIST=1
distutils_enable_tests pytest

EPYTEST_IGNORE=(
	# linters
	tests/test_codebase.py
)
