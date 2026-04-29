# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1 pypi

PYPI_PN="librt"
DESCRIPTION="Mypyc runtime library"
HOMEPAGE="https://github.com/mypyc/librt"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"
