# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="flit"

inherit distutils-r1

DESCRIPTION="A simple, correct Python build frontend"
HOMEPAGE="https://build.pypa.io"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/a7/12/fa7bd9f677a2dcc58a395217c221e2a5e5cebd59ddc9756bc4f5fede8719/build-1.4.1.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/build-1.4.1"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/packaging
	dev-pypi/pyproject-hooks
"
# lockstep-pypi-deps: end
