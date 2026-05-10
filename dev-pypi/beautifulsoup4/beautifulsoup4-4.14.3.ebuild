# Distributed under the terms of the GNU General Public License v2

PYTHON_COMPAT=( python3_{11..14} )
DISTUTILS_USE_PEP517=hatchling

inherit distutils-r1 pypi
# lockstep-pypi-managed: true
# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/soupsieve
	dev-pypi/typing-extensions
"
# lockstep-pypi-deps: end
DESCRIPTION="Screen-scraping library"
HOMEPAGE="https://www.crummy.com/software/BeautifulSoup/bs4/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
	>=dev-pypi/soupsieve-1.6.1[${PYTHON_USEDEP}]
	>=dev-pypi/typing-extensions-4[${PYTHON_USEDEP}]
"
