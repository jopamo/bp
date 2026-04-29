# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="poetry"

inherit distutils-r1 pypi

PYPI_PN="jsonschema-path"
DESCRIPTION="JSONSchema Spec with object-oriented paths"
HOMEPAGE="https://pypi.org/project/jsonschema-path/"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/pathable
	dev-pypi/pyyaml
	dev-pypi/referencing
"
# lockstep-pypi-deps: end
