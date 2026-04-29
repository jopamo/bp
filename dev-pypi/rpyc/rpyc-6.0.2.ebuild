# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="hatchling"

inherit distutils-r1 pypi

PYPI_PN="rpyc"
DESCRIPTION="Remote Python Call (RPyC) is a transparent and symmetric distributed computing library"
HOMEPAGE="https://rpyc.readthedocs.org"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/plumbum
"
# lockstep-pypi-deps: end
