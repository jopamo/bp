# Distributed under the terms of the GNU General Public License v2

DISTUTILS_USE_PEP517=flit
PYTHON_COMPAT=( python3_{11..14} pypy3_11 )

inherit distutils-r1
# lockstep-pypi-managed: true
# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/mdurl
"
# lockstep-pypi-deps: end
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
	<dev-pypi/linkify-it-py-3[${PYTHON_USEDEP}]
	dev-pypi/mdurl[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		dev-pypi/requests[${PYTHON_USEDEP}]
	)
"

EPYTEST_PLUGINS=( pytest-{datadir,regressions} )
distutils_enable_tests pytest

EPYTEST_IGNORE=(
	# No need to benchmark
	benchmarking/
)
