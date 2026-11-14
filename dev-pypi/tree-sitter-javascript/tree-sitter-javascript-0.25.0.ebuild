# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..13} )
DISTUTILS_EXT=1

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="JavaScript grammar for tree-sitter"
HOMEPAGE="https://github.com/tree-sitter/tree-sitter-javascript"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/59/e0/e63103c72a9d3dfd89a31e02e660263ad84b7438e5f44ee82e443e65bbde/tree_sitter_javascript-0.25.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/tree_sitter_javascript-0.25.0"

BDEPEND="
	dev-pypi/gpep517[${PYTHON_USEDEP}]
	dev-pypi/setuptools[${PYTHON_USEDEP}]
	dev-pypi/wheel[${PYTHON_USEDEP}]
"

IUSE="test"
RESTRICT="!test? ( test )"

python_test() {
	"${EPYTHON}" -c "import tree_sitter_javascript; tree_sitter_javascript.language()" || die
}
