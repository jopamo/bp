# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Official Python bindings for Selenium WebDriver"
HOMEPAGE="https://www.selenium.dev"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/66/ef/a5727fa7b33d20d296322adf851b76072d8d3513e1b151969d3228437faf/selenium-4.40.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/selenium-4.40.0"

BDEPEND="
	dev-py/setuptools-rust[${PYTHON_USEDEP}]
"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/certifi
	dev-pypi/trio
	dev-pypi/trio-typing
	dev-pypi/trio-websocket
	dev-pypi/types-certifi
	dev-pypi/types-urllib3
	dev-pypi/typing-extensions
	dev-pypi/urllib3
	dev-pypi/websocket-client
"
# lockstep-pypi-deps: end
