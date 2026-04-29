# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="A clean customisable Sphinx documentation theme."
HOMEPAGE="https://pypi.org/project/furo/"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/ec/20/5f5ad4da6a5a27c80f2ed2ee9aee3f9e36c66e56e21c00fde467b2f8f88f/furo-2025.12.19.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/furo-2025.12.19"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/accessible-pygments
	dev-pypi/beautifulsoup4
	dev-pypi/pygments
	dev-pypi/sphinx
	dev-pypi/sphinx-basic-ng
"
# lockstep-pypi-deps: end
