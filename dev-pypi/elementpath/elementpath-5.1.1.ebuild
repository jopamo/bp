# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1 pypi

PYPI_PN="elementpath"
DESCRIPTION="XPath 1.0/2.0/3.0/3.1 parsers and selectors for ElementTree and lxml"
HOMEPAGE="https://github.com/sissaschool/elementpath"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"
