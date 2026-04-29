# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1 pypi

PYPI_PN="invoke"
DESCRIPTION="Pythonic task execution"
HOMEPAGE="https://pypi.org/project/invoke/"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"
