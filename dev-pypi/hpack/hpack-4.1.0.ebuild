# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1 pypi

PYPI_PN="hpack"
DESCRIPTION="Pure-Python HPACK header encoding"
HOMEPAGE="https://github.com/python-hyper/hpack/"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"
