# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYPI_PN=${PN^}
PYTHON_COMPAT=( python3_{10..13} pypy3 pypy3_11 )

inherit distutils-r1 pypi

DESCRIPTION="Pygments is a syntax highlighting package written in Python"
HOMEPAGE="
	https://pygments.org/
	https://github.com/pygments/pygments/
	https://pypi.org/project/Pygments/
"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="amd64 arm64"

BDEPEND="
	test? (
		dev-py/lxml[${PYTHON_USEDEP}]
		xgui-app/pillow[${PYTHON_USEDEP}]
		dev-python/wcag-contrast-ratio[${PYTHON_USEDEP}]
		virtual/ttf-fonts
	)
"

EPYTEST_DESELECT=(
	# fuzzing tests, very slow
	tests/test_basic_api.py::test_random_input
	# incompatibility with python-ctags3, apparently
	# https://github.com/pygments/pygments/issues/2486
	tests/test_html_formatter.py::test_ctags
)

EPYTEST_XDIST=1
distutils_enable_tests pytest

src_install() {
	distutils-r1_src_install
}
