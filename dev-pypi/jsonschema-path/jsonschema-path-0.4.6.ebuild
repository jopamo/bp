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

SRC_URI="https://files.pythonhosted.org/packages/01/86/cfee6dd25843bec0760f456599a4f7e7e40221a934b9229fda0662c859bc/jsonschema_path-0.4.6.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/jsonschema_path-0.4.6"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/pathable
	dev-pypi/pyyaml
	dev-pypi/referencing
"
# lockstep-pypi-deps: end

BDEPEND="
	dev-pypi/poetry-core[${PYTHON_USEDEP}]
"
