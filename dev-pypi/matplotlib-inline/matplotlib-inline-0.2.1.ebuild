# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="flit"

inherit distutils-r1

DESCRIPTION="Inline Matplotlib backend for Jupyter"
HOMEPAGE="https://github.com/ipython/matplotlib-inline"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/c7/74/97e72a36efd4ae2bccb3463284300f8953f199b5ffbc04cbbb0ec78f74b1/matplotlib_inline-0.2.1.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/matplotlib_inline-0.2.1"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/traitlets
"
# lockstep-pypi-deps: end
