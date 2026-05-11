# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="A PEP 518 build backend that uses setuptools_scm to generate a version file from your version control system, then flit to build the package."
HOMEPAGE="https://gitlab.com/WillDaSilva/flit_scm"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/e2/99/961b062461652435b6ad9042d2ffdd75e327b36936987c2073aa784334d5/flit_scm-1.7.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/flit_scm-1.7.0"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-py/setuptools-scm
	dev-pypi/flit-core
"
# lockstep-pypi-deps: end

BDEPEND="
	dev-pypi/flit-core[${PYTHON_USEDEP}]
	dev-py/setuptools-scm[${PYTHON_USEDEP}]
"
