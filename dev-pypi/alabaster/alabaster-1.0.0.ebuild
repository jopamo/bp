# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="flit"

inherit distutils-r1

DESCRIPTION="A light, configurable Sphinx theme"
HOMEPAGE="https://alabaster.readthedocs.io/"
LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/a6/f8/d9c74d0daf3f742840fd818d69cfae176fa332022fd44e3469487d5a9420/alabaster-1.0.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/alabaster-1.0.0"
