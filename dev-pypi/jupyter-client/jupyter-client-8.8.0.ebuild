# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="hatchling"

inherit distutils-r1

DESCRIPTION="Jupyter protocol implementation and client libraries"
HOMEPAGE="https://jupyter.org"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/05/e4/ba649102a3bc3fbca54e7239fb924fd434c766f855693d86de0b1f2bec81/jupyter_client-8.8.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/jupyter_client-8.8.0"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/jupyter-core
	dev-pypi/python-dateutil
	dev-pypi/pyzmq
	dev-pypi/tornado
	dev-pypi/traitlets
"
# lockstep-pypi-deps: end
