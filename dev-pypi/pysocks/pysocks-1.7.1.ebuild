# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1 pypi

PYPI_PN="pysocks"
DESCRIPTION="A Python SOCKS client module. See https://github.com/Anorov/PySocks for more information."
HOMEPAGE="https://github.com/Anorov/PySocks"
LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"
