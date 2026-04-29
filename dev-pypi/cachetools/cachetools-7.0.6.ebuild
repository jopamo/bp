# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1 pypi

PYPI_PN="cachetools"
DESCRIPTION="Extensible memoizing collections and decorators"
HOMEPAGE="https://github.com/tkem/cachetools/"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"
