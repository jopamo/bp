# Distributed under the terms of the GNU General Public License v2

PYTHON_COMPAT=( python3_{10..13} )
DISTUTILS_USE_PEP517=hatchling

inherit distutils-r1
# lockstep-pypi-managed: true
# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/authlib
	dev-pypi/cyclopts
	dev-pypi/exceptiongroup
	dev-pypi/griffelib
	dev-pypi/httpx
	dev-pypi/jsonref
	dev-pypi/jsonschema-path
	dev-pypi/mcp
	dev-pypi/openapi-pydantic
	dev-pypi/opentelemetry-api
	dev-pypi/packaging
	dev-pypi/platformdirs
	dev-pypi/py-key-value-aio
	dev-pypi/pydantic
	dev-pypi/pyperclip
	dev-pypi/python-dotenv
	dev-pypi/python-multipart
	dev-pypi/pyyaml
	dev-pypi/rich
	dev-pypi/uncalled-for
	dev-pypi/uvicorn
	dev-pypi/watchfiles
	dev-pypi/websockets
"
# lockstep-pypi-deps: end
DESCRIPTION="The fast, Pythonic way to build MCP servers and clients"
HOMEPAGE="https://gofastmcp.com/ https://pypi.org/project/fastmcp/"
SNAPSHOT=d0315974fa844b2424c93f4ad43c8f2d543ff51a
SRC_URI="https://github.com/jlowin/fastmcp/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="arm64 amd64"

RDEPEND="
	>=dev-pypi/python-dotenv-1.1.0[${PYTHON_USEDEP}]
	>=dev-pypi/exceptiongroup-1.2.2[${PYTHON_USEDEP}]
	>=dev-pypi/httpx-0.28.1[${PYTHON_USEDEP}]
	>=dev-py/mcp-1.24.0[${PYTHON_USEDEP}]
	>=dev-py/openapi-pydantic-0.5.1[${PYTHON_USEDEP}]
	>=dev-pypi/platformdirs-4.0.0[${PYTHON_USEDEP}]
	>=dev-py/pydocket-0.15.5[${PYTHON_USEDEP}]
	>=dev-pypi/rich-13.9.4[${PYTHON_USEDEP}]
	>=dev-py/cyclopts-4.0.0[${PYTHON_USEDEP}]
	>=dev-py/authlib-1.6.5[${PYTHON_USEDEP}]
	>=dev-pypi/pydantic-2.11.7[email,${PYTHON_USEDEP}]
	>=dev-pypi/pyperclip-1.9.0[${PYTHON_USEDEP}]
	>=dev-py/py-key-value-aio-0.3.0[disk,keyring,memory,${PYTHON_USEDEP}]
	<dev-py/py-key-value-aio-0.4.0[${PYTHON_USEDEP}]
	>=dev-pypi/uvicorn-0.35[${PYTHON_USEDEP}]
	>=dev-pypi/websockets-15.0.1[${PYTHON_USEDEP}]
	>=dev-pypi/jsonschema-path-0.3.4[${PYTHON_USEDEP}]
"

BDEPEND="
	>=dev-pypi/hatchling-0[${PYTHON_USEDEP}]
	>=dev-py/uv-dynamic-versioning-0.7.0[${PYTHON_USEDEP}]
"

RESTRICT="test"
