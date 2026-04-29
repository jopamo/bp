# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Client library to download and publish models, datasets and other repos on the huggingface.co hub"
HOMEPAGE="https://github.com/huggingface/huggingface_hub"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/56/52/1b54cb569509c725a32c1315261ac9fd0e6b91bbbf74d86fca10d3376164/huggingface_hub-1.12.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/huggingface_hub-1.12.0"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/filelock
	dev-pypi/fsspec
	dev-pypi/hf-xet
	dev-pypi/httpx
	dev-pypi/packaging
	dev-pypi/pyyaml
	dev-pypi/tqdm
	dev-pypi/typer
	dev-pypi/typing-extensions
"
# lockstep-pypi-deps: end
