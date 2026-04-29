# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Typing stubs for setuptools"
HOMEPAGE="https://github.com/python/typeshed"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/4b/90/796ac8c774a7f535084aacbaa6b7053d16fff5c630eff87c3ecff7896c37/types_setuptools-82.0.0.20260210.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/types_setuptools-82.0.0.20260210"
