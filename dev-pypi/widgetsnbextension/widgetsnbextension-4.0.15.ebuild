# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Jupyter interactive widgets for Jupyter Notebook"
HOMEPAGE="http://jupyter.org"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/bd/f4/c67440c7fb409a71b7404b7aefcd7569a9c0d6bd071299bf4198ae7a5d95/widgetsnbextension-4.0.15.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/widgetsnbextension-4.0.15"
