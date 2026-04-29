# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="flit"

inherit distutils-r1

DESCRIPTION="The PyPA recommended tool for installing Python packages."
HOMEPAGE="https://pip.pypa.io/"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/73/7e/d2b04004e1068ad4fdfa2f227b839b5d03e602e47cdbbf49de71137c9546/pip-26.1.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/pip-26.1"
