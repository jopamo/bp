# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="hatchling"

inherit distutils-r1 pypi

PYPI_PN="colorama"
DESCRIPTION="Cross-platform colored terminal text."
HOMEPAGE="https://github.com/tartley/colorama"
LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"
