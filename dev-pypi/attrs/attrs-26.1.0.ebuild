# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="hatchling"

inherit distutils-r1 pypi

PYPI_PN="attrs"
DESCRIPTION="Classes Without Boilerplate"
HOMEPAGE="https://pypi.org/project/attrs/"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"
