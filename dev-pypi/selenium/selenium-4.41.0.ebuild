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

SRC_URI="https://files.pythonhosted.org/packages/04/7c/133d00d6d013a17d3f39199f27f1a780ec2e95d7b9aa997dc1b8ac2e62a7/selenium-4.41.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/selenium-4.41.0"

BDEPEND="
	dev-py/setuptools-rust[${PYTHON_USEDEP}]
"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/certifi
	dev-pypi/trio
	dev-pypi/trio-websocket
	dev-pypi/typing-extensions
	dev-pypi/urllib3
	dev-pypi/websocket-client
"
# lockstep-pypi-deps: end
