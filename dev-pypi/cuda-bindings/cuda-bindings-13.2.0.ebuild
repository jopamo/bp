# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Python bindings for CUDA"
HOMEPAGE="https://github.com/NVIDIA/cuda-python"
LICENSE="LicenseRef-NVIDIA-SOFTWARE-LICENSE"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://github.com/NVIDIA/cuda-python/archive/refs/tags/v13.2.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/cuda-python-13.2.0/cuda_bindings"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/cuda-pathfinder
"
# lockstep-pypi-deps: end

BDEPEND="
	dev-pypi/cython[${PYTHON_USEDEP}]
	dev-pypi/pyclibrary[${PYTHON_USEDEP}]
	dev-pypi/setuptools-scm[${PYTHON_USEDEP}]
	dev-pypi/setuptools[${PYTHON_USEDEP}]
"
