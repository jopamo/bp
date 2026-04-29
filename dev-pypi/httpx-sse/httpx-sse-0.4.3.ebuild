# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
# lockstep-pypi-deps: begin
RDEPEND+="
"
# lockstep-pypi-deps: end
EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1 pypi

PYPI_PN="httpx-sse"
DESCRIPTION="Consume Server-Sent Event (SSE) messages with HTTPX."
HOMEPAGE="https://github.com/florimondmanca/httpx-sse"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"
