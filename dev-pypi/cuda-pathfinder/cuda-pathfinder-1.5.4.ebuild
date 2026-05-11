# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Pathfinder for CUDA components"
HOMEPAGE="https://pypi.org/project/cuda-pathfinder/"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/11/d0/c177e29701cf1d3008d7d2b16b5fc626592ce13bd535f8795c5f57187e0e/cuda_pathfinder-1.5.4-py3-none-any.whl -> ${P}.whl"
