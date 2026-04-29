# Distributed under the terms of the GNU General Public License v2

DISTUTILS_USE_PEP517=hatchling

inherit distutils-r1 pypi
# lockstep-pypi-managed: true
# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/anyio
	dev-pypi/distro
	dev-pypi/httpx
	dev-pypi/jiter
	dev-pypi/pydantic
	dev-pypi/sniffio
	dev-pypi/tqdm
	dev-pypi/typing-extensions
"
# lockstep-pypi-deps: end
DESCRIPTION="Python client library for the OpenAI API"
HOMEPAGE="https://github.com/openai/openai-python"
SNAPSHOT=58184ad545ee2abd98e171ee09766f259d7f38cd
SRC_URI="https://github.com/openai/openai-python/archive/${SNAPSHOT}.tar.gz -> openai-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/openai-python-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="datalib"

RDEPEND="
	dev-python/pydantic[${PYTHON_USEDEP}]
	dev-python/typing-extensions[${PYTHON_USEDEP}]
	>=dev-python/requests-2.20[${PYTHON_USEDEP}]
	dev-python/tqdm[${PYTHON_USEDEP}]
	dev-python/aiohttp[${PYTHON_USEDEP}]
	datalib? (
		dev-py/numpy[${PYTHON_USEDEP}]
		>=dev-python/pandas-1.2.3[${PYTHON_USEDEP}]
		>=dev-python/pandas-stubs-1.1.0.11[${PYTHON_USEDEP}]
		>=dev-python/openpyxl-3.0.7[${PYTHON_USEDEP}]
	)"

DEPEND="${RDEPEND}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RESTRICT="test"
