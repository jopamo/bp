# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1 pypi

DESCRIPTION="Pathfinder for CUDA components"
HOMEPAGE="https://pypi.org/project/cuda-pathfinder/ https://github.com/NVIDIA/cuda-python"
SRC_URI="https://github.com/NVIDIA/cuda-python/archive/refs/tags/cuda-pathfinder-v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/cuda-python-cuda-pathfinder-v${PV}/cuda_pathfinder"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

PYPI_PN="cuda-pathfinder"
