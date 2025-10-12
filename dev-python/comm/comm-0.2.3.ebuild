# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( pypy3_11 python3_{11..14} )

inherit distutils-r1

DESCRIPTION="Jupyter Python Comm implementation, for usage in ipykernel, xeus-python"
HOMEPAGE="
	https://github.com/ipython/comm/
	https://pypi.org/project/comm/
"
# no tests in sdist, as of 0.1.3
SRC_URI="
	https://github.com/ipython/comm/archive/v${PV}.tar.gz
		-> ${P}.gh.tar.gz
"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
