# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="hatchling"

inherit distutils-r1 pypi

PYPI_PN="execnet"
DESCRIPTION="execnet: rapid multi-Python deployment"
HOMEPAGE="https://execnet.readthedocs.io/en/latest/"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"
