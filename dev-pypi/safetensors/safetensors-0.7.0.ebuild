# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="maturin"

inherit distutils-r1 pypi

PYPI_PN="safetensors"
DESCRIPTION="Lockstep-managed PyPI dependency safetensors"
HOMEPAGE="https://github.com/huggingface/safetensors"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"
