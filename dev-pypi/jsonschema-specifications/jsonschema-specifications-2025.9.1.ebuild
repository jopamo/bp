# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="hatchling"

inherit distutils-r1

DESCRIPTION="The JSON Schema meta-schemas and vocabularies, exposed as a Registry"
HOMEPAGE="https://github.com/python-jsonschema/jsonschema-specifications"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/19/74/a633ee74eb36c44aa6d1095e7cc5569bebf04342ee146178e2d36600708b/jsonschema_specifications-2025.9.1.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/jsonschema_specifications-2025.9.1"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/referencing
"
# lockstep-pypi-deps: end
