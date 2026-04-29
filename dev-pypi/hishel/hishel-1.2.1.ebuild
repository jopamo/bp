# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="hatchling"

inherit distutils-r1 pypi

PYPI_PN="hishel"
DESCRIPTION="Elegant HTTP Caching for Python"
HOMEPAGE="https://hishel.com"
LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/msgpack
	dev-pypi/typing-extensions
"
# lockstep-pypi-deps: end
