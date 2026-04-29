# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="hatchling"

inherit distutils-r1

DESCRIPTION="The lightning-fast ASGI server."
HOMEPAGE="https://uvicorn.dev/"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/1f/93/041fca8274050e40e6791f267d82e0e2e27dd165627bd640d3e0e378d877/uvicorn-0.46.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/uvicorn-0.46.0"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/click
	dev-pypi/h11
"
# lockstep-pypi-deps: end
