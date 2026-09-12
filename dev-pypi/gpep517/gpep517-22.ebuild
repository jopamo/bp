# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="flit"

inherit distutils-r1

DESCRIPTION="Python package builder and installer for non-pip-centric world"
HOMEPAGE="https://pypi.org/project/gpep517/"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/bf/94/037d6ece08470a678f1b8fe0ecf7466d4cda8c63f000b4ac6abc2ca735bd/gpep517-22.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/gpep517-22"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/installer
"
# lockstep-pypi-deps: end

BDEPEND="
	dev-pypi/flit-core[${PYTHON_USEDEP}]
"
