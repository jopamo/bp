# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( pypy3_11 python3_{11..14} )

inherit distutils-r1 pypi

DESCRIPTION="Simple DNS resolver for asyncio"
HOMEPAGE="
	https://pypi.org/project/aiodns/
	https://github.com/aio-libs/aiodns/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"
# Tests fail with network-sandbox, since they try to resolve google.com
PROPERTIES="test_network"
RESTRICT="test"

RDEPEND=">=dev-python/pycares-4.9.0[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
BDEPEND="
	dev-python/pytest-asyncio[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest

python_test() {
	local -x PYTEST_DISABLE_PLUGIN_AUTOLOAD=1
	epytest -p asyncio --asyncio-mode=auto
}
