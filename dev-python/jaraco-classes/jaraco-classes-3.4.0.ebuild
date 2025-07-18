# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYPI_NO_NORMALIZE=1
PYPI_PN=${PN/-/.}
PYTHON_COMPAT=( pypy3_11 python3_{11..14} python3_{13,14}t )

inherit distutils-r1 pypi

DESCRIPTION="Classes used by other projects by developer jaraco"
HOMEPAGE="
	https://github.com/jaraco/jaraco.classes/
	https://pypi.org/project/jaraco.classes/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

BDEPEND="
	dev-py/setuptools-scm[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest
