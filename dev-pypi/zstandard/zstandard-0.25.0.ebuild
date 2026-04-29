# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1 pypi

PYPI_PN="zstandard"
DESCRIPTION="Zstandard bindings for Python"
HOMEPAGE="https://github.com/indygreg/python-zstandard"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"
