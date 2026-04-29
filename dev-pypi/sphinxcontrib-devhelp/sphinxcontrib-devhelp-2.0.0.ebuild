# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="flit"

inherit distutils-r1

DESCRIPTION="sphinxcontrib-devhelp is a sphinx extension which outputs Devhelp documents"
HOMEPAGE="https://www.sphinx-doc.org/"
LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/f6/d2/5beee64d3e4e747f316bae86b55943f51e82bb86ecd325883ef65741e7da/sphinxcontrib_devhelp-2.0.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/sphinxcontrib_devhelp-2.0.0"
