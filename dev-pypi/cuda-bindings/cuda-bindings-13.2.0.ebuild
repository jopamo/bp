# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Python bindings for CUDA"
HOMEPAGE="https://pypi.org/project/cuda-bindings/"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/1a/fe/7351d7e586a8b4c9f89731bfe4cf0148223e8f9903ff09571f78b3fb0682/cuda_bindings-13.2.0-cp310-cp310-manylinux_2_24_aarch64.manylinux_2_28_aarch64.whl -> ${P}.whl"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/cuda-pathfinder
"
# lockstep-pypi-deps: end
