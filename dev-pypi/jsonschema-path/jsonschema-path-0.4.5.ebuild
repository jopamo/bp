# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="poetry"

inherit distutils-r1

DESCRIPTION="JSONSchema Spec with object-oriented paths"
HOMEPAGE="https://pypi.org/project/jsonschema-path/"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/5b/8a/7e6102f2b8bdc6705a9eb5294f8f6f9ccd3a8420e8e8e19671d1dd773251/jsonschema_path-0.4.5.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/jsonschema_path-0.4.5"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/pathable
	dev-pypi/pyyaml
	dev-pypi/referencing
"
# lockstep-pypi-deps: end
