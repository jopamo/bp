# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1 pypi

DESCRIPTION="Python bindings for CUDA"
HOMEPAGE="https://pypi.org/project/cuda-bindings/ https://github.com/NVIDIA/cuda-python"
SRC_URI="https://github.com/NVIDIA/cuda-python/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/cuda-python-${PV}/cuda_bindings"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

PYPI_PN="cuda-bindings"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/cuda-pathfinder
"
# lockstep-pypi-deps: end
