# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="hatchling"

inherit distutils-r1

DESCRIPTION="The next generation HTTP client."
HOMEPAGE="https://github.com/pydantic/httpx2"
LICENSE="BSD-3-Clause"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/d5/44/474bef2a0e9d90f1715d32cb98b0738695ca17ba324095fb2497ed7fbd59/httpx2-2.13.1.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/httpx2-2.13.1"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/anyio
	dev-pypi/httpcore2
	dev-pypi/idna
	dev-pypi/truststore
"
# lockstep-pypi-deps: end

BDEPEND="
	dev-pypi/gpep517[${PYTHON_USEDEP}]
	dev-pypi/hatch-fancy-pypi-readme[${PYTHON_USEDEP}]
	dev-pypi/hatchling[${PYTHON_USEDEP}]
	dev-pypi/uv-dynamic-versioning[${PYTHON_USEDEP}]
"
