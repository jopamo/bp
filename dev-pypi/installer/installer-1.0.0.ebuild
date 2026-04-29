# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="flit"

inherit distutils-r1

DESCRIPTION="A library for installing Python wheels."
HOMEPAGE="https://pypi.org/project/installer/"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/5f/ef/230b70e66db6ab01d5cbb93329688ed1f06b2b0618a74925e36384ff0fba/installer-1.0.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/installer-1.0.0"
