# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1 pypi

PYPI_PN="isoduration"
DESCRIPTION="Operations with ISO 8601 durations"
HOMEPAGE="https://github.com/bolsote/isoduration"
LICENSE="ISC"
SLOT="0"
KEYWORDS="amd64 arm64"
