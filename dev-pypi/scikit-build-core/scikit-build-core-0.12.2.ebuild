# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="hatchling"

inherit distutils-r1

DESCRIPTION="Build backend for CMake based projects"
HOMEPAGE="https://github.com/scikit-build/scikit-build-core"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/28/cd/9ebb50029b6d8a3ee9e38cdce514ebd70190ec1edf28ab0a1f66d0b84670/scikit_build_core-0.12.2.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/scikit_build_core-0.12.2"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/packaging
	dev-pypi/pathspec
"
# lockstep-pypi-deps: end
