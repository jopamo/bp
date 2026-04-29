# Distributed under the terms of the GNU General Public License v2

PYTHON_COMPAT=( python3_{10..13} )
DISTUTILS_USE_PEP517=hatchling

inherit distutils-r1
# lockstep-pypi-managed: true
# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/anyio
	dev-pypi/httpx
	dev-pypi/httpx-sse
	dev-pypi/jsonschema
	dev-pypi/opentelemetry-api
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
DESCRIPTION="The official Python SDK for the Model Context Protocol"
HOMEPAGE="https://github.com/modelcontextprotocol/python-sdk"
SNAPSHOT=d5b9155f14ab3b4b203a47c55b53955b2d0bca09
SRC_URI="https://github.com/modelcontextprotocol/python-sdk/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/python-sdk-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="arm64 amd64"

RDEPEND="
	>=dev-py/anyio-4.5[${PYTHON_USEDEP}]
	>=dev-py/httpx-0.27.1[${PYTHON_USEDEP}]
	>=dev-py/pydantic-2.11.0[${PYTHON_USEDEP}]
	>=dev-py/starlette-0.27[${PYTHON_USEDEP}]
	>=dev-py/python-multipart-0.0.9[${PYTHON_USEDEP}]
	>=dev-py/uvicorn-0.31.1[${PYTHON_USEDEP}]
	>=dev-py/jsonschema-4.20.0[${PYTHON_USEDEP}]
	>=dev-py/typing-extensions-4.9.0[${PYTHON_USEDEP}]
	>=dev-py/typing-inspection-0.4.1[${PYTHON_USEDEP}]
"

BDEPEND="
	>=dev-py/hatchling-1.21.0[${PYTHON_USEDEP}]
"

RESTRICT="test"
