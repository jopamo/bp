# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1 pypi

PYPI_PN="cheroot"
DESCRIPTION="Highly-optimized, pure-python HTTP server"
HOMEPAGE="https://cheroot.cherrypy.dev"
LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/jaraco-functools
	dev-pypi/more-itertools
"
# lockstep-pypi-deps: end
