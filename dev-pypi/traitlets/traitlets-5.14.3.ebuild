# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="hatchling"

inherit distutils-r1 pypi

PYPI_PN="traitlets"
DESCRIPTION="Traitlets Python configuration system"
HOMEPAGE="https://github.com/ipython/traitlets"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"
