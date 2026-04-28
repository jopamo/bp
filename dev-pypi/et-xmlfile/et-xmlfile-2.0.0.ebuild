# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1 pypi

PYPI_PN="et-xmlfile"
DESCRIPTION="An implementation of lxml.xmlfile for the standard library"
HOMEPAGE="https://foss.heptapod.net/openpyxl/et_xmlfile"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"
