# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1 pypi

PYPI_PN="types-urllib3"
DESCRIPTION="Typing stubs for urllib3"
HOMEPAGE="https://github.com/python/typeshed"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"
