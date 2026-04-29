# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="hatchling"

inherit distutils-r1 pypi

PYPI_PN="intervaltree"
DESCRIPTION="Editable interval tree data structure for Python 2 and 3"
HOMEPAGE="https://github.com/chaimleib/intervaltree"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/sortedcontainers
"
# lockstep-pypi-deps: end
