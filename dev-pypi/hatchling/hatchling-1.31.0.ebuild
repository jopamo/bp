# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="standalone"

inherit distutils-r1

DESCRIPTION="Modern, extensible Python build backend"
HOMEPAGE="https://hatch.pypa.io/latest/"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/25/e2/dfa73fe78f773018dcaebc6d09b819bc10d328ff5a6b4a66efa1e3d71f52/hatchling-1.31.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/hatchling-1.31.0"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/packaging
	dev-pypi/pathspec
	dev-pypi/pluggy
	dev-pypi/trove-classifiers
"
# lockstep-pypi-deps: end

BDEPEND="
	dev-pypi/gpep517[${PYTHON_USEDEP}]
"
