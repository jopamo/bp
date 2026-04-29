# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="maturin"

inherit distutils-r1

DESCRIPTION="Fast transfer of large files with the Hugging Face Hub."
HOMEPAGE="https://github.com/huggingface/xet-core"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/5e/6e/0f11bacf08a67f7fb5ee09740f2ca54163863b07b70d579356e9222ce5d8/hf_xet-1.2.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/hf_xet-1.2.0"
