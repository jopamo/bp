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

SRC_URI="https://files.pythonhosted.org/packages/53/92/ec9ad04d0b5728dca387a45af7bc98fbb0d73b2118759f5f6038b61a57e8/hf_xet-1.4.3.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/hf_xet-1.4.3"
