# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="flit"

inherit distutils-r1 pypi

PYPI_PN="installer"
DESCRIPTION="A library for installing Python wheels."
HOMEPAGE="https://pypi.org/project/installer/"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"
