# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="hatchling"

inherit distutils-r1

DESCRIPTION="Data validation using Python type hints"
HOMEPAGE="https://github.com/pydantic/pydantic"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/69/44/36f1a6e523abc58ae5f928898e4aca2e0ea509b5aa6f6f392a5d882be928/pydantic-2.12.5.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/pydantic-2.12.5"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/annotated-types
	dev-pypi/pydantic-core
	dev-pypi/typing-extensions
	dev-pypi/typing-inspection
"
# lockstep-pypi-deps: end
