# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1 pypi

PYPI_PN="tornado"
DESCRIPTION="Tornado is a Python web framework and asynchronous networking library, originally developed at FriendFeed."
HOMEPAGE="http://www.tornadoweb.org/"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"
