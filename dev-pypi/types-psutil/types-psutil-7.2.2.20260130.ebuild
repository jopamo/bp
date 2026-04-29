# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Typing stubs for psutil"
HOMEPAGE="https://github.com/python/typeshed"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/69/14/fc5fb0a6ddfadf68c27e254a02ececd4d5c7fdb0efcb7e7e917a183497fb/types_psutil-7.2.2.20260130.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/types_psutil-7.2.2.20260130"
