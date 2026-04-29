# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1 pypi

PYPI_PN="lxml"
DESCRIPTION="Powerful and Pythonic XML processing library combining libxml2/libxslt with the ElementTree API."
HOMEPAGE="https://lxml.de/"
LICENSE="BSD-3-Clause"
SLOT="0"
KEYWORDS="amd64 arm64"
