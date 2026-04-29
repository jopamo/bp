# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="hatchling"

inherit distutils-r1 pypi

PYPI_PN="httpx"
DESCRIPTION="The next generation HTTP client."
HOMEPAGE="https://github.com/encode/httpx"
LICENSE="BSD-3-Clause"
SLOT="0"
KEYWORDS="amd64 arm64"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/anyio
	dev-pypi/certifi
	dev-pypi/httpcore
	dev-pypi/idna
"
# lockstep-pypi-deps: end
