# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="poetry"

inherit distutils-r1

DESCRIPTION="Dynamic version generation"
HOMEPAGE="https://pypi.org/project/dunamai/"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/9f/67/d5611975faaa5e4a920f4b19e4caccd5df0facb925687850f1e45f5876f2/dunamai-1.26.1.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/dunamai-1.26.1"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/packaging
"
# lockstep-pypi-deps: end

BDEPEND="
	dev-pypi/poetry-core[${PYTHON_USEDEP}]
"
