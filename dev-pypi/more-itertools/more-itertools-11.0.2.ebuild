# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="flit"

inherit distutils-r1 pypi

PYPI_PN="more-itertools"
DESCRIPTION="More routines for operating on iterables, beyond itertools"
HOMEPAGE="https://github.com/more-itertools/more-itertools"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"
