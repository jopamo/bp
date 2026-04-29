# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="hatchling"

inherit distutils-r1 pypi

PYPI_PN="mcp"
DESCRIPTION="Model Context Protocol SDK"
HOMEPAGE="https://modelcontextprotocol.io"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/anyio
	dev-pypi/httpx
	dev-pypi/httpx-sse
	dev-pypi/jsonschema
	dev-pypi/pydantic
	dev-pypi/pydantic-settings
	dev-pypi/pyjwt
	dev-pypi/python-multipart
	dev-pypi/sse-starlette
	dev-pypi/starlette
	dev-pypi/typing-extensions
	dev-pypi/typing-inspection
	dev-pypi/uvicorn
"
# lockstep-pypi-deps: end
