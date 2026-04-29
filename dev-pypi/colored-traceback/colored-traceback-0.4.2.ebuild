# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1 pypi

PYPI_PN="colored-traceback"
DESCRIPTION="Automatically color uncaught exception tracebacks"
HOMEPAGE="https://pypi.org/project/colored-traceback/"
LICENSE="ISC"
SLOT="0"
KEYWORDS="amd64 arm64"
