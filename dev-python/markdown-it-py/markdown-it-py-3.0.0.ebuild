# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=flit
PYTHON_COMPAT=( python3_{11..14} pypy3_11 )

inherit distutils-r1

DESCRIPTION="Python port of markdown-it, Markdown parser"
HOMEPAGE="
	https://pypi.org/project/markdown-it-py/
	https://github.com/executablebooks/markdown-it-py/
"
SRC_URI="
	https://github.com/executablebooks/markdown-it-py/archive/v${PV}.tar.gz
		-> ${P}.gh.tar.gz
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
	<dev-python/linkify-it-py-3[${PYTHON_USEDEP}]
	dev-python/mdurl[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		dev-python/pytest-regressions[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

EPYTEST_IGNORE=(
	# No need to benchmark
	benchmarking/
)
