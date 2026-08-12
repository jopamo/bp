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

SRC_URI="https://files.pythonhosted.org/packages/bd/3d/f9a8c07a3884f3e5b26205e8436a18b3af61c5d53192c3bea235574dbbec/httpx2-2.10.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/httpx2-2.10.0"

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
