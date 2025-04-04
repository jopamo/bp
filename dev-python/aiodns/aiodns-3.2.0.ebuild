# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( pypy3 pypy3_11 python3_{10..13} )

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

RDEPEND=">=dev-python/pycares-3[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"

distutils_enable_tests pytest

python_test() {
	local EPYTEST_DESELECT=(
		# Internet changed, https://github.com/aio-libs/aiodns/issues/107
		tests.py::DNSTest::test_query_bad_chars
	)

	epytest tests.py
}
