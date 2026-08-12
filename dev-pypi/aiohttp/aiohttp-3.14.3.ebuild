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

SRC_URI="https://files.pythonhosted.org/packages/58/d9/22ce5786ac0c1653ae8b6c23bded02c1686d11f0dbb45b31ce128e0df985/aiohttp-3.14.3.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/aiohttp-3.14.3"

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

BDEPEND="
	dev-pypi/gpep517[${PYTHON_USEDEP}]
	dev-pypi/pkgconfig[${PYTHON_USEDEP}]
	dev-pypi/setuptools[${PYTHON_USEDEP}]
"
