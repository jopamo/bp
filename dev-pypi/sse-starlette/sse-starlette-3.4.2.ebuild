# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="SSE plugin for Starlette"
HOMEPAGE="https://github.com/sysid/sse-starlette"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/38/82/10cdfab4ab663a6b6bd624d33f55b2cfa41af5105be033a6d5d135a92c5f/sse_starlette-3.4.2.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/sse_starlette-3.4.2"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/anyio
	dev-pypi/starlette
"
# lockstep-pypi-deps: end

BDEPEND="
	dev-pypi/setuptools[${PYTHON_USEDEP}]
"
