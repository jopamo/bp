# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="hatchling"

inherit distutils-r1

DESCRIPTION="An implementation of JSON Schema validation for Python"
HOMEPAGE="https://github.com/python-jsonschema/jsonschema"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/b3/fc/e067678238fa451312d4c62bf6e6cf5ec56375422aee02f9cb5f909b3047/jsonschema-4.26.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/jsonschema-4.26.0"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/attrs
	dev-pypi/jsonschema-specifications
	dev-pypi/referencing
	dev-pypi/rpds-py
"
# lockstep-pypi-deps: end
