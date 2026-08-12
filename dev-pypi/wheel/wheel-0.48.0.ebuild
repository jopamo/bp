# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="flit"

inherit distutils-r1

DESCRIPTION="Command line tool for manipulating wheel files"
HOMEPAGE="https://pypi.org/project/wheel/"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/d0/20/50ed6bdf27dec98b568a8ae25dc599f35baa3d9709f9e83fd1edb56b9a90/wheel-0.48.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/wheel-0.48.0"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/packaging
"
# lockstep-pypi-deps: end

BDEPEND="
	dev-pypi/flit-core[${PYTHON_USEDEP}]
	dev-pypi/gpep517[${PYTHON_USEDEP}]
"
