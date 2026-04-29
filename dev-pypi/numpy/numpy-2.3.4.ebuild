# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="meson-python"

inherit distutils-r1 pypi

PYPI_PN="numpy"
DESCRIPTION="Fundamental package for array computing in Python"
HOMEPAGE="https://numpy.org"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"
