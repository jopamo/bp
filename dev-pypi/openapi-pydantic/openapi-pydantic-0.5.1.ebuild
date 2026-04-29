# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="poetry"

inherit distutils-r1

DESCRIPTION="Pydantic OpenAPI schema implementation"
HOMEPAGE="https://github.com/mike-oakley/openapi-pydantic"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/02/2e/58d83848dd1a79cb92ed8e63f6ba901ca282c5f09d04af9423ec26c56fd7/openapi_pydantic-0.5.1.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/openapi_pydantic-0.5.1"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/pydantic
"
# lockstep-pypi-deps: end
