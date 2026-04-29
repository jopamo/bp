# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1 pypi

PYPI_PN="unicorn"
DESCRIPTION="Unicorn CPU emulator engine"
HOMEPAGE="http://www.unicorn-engine.org"
LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"
