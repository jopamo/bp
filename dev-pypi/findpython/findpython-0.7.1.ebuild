# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="pdm-backend"

inherit distutils-r1 pypi

PYPI_PN="findpython"
DESCRIPTION="A utility to find python versions on your system"
HOMEPAGE="https://github.com/frostming/findpython"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/packaging
	dev-pypi/platformdirs
"
# lockstep-pypi-deps: end
