# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="maturin"

inherit distutils-r1 pypi

PYPI_PN="hf-xet"
DESCRIPTION="Fast transfer of large files with the Hugging Face Hub."
HOMEPAGE="https://github.com/huggingface/xet-core"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"
