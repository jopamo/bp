# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1

DESCRIPTION="NVIDIA CUDA Python Bindings"
HOMEPAGE="https://github.com/NVIDIA/cuda-python"
SNAPSHOT=e06b2993dc446a695197ead58033c658bf6b5eeb
SRC_URI="https://github.com/NVIDIA/cuda-python/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}/cuda_python"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

RESTRICT="test network-sandbox"

BDEPEND=">=dev-py/setuptools-rust-1.7.0[${PYTHON_USEDEP}]"
