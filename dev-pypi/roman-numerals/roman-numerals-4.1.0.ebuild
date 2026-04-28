# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="flit"

inherit distutils-r1 pypi

PYPI_PN="roman-numerals"
DESCRIPTION="Manipulate well-formed Roman numerals"
HOMEPAGE="https://pypi.org/project/roman-numerals/"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"
