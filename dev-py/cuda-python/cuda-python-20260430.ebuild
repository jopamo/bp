# Distributed under the terms of the GNU General Public License v2

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1
# lockstep-pypi-managed: true
# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/cuda-bindings
	dev-pypi/cuda-pathfinder
"
# lockstep-pypi-deps: end

DESCRIPTION="NVIDIA CUDA Python Bindings"
HOMEPAGE="https://github.com/NVIDIA/cuda-python"
SNAPSHOT=f77e0c823e3bce21ebd06a4b186ad573dd25cad7
SRC_URI="https://github.com/NVIDIA/cuda-python/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}/cuda_python"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

RESTRICT="test network-sandbox"

BDEPEND=">=dev-py/setuptools-rust-1.7.0[${PYTHON_USEDEP}]"
