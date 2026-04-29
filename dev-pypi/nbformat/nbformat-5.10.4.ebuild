# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="hatchling"

inherit distutils-r1

DESCRIPTION="The Jupyter Notebook format"
HOMEPAGE="https://jupyter.org"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/6d/fd/91545e604bc3dad7dca9ed03284086039b294c6b3d75c0d2fa45f9e9caf3/nbformat-5.10.4.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/nbformat-5.10.4"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/fastjsonschema
	dev-pypi/jsonschema
	dev-pypi/jupyter-core
	dev-pypi/traitlets
"
# lockstep-pypi-deps: end
