# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..13} )
DISTUTILS_EXT=1

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="JSON grammar for tree-sitter"
HOMEPAGE="https://github.com/tree-sitter/tree-sitter-json"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://github.com/tree-sitter/tree-sitter-json/archive/refs/tags/v0.24.8.tar.gz -> ${P}-gh.tar.gz"
S="${WORKDIR}/tree-sitter-json-0.24.8"

BDEPEND="
	dev-pypi/gpep517[${PYTHON_USEDEP}]
	dev-pypi/setuptools[${PYTHON_USEDEP}]
	dev-pypi/wheel[${PYTHON_USEDEP}]
"

IUSE="test"
RESTRICT="!test? ( test )"

python_test() {
	"${EPYTHON}" -c "import tree_sitter_json; tree_sitter_json.language()" || die
}
