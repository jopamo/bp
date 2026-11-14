# Distributed under the terms of the GNU General Public License v2
# lockstep-pypi-managed: true

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1

DESCRIPTION="JavaScript grammar for tree-sitter"
HOMEPAGE="https://github.com/tree-sitter/tree-sitter-javascript"
SRC_URI="https://files.pythonhosted.org/packages/59/e0/e63103c72a9d3dfd89a31e02e660263ad84b7438e5f44ee82e443e65bbde/tree_sitter_javascript-0.25.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/tree_sitter_javascript-0.25.0"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="test"
RESTRICT="!test? ( test )"

BDEPEND="dev-pypi/wheel[${PYTHON_USEDEP}]"

python_test() {
	"${EPYTHON}" -c "import tree_sitter_javascript; tree_sitter_javascript.language()" || die
}
