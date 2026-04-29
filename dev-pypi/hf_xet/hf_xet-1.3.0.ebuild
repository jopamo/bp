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

SRC_URI="https://files.pythonhosted.org/packages/4f/3a/9aa61729228fb03e946409c51963f0cd2fd7c109f4ab93edc5f04a10be86/hf_xet-1.3.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/hf_xet-1.3.0"
