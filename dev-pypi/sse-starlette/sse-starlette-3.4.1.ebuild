# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="SSE plugin for Starlette"
HOMEPAGE="https://pypi.org/project/sse-starlette/"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/e1/9a/f35932a8c0eb6b2287b66fa65a0321df8c84e4e355a659c1841a37c39fdb/sse_starlette-3.4.1.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/sse_starlette-3.4.1"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/anyio
	dev-pypi/starlette
"
# lockstep-pypi-deps: end
