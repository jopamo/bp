# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Pathfinder for CUDA components"
HOMEPAGE="https://github.com/NVIDIA/cuda-python"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://github.com/NVIDIA/cuda-python/archive/refs/tags/cuda-pathfinder-v1.5.4.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/cuda-python-cuda-pathfinder-v1.5.4/cuda_pathfinder"

BDEPEND="
	dev-pypi/setuptools-scm[${PYTHON_USEDEP}]
	dev-pypi/setuptools[${PYTHON_USEDEP}]
	dev-pypi/wheel[${PYTHON_USEDEP}]
"
