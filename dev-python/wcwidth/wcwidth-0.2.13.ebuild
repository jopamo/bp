# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} pypy3_11 )

inherit distutils-r1 pypi

DESCRIPTION="Measures number of Terminal column cells of wide-character codes"
HOMEPAGE="
	https://pypi.org/project/wcwidth/
	https://github.com/jquast/wcwidth/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

distutils_enable_tests pytest

python_test() {
	epytest -o addopts=
}

python_install_all() {
	docinto docs
	dodoc docs/intro.rst
	distutils-r1_python_install_all
}
