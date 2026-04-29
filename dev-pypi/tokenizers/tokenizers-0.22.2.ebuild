# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="maturin"

inherit distutils-r1

DESCRIPTION="Lockstep-managed PyPI dependency tokenizers"
HOMEPAGE="https://github.com/huggingface/tokenizers"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/73/6f/f80cfef4a312e1fb34baf7d85c72d4411afde10978d4657f8cdd811d3ccc/tokenizers-0.22.2.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/tokenizers-0.22.2"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/huggingface-hub
"
# lockstep-pypi-deps: end
