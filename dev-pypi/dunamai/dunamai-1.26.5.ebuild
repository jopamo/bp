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

SRC_URI="https://files.pythonhosted.org/packages/18/82/51a4e2ed9a7fef19888e5e0ba9a493c8f1878ab89b10b05cc9564b4f5df8/dunamai-1.26.5.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/dunamai-1.26.5"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/packaging
"
# lockstep-pypi-deps: end

BDEPEND="
	dev-pypi/gpep517[${PYTHON_USEDEP}]
	dev-pypi/poetry-core[${PYTHON_USEDEP}]
"
