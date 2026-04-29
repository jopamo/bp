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

SRC_URI="https://files.pythonhosted.org/packages/d9/e4/40d09941a2cebcb20609b86a559817d5b9291c49dd6f8c87e5feffbe703a/pydantic-2.13.3.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/pydantic-2.13.3"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/annotated-types
	dev-pypi/pydantic-core
	dev-pypi/typing-extensions
	dev-pypi/typing-inspection
"
# lockstep-pypi-deps: end
