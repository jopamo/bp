# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Typing stubs for certifi"
HOMEPAGE="https://github.com/python/typeshed"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/52/68/943c3aeaf14624712a0357c4a67814dba5cea36d194f5c764dad7959a00c/types-certifi-2021.10.8.3.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/types-certifi-2021.10.8.3"
