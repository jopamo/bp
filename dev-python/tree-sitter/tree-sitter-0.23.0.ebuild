# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1

DESCRIPTION="Python bindings to the Tree-sitter parsing library"
HOMEPAGE="
	https://github.com/tree-sitter/py-tree-sitter/
	https://pypi.org/project/tree-sitter/
"
SRC_URI="
	https://github.com/tree-sitter/py-tree-sitter/archive/v${PV}.tar.gz
		-> ${P}.gh.tar.gz
"
S=${WORKDIR}/py-${P}

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

# setuptools is needed for distutils import
DEPEND=">=lib-dev/tree-sitter-0.23.0:="
RDEPEND="${DEPEND}
	$(python_gen_cond_dep '
		dev-python/setuptools[${PYTHON_USEDEP}]
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

distutils_enable_tests pytest

PATCHES=(
	"${FILESDIR}"/${PN}-0.22.2-unbundle.patch
)

src_unpack() {
	filter-flags -Wl,-z,defs
	default
	rmdir "${S}/tree_sitter/core" || die
}

src_prepare() {
	filter-flags -Wl,-z,defs
	default

	sed -i tree_sitter/binding/query.c -e 's/_PyErr_FormatFromCause/PyErr_Format/' || die
}

src_test() {
	rm -r tree_sitter || die
	distutils-r1_src_test
}
