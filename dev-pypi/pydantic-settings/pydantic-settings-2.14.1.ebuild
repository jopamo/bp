# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="hatchling"

inherit distutils-r1

DESCRIPTION="Settings management using Pydantic"
HOMEPAGE="https://github.com/pydantic/pydantic-settings"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/07/60/1d1e59c9c90d54591469ada7d268251f71c24bdb765f1a8a832cee8c6653/pydantic_settings-2.14.1.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/pydantic_settings-2.14.1"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/pydantic
	dev-pypi/python-dotenv
	dev-pypi/typing-inspection
"
# lockstep-pypi-deps: end

BDEPEND="
	dev-pypi/hatchling[${PYTHON_USEDEP}]
"
