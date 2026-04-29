# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1 pypi

PYPI_PN="path"
DESCRIPTION="A module wrapper for os.path"
HOMEPAGE="https://pypi.org/project/path/"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"
