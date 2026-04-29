# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Fastest Python implementation of JSON schema"
HOMEPAGE="https://github.com/horejsek/python-fastjsonschema"
LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/20/b5/23b216d9d985a956623b6bd12d4086b60f0059b27799f23016af04a74ea1/fastjsonschema-2.21.2.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/fastjsonschema-2.21.2"
