# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="hatchling"

inherit distutils-r1 pypi

PYPI_PN="ipykernel"
DESCRIPTION="IPython Kernel for Jupyter"
HOMEPAGE="https://ipython.org"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

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
