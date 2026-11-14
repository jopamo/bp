# Distributed under the terms of the GNU General Public License v2
# lockstep-pypi-managed: true

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1

DESCRIPTION="Rust grammar for tree-sitter"
HOMEPAGE="https://github.com/tree-sitter/tree-sitter-rust"
SRC_URI="https://github.com/tree-sitter/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}-gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="test"
RESTRICT="!test? ( test )"

BDEPEND="dev-pypi/wheel[${PYTHON_USEDEP}]"

python_test() {
	"${EPYTHON}" -c "import tree_sitter_rust; tree_sitter_rust.language()" || die
}
