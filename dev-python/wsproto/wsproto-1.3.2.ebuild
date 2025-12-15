# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( pypy3_11 python3_{11..14} )

inherit distutils-r1 pypi

DESCRIPTION="WebSockets state-machine based protocol implementation"
HOMEPAGE="
	https://github.com/python-hyper/wsproto/
	https://pypi.org/project/wsproto/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
	<dev-python/h11-1[${PYTHON_USEDEP}]
	>=dev-python/h11-0.16.0[${PYTHON_USEDEP}]
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
