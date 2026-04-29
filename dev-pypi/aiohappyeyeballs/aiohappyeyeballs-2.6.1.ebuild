# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="poetry"

inherit distutils-r1 pypi

PYPI_PN="aiohappyeyeballs"
DESCRIPTION="Happy Eyeballs for asyncio"
HOMEPAGE="https://pypi.org/project/aiohappyeyeballs/"
LICENSE="PSF-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"
