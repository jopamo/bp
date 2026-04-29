# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="hatchling"

inherit distutils-r1 pypi

PYPI_PN="filelock"
DESCRIPTION="A platform independent file lock."
HOMEPAGE="https://github.com/tox-dev/py-filelock"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"
