# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} pypy3_11 )

inherit distutils-r1 pypi

DESCRIPTION="Python attributes without the boilerplate"
HOMEPAGE="
	https://characteristic.readthedocs.io/
	https://github.com/hynek/characteristic/
	https://pypi.org/project/characteristic/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

distutils_enable_tests pytest
distutils_enable_sphinx docs

python_prepare_all() {
	sed -e 's|\[pytest\]|\[tool:pytest\]|' -i setup.cfg || die
	distutils-r1_python_prepare_all
}
