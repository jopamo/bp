# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Async http client/server framework (asyncio)"
HOMEPAGE="https://github.com/aio-libs/aiohttp"
LICENSE="Apache-2.0 MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/50/42/32cf8e7704ceb4481406eb87161349abb46a57fee3f008ba9cb610968646/aiohttp-3.13.3.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/aiohttp-3.13.3"

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
