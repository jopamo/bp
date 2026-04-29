# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Transformers: the model-definition framework for state-of-the-art machine learning models in text, vision, audio, and multimodal models, for both inference and training."
HOMEPAGE="https://github.com/huggingface/transformers"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/fc/1a/70e830d53ecc96ce69cfa8de38f163712d2b43ac52fbd743f39f56025c31/transformers-5.3.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/transformers-5.3.0"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/huggingface-hub
	dev-pypi/numpy
	dev-pypi/packaging
	dev-pypi/pyyaml
	dev-pypi/regex
	dev-pypi/safetensors
	dev-pypi/tokenizers
	dev-pypi/tqdm
	dev-pypi/typer
"
# lockstep-pypi-deps: end
