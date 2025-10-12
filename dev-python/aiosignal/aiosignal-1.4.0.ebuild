# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} pypy3_11 )

inherit distutils-r1

DESCRIPTION="A list of registered asynchronous callbacks"
HOMEPAGE="
	https://pypi.org/project/aiosignal/
	https://github.com/aio-libs/aiosignal/
"
SRC_URI="
	https://github.com/aio-libs/aiosignal/archive/v${PV}.tar.gz
		-> ${P}.gh.tar.gz
"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
	>=dev-python/frozenlist-1.1.0[${PYTHON_USEDEP}]
	$(python_gen_cond_dep '
		>=dev-python/typing-extensions-4.2[${PYTHON_USEDEP}]
	' 3.{11..12})
"

EPYTEST_PLUGINS=( pytest-asyncio )
distutils_enable_tests pytest

python_test() {
	epytest -o addopts=
}
