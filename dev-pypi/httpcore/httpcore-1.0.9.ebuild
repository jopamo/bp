# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="hatchling"

inherit distutils-r1

DESCRIPTION="A minimal low-level HTTP client."
HOMEPAGE="https://www.encode.io/httpcore/"
LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/06/94/82699a10bca87a5556c9c59b5963f2d039dbd239f25bc2a63907a05a14cb/httpcore-1.0.9.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/httpcore-1.0.9"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/certifi
	dev-pypi/h11
"
# lockstep-pypi-deps: end
