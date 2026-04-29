# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1 pypi

PYPI_PN="pyperclip"
DESCRIPTION="A cross-platform clipboard module for Python. (Only handles plain text for now.)"
HOMEPAGE="https://github.com/asweigart/pyperclip"
LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"
