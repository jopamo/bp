# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
# lockstep-pypi-deps: begin
RDEPEND+="
"
# lockstep-pypi-deps: end
EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="hatchling"

inherit distutils-r1 pypi

PYPI_PN="docstring-parser"
DESCRIPTION="Parse Python docstrings in reST, Google and Numpydoc format"
HOMEPAGE="https://github.com/rr-/docstring_parser"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"
