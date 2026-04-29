# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Accelerate"
HOMEPAGE="https://github.com/huggingface/accelerate"
LICENSE="Apache"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/ca/14/787e5498cd062640f0f3d92ef4ae4063174f76f9afd29d13fc52a319daae/accelerate-1.13.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/accelerate-1.13.0"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-py/pytorch
	dev-pypi/huggingface-hub
	dev-pypi/numpy
	dev-pypi/packaging
	dev-pypi/psutil
	dev-pypi/pyyaml
	dev-pypi/safetensors
"
# lockstep-pypi-deps: end
