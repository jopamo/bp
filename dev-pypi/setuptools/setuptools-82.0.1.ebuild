# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1 pypi

PYPI_PN="setuptools"
DESCRIPTION="Most extensible Python build backend with support for C/C++ extension modules"
HOMEPAGE="https://pypi.org/project/setuptools/"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"
