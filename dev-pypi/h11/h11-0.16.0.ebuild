# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1 pypi

PYPI_PN="h11"
DESCRIPTION="A pure-Python, bring-your-own-I/O implementation of HTTP/1.1"
HOMEPAGE="https://github.com/python-hyper/h11"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"
