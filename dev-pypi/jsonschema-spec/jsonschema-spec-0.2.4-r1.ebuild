# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="poetry"

inherit distutils-r1

DESCRIPTION="JSONSchema Spec with object-oriented paths"
HOMEPAGE="https://github.com/p1c2u/jsonschema-spec"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/85/bf/5e9a059f611e8950eec986385892f9d596e4936fa58a37bf295789197f77/jsonschema_spec-0.2.4.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/jsonschema_spec-0.2.4"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/pathable
	dev-pypi/pyyaml
	dev-pypi/referencing
	dev-pypi/requests
"
# lockstep-pypi-deps: end
