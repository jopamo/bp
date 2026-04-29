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

SRC_URI="https://files.pythonhosted.org/packages/1c/46/fb6854cec3278fbfa4a75b50232c77622bc517ac886156e6afbfa4d8fc6e/tokenizers-0.22.1.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/tokenizers-0.22.1"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/huggingface-hub
"
# lockstep-pypi-deps: end
