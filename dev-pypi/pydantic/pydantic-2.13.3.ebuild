# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="hatchling"

inherit distutils-r1 pypi

PYPI_PN="pydantic"
DESCRIPTION="Data validation using Python type hints"
HOMEPAGE="https://github.com/pydantic/pydantic"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/annotated-types
	dev-pypi/pydantic-core
	dev-pypi/typing-extensions
	dev-pypi/typing-inspection
"
# lockstep-pypi-deps: end
