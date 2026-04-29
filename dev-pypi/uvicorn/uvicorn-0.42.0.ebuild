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

SRC_URI="https://files.pythonhosted.org/packages/e3/ad/4a96c425be6fb67e0621e62d86c402b4a17ab2be7f7c055d9bd2f638b9e2/uvicorn-0.42.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/uvicorn-0.42.0"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/click
	dev-pypi/h11
"
# lockstep-pypi-deps: end
