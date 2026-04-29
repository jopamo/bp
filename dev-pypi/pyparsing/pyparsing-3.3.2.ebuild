# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="flit"

inherit distutils-r1 pypi

PYPI_PN="pyparsing"
DESCRIPTION="pyparsing - Classes and methods to define and execute parsing grammars"
HOMEPAGE="https://github.com/pyparsing/pyparsing/"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"
