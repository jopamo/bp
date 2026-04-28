# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="maturin"

inherit distutils-r1 pypi

PYPI_PN="pydantic-core"
DESCRIPTION="Core functionality for Pydantic validation and serialization"
HOMEPAGE="https://github.com/pydantic/pydantic-core"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-python/typing-extensions
"
# lockstep-pypi-deps: end
