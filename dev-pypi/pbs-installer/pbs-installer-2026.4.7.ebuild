# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="pdm-backend"

inherit distutils-r1 pypi

PYPI_PN="pbs-installer"
DESCRIPTION="Installer for Python Build Standalone"
HOMEPAGE="https://pypi.org/project/pbs-installer/"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"
