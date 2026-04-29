# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1 pypi

PYPI_PN="huggingface-hub"
DESCRIPTION="Client library to download and publish models, datasets and other repos on the huggingface.co hub"
HOMEPAGE="https://github.com/huggingface/huggingface_hub"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

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
