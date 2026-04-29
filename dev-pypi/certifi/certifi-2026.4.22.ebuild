# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1 pypi

PYPI_PN="certifi"
DESCRIPTION="Python package for providing Mozilla's CA Bundle."
HOMEPAGE="https://github.com/certifi/python-certifi"
LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"
