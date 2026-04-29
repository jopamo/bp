# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="hatchling"

inherit distutils-r1 pypi

PYPI_PN="jsonschema-specifications"
DESCRIPTION="The JSON Schema meta-schemas and vocabularies, exposed as a Registry"
HOMEPAGE="https://github.com/python-jsonschema/jsonschema-specifications"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/referencing
"
# lockstep-pypi-deps: end
