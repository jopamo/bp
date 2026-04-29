# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Immutable Collections"
HOMEPAGE="https://pypi.org/project/immutables/"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/69/41/0ccaa6ef9943c0609ec5aa663a3b3e681c1712c1007147b84590cec706a0/immutables-0.21.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/immutables-0.21"
