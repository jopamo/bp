# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="hatchling"

inherit distutils-r1

DESCRIPTION="Screen-scraping library"
HOMEPAGE="https://www.crummy.com/software/BeautifulSoup/bs4/"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/c3/b0/1c6a16426d389813b48d95e26898aff79abbde42ad353958ad95cc8c9b21/beautifulsoup4-4.14.3.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/beautifulsoup4-4.14.3"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/soupsieve
	dev-pypi/typing-extensions
"
# lockstep-pypi-deps: end
