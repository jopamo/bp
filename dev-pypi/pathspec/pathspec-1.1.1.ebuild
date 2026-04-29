# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="flit"

inherit distutils-r1 pypi

PYPI_PN="pathspec"
DESCRIPTION="Utility library for gitignore style pattern matching of file paths."
HOMEPAGE="https://pypi.org/project/pathspec/"
LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"
