# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="flit"

inherit distutils-r1 pypi

PYPI_PN="click"
DESCRIPTION="Composable command line interface toolkit"
HOMEPAGE="https://pypi.org/project/click/"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"
