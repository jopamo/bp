# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="hatchling"

inherit distutils-r1 pypi

PYPI_PN="jsonschema"
DESCRIPTION="An implementation of JSON Schema validation for Python"
HOMEPAGE="https://github.com/python-jsonschema/jsonschema"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/attrs
	dev-pypi/jsonschema-specifications
	dev-pypi/referencing
	dev-pypi/rpds-py
"
# lockstep-pypi-deps: end
