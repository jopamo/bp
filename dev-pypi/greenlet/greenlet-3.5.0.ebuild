# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Lightweight in-process concurrent programming"
HOMEPAGE="https://greenlet.readthedocs.io"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/3c/3f/dbf99fb14bfeb88c28f16729215478c0e265cacd6dc22270c8f31bb6892f/greenlet-3.5.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/greenlet-3.5.0"

BDEPEND="
	dev-pypi/setuptools[${PYTHON_USEDEP}]
"
