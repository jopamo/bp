# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="hatchling"

inherit distutils-r1

DESCRIPTION="Jupyter core package. A base package on which Jupyter projects rely."
HOMEPAGE="https://jupyter.org"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/02/49/9d1284d0dc65e2c757b74c6687b6d319b02f822ad039e5c512df9194d9dd/jupyter_core-5.9.1.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/jupyter_core-5.9.1"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/platformdirs
	dev-pypi/traitlets
"
# lockstep-pypi-deps: end
