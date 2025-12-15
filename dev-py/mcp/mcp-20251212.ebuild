# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..13} )
DISTUTILS_USE_PEP517=hatchling

inherit distutils-r1

DESCRIPTION="The official Python SDK for the Model Context Protocol"
HOMEPAGE="https://github.com/modelcontextprotocol/python-sdk"

SNAPSHOT=65b36de4eb930a471a5eeeddf078dc8b240a90f2
SRC_URI="https://github.com/modelcontextprotocol/python-sdk/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/python-sdk-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="arm64 amd64"

RDEPEND="
	>=dev-python/anyio-4.5[${PYTHON_USEDEP}]
	>=dev-python/httpx-0.27.1[${PYTHON_USEDEP}]
	>=dev-python/pydantic-2.11.0[${PYTHON_USEDEP}]
	>=dev-python/starlette-0.27[${PYTHON_USEDEP}]
	>=dev-python/python-multipart-0.0.9[${PYTHON_USEDEP}]
	>=dev-python/uvicorn-0.31.1[${PYTHON_USEDEP}]
	>=dev-python/jsonschema-4.20.0[${PYTHON_USEDEP}]
	>=dev-python/typing-extensions-4.9.0[${PYTHON_USEDEP}]
	>=dev-python/typing-inspection-0.4.1[${PYTHON_USEDEP}]
"

BDEPEND="
	>=dev-python/hatchling-1.21.0[${PYTHON_USEDEP}]
"

RESTRICT="test"
