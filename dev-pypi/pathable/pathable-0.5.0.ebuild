# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="poetry"

inherit distutils-r1 pypi

PYPI_PN="pathable"
DESCRIPTION="Object-oriented paths"
HOMEPAGE="https://pypi.org/project/pathable/"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"
