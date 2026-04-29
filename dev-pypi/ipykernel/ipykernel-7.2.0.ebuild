# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="hatchling"

inherit distutils-r1

DESCRIPTION="IPython Kernel for Jupyter"
HOMEPAGE="https://ipython.org"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/ca/8d/b68b728e2d06b9e0051019640a40a9eb7a88fcd82c2e1b5ce70bef5ff044/ipykernel-7.2.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/ipykernel-7.2.0"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/comm
	dev-pypi/debugpy
	dev-pypi/ipython
	dev-pypi/jupyter-client
	dev-pypi/jupyter-core
	dev-pypi/matplotlib-inline
	dev-pypi/nest-asyncio
	dev-pypi/packaging
	dev-pypi/psutil
	dev-pypi/pyzmq
	dev-pypi/tornado
	dev-pypi/traitlets
"
# lockstep-pypi-deps: end
