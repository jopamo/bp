# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1 pypi

PYPI_PN="colorlog"
DESCRIPTION="Add colours to the output of Python's logging module."
HOMEPAGE="https://github.com/borntyping/python-colorlog"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"
