# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="maturin"

inherit distutils-r1

DESCRIPTION="Core functionality for Pydantic validation and serialization"
HOMEPAGE="https://github.com/pydantic/pydantic-core"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/71/70/23b021c950c2addd24ec408e9ab05d59b035b39d97cdc1130e1bce647bb6/pydantic_core-2.41.5.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/pydantic_core-2.41.5"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/typing-extensions
"
# lockstep-pypi-deps: end
