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

SRC_URI="https://files.pythonhosted.org/packages/9d/56/921726b776ace8d8f5db44c4ef961006580d91dc52b803c489fafd1aa249/pydantic_core-2.46.4.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/pydantic_core-2.46.4"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/typing-extensions
"
# lockstep-pypi-deps: end

BDEPEND="
	app-dev/maturin[${PYTHON_USEDEP}]
"
