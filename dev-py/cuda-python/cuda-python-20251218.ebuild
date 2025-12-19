# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1

DESCRIPTION="NVIDIA CUDA Python Bindings"
HOMEPAGE="https://github.com/NVIDIA/cuda-python"
SNAPSHOT=51b9c6c4a6ba10ec123b702b39e36b4de0da19d9
SRC_URI="https://github.com/NVIDIA/cuda-python/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}/cuda_python"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

RESTRICT="test network-sandbox"

BDEPEND=">=dev-py/setuptools-rust-1.7.0[${PYTHON_USEDEP}]"
