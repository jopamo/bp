# Distributed under the terms of the GNU General Public License v2

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{11..14} pypy3_11 )

inherit distutils-r1
# lockstep-pypi-managed: true
# lockstep-pypi-deps: begin
RDEPEND+="
"
# lockstep-pypi-deps: end
DESCRIPTION="A modern CSS selector implementation for BeautifulSoup"
HOMEPAGE="
	https://github.com/facelessuser/soupsieve/
	https://pypi.org/project/soupsieve/
"
SRC_URI="
	https://github.com/facelessuser/soupsieve/archive/${PV}.tar.gz
		-> ${P}.gh.tar.gz
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

BDEPEND="
	test? (
		dev-py/beautifulsoup4[${PYTHON_USEDEP}]
		dev-py/lxml[${PYTHON_USEDEP}]
		dev-py/html5lib[${PYTHON_USEDEP}]
	)
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
