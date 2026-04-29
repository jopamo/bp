# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="flit"

inherit distutils-r1 pypi

PYPI_PN="flask"
DESCRIPTION="A simple framework for building complex web applications."
HOMEPAGE="https://pypi.org/project/flask/"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/blinker
	dev-pypi/click
	dev-pypi/itsdangerous
	dev-pypi/jinja2
	dev-pypi/markupsafe
	dev-pypi/werkzeug
"
# lockstep-pypi-deps: end
