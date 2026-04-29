# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

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
	dev-pypi/cachetools
	dev-pypi/colorama
	dev-pypi/filelock
	dev-pypi/packaging
	dev-pypi/platformdirs
	dev-pypi/pluggy
	dev-pypi/pyproject-api
	dev-pypi/python-discovery
	dev-pypi/tomli-w
	dev-pypi/virtualenv
"
# lockstep-pypi-deps: end
