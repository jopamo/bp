# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1 pypi

PYPI_PN="priority"
DESCRIPTION="A pure-Python implementation of the HTTP/2 priority tree"
HOMEPAGE="https://github.com/python-hyper/priority/"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"
