# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="flit"

inherit distutils-r1

DESCRIPTION="Command line tool for manipulating wheel files"
HOMEPAGE="https://pypi.org/project/wheel/"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/39/62/75f18a0f03b4219c456652c7780e4d749b929eb605c098ce3a5b6b6bc081/wheel-0.47.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/wheel-0.47.0"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/packaging
"
# lockstep-pypi-deps: end
