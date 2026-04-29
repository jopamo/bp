# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="hatchling"

inherit distutils-r1 pypi

PYPI_PN="comm"
DESCRIPTION="Jupyter Python Comm implementation, for usage in ipykernel, xeus-python etc."
HOMEPAGE="https://github.com/ipython/comm"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"
