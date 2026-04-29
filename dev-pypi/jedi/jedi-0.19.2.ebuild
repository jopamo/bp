# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1 pypi

PYPI_PN="jedi"
DESCRIPTION="An autocompletion tool for Python that can be used for text editors."
HOMEPAGE="https://github.com/davidhalter/jedi"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"
