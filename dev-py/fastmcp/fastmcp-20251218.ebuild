# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..13} )
DISTUTILS_USE_PEP517=hatchling

inherit distutils-r1

DESCRIPTION="The fast, Pythonic way to build MCP servers and clients"
HOMEPAGE="https://gofastmcp.com/ https://pypi.org/project/fastmcp/"
SNAPSHOT=caeaa86394a56782a486b7c97da25082ad79c10c
SRC_URI="https://github.com/jlowin/fastmcp/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="arm64 amd64"

RDEPEND="
	>=dev-python/python-dotenv-1.1.0[${PYTHON_USEDEP}]
	>=dev-python/exceptiongroup-1.2.2[${PYTHON_USEDEP}]
	>=dev-python/httpx-0.28.1[${PYTHON_USEDEP}]
	>=dev-python/mcp-1.24.0[${PYTHON_USEDEP}]
	>=dev-python/openapi-pydantic-0.5.1[${PYTHON_USEDEP}]
	>=dev-python/platformdirs-4.0.0[${PYTHON_USEDEP}]
	>=dev-python/pydocket-0.15.5[${PYTHON_USEDEP}]
	>=dev-python/rich-13.9.4[${PYTHON_USEDEP}]
	>=dev-python/cyclopts-4.0.0[${PYTHON_USEDEP}]
	>=dev-python/authlib-1.6.5[${PYTHON_USEDEP}]
	>=dev-python/pydantic-2.11.7[email,${PYTHON_USEDEP}]
	>=dev-python/pyperclip-1.9.0[${PYTHON_USEDEP}]
	>=dev-python/py-key-value-aio-0.3.0[disk,keyring,memory,${PYTHON_USEDEP}]
	<dev-python/py-key-value-aio-0.4.0[${PYTHON_USEDEP}]
	>=dev-python/uvicorn-0.35[${PYTHON_USEDEP}]
	>=dev-python/websockets-15.0.1[${PYTHON_USEDEP}]
	>=dev-python/jsonschema-path-0.3.4[${PYTHON_USEDEP}]
"

BDEPEND="
	>=dev-python/hatchling-0[${PYTHON_USEDEP}]
	>=dev-python/uv-dynamic-versioning-0.7.0[${PYTHON_USEDEP}]
"

RESTRICT="test"
