# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="flit"

inherit distutils-r1 pypi

PYPI_PN="mypy-extensions"
DESCRIPTION="Type system extensions for programs checked with the mypy type checker."
HOMEPAGE="https://github.com/python/mypy_extensions"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"
