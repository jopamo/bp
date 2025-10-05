# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1 flag-o-matic

DESCRIPTION="Python bindings to the Tree-sitter parsing library"
HOMEPAGE="
	https://github.com/tree-sitter/py-tree-sitter/
	https://pypi.org/project/tree-sitter/
"

MY_PN="py-tree-sitter"
SNAPSHOT=9b5c1cbd8f5e136ca30e7e9d32872c59e9ec1f7d
SRC_URI="https://github.com/tree-sitter/py-tree-sitter/archive/${SNAPSHOT}.tar.gz -> ${MY_PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${MY_PN}-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

# setuptools is needed for distutils import
DEPEND=">=lib-dev/tree-sitter-0.23.0:="
RDEPEND="${DEPEND}
	$(python_gen_cond_dep '
		dev-py/setuptools[${PYTHON_USEDEP}]
	' 3.12)
"
BDEPEND="
	test? (
		>=lib-dev/tree-sitter-html-0.20.4[python,${PYTHON_USEDEP}]
		>=lib-dev/tree-sitter-javascript-0.21.0[python,${PYTHON_USEDEP}]
		>=lib-dev/tree-sitter-json-0.20.3[python,${PYTHON_USEDEP}]
		>=lib-dev/tree-sitter-python-0.23.0[python,${PYTHON_USEDEP}]
		>=lib-dev/tree-sitter-rust-0.21.2[python,${PYTHON_USEDEP}]
	)
"

PATCHES=(
	"${FILESDIR}"/tree-sitter-0.22.2-unbundle.patch
)

distutils_enable_tests pytest

src_prepare() {
	filter-flags -Wl,-z,defs

	sed -i '/-Werror=implicit-function-declaration/d' setup.py || die
	sed -i 's/ts_node_child_containing_descendant/ts_node_child_with_descendant/g' tree_sitter/binding/node.c || die

	default

	sed -i tree_sitter/binding/query.c -e 's/_PyErr_FormatFromCause/PyErr_Format/' || die
}

src_test() {
	rm -r tree_sitter || die
	distutils-r1_src_test
}
