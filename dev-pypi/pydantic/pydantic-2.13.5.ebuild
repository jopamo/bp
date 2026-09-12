# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="hatchling"

inherit distutils-r1

DESCRIPTION="Data validation using Python type hints"
HOMEPAGE="https://github.com/pydantic/pydantic"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/53/ef/fc4f868f4e2cee79f863883abffceff107875f569b848507319842d2a681/pydantic-2.13.5.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/pydantic-2.13.5"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/annotated-types
	dev-pypi/pydantic-core
	dev-pypi/typing-extensions
	dev-pypi/typing-inspection
"
# lockstep-pypi-deps: end

BDEPEND="
	dev-pypi/gpep517[${PYTHON_USEDEP}]
	dev-pypi/hatch-fancy-pypi-readme[${PYTHON_USEDEP}]
	dev-pypi/hatchling[${PYTHON_USEDEP}]
"
