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

SRC_URI="https://files.pythonhosted.org/packages/f9/28/a372daf898de1a1bf8e13d858e77da9f1afcedfdb22c987cdf87c4d9fa0d/gpep517-20.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/gpep517-20"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/installer
"
# lockstep-pypi-deps: end

BDEPEND="
	dev-pypi/flit-core[${PYTHON_USEDEP}]
"
