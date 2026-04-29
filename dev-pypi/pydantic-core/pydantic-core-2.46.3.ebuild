# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="maturin"

inherit distutils-r1

DESCRIPTION="Core functionality for Pydantic validation and serialization"
HOMEPAGE="https://github.com/pydantic/pydantic"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/2a/ef/f7abb56c49382a246fd2ce9c799691e3c3e7175ec74b14d99e798bcddb1a/pydantic_core-2.46.3.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/pydantic_core-2.46.3"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/typing-extensions
"
# lockstep-pypi-deps: end
