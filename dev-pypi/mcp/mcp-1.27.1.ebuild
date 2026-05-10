# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="hatchling"

inherit distutils-r1

DESCRIPTION="Model Context Protocol SDK"
HOMEPAGE="https://modelcontextprotocol.io"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/38/83/d1efe7c2980d8a3afa476f4e3d42d53dd54c0ab94c27bee5d755b45c8b73/mcp-1.27.1.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/mcp-1.27.1"

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

BDEPEND="
	dev-pypi/hatchling[${PYTHON_USEDEP}]
	dev-pypi/uv-dynamic-versioning[${PYTHON_USEDEP}]
"
