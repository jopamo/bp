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

PYPI_PN="legacy-cgi"
DESCRIPTION="Fork of the standard library cgi and cgitb modules removed in Python 3.13"
HOMEPAGE="https://pypi.org/project/legacy-cgi/"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"
