# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1 pypi

PYPI_PN="aiohttp"
DESCRIPTION="Async http client/server framework (asyncio)"
HOMEPAGE="https://github.com/aio-libs/aiohttp"
LICENSE="Apache-2.0 MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/aiohappyeyeballs
	dev-pypi/aiosignal
	dev-pypi/attrs
	dev-pypi/frozenlist
	dev-pypi/multidict
	dev-pypi/propcache
	dev-pypi/yarl
"
# lockstep-pypi-deps: end
