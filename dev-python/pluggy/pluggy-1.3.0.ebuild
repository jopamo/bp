# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1 pypi

DESCRIPTION="Plugin and hook calling mechanisms for Python"
HOMEPAGE="
	https://pluggy.readthedocs.io/
	https://github.com/pytest-dev/pluggy/
	https://pypi.org/project/pluggy/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

BDEPEND="
	dev-python/wheel[${PYTHON_USEDEP}]
	dev-python/setuptools-scm[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest
