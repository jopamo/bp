# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling

inherit distutils-r1 pypi

DESCRIPTION="Python client library for the OpenAI API"
HOMEPAGE="https://github.com/openai/openai-python"
SNAPSHOT=3154a78ac8cb404d64707d63cdfe72d3db8a45be
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
		dev-python/numpy[${PYTHON_USEDEP}]
		>=dev-python/pandas-1.2.3[${PYTHON_USEDEP}]
		>=dev-python/pandas-stubs-1.1.0.11[${PYTHON_USEDEP}]
		>=dev-python/openpyxl-3.0.7[${PYTHON_USEDEP}]
	)"

DEPEND="${RDEPEND}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RESTRICT="test"
