# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="flit"

inherit distutils-r1

DESCRIPTION="sphinxcontrib-qthelp is a sphinx extension which outputs QtHelp documents"
HOMEPAGE="https://www.sphinx-doc.org/"
LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/68/bc/9104308fc285eb3e0b31b67688235db556cd5b0ef31d96f30e45f2e51cae/sphinxcontrib_qthelp-2.0.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/sphinxcontrib_qthelp-2.0.0"
