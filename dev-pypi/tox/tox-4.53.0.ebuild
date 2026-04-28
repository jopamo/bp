# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="hatchling"

inherit distutils-r1 pypi

PYPI_PN="tox"
DESCRIPTION="tox is a generic virtualenv management and test command line tool"
HOMEPAGE="http://tox.readthedocs.org"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/pyproject-api
	dev-pypi/python-discovery
	dev-python/cachetools
	dev-python/colorama
	dev-python/filelock
	dev-python/packaging
	dev-python/platformdirs
	dev-python/pluggy
	dev-python/tomli-w
	dev-python/virtualenv
"
# lockstep-pypi-deps: end
