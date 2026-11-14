# Distributed under the terms of the GNU General Public License v2

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 flag-o-matic
# lockstep-pypi-managed: true
# lockstep-pypi-deps: begin
RDEPEND=""
# lockstep-pypi-deps: end
DESCRIPTION="Python bindings to the Tree-sitter parsing library"
HOMEPAGE="https://github.com/tree-sitter/py-tree-sitter/"

MY_PN="py-tree-sitter"
SNAPSHOT=cb92a454132d6dd1cea315e660b8a5b6027561a6
SRC_URI="https://github.com/tree-sitter/py-tree-sitter/archive/${SNAPSHOT}.tar.gz -> ${MY_PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${MY_PN}-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

# setuptools is needed for distutils import
DEPEND=">=lib-dev/tree-sitter-0.27.0:="
RDEPEND="${DEPEND}
	$(python_gen_cond_dep '
		dev-pypi/setuptools[${PYTHON_USEDEP}]
	' 3.12)
"
BDEPEND="
	test? (
		=dev-pypi/tree-sitter-html-0.23.2[${PYTHON_USEDEP}]
		=dev-pypi/tree-sitter-javascript-0.25.0[${PYTHON_USEDEP}]
		=dev-pypi/tree-sitter-json-0.24.8[${PYTHON_USEDEP}]
		=dev-pypi/tree-sitter-python-0.25.0[${PYTHON_USEDEP}]
		=dev-pypi/tree-sitter-rust-0.24.2[${PYTHON_USEDEP}]
	)
"

PATCHES=(
	"${FILESDIR}"/tree-sitter-0.22.2-unbundle.patch
)

distutils_enable_tests pytest

src_prepare() {
	filter-flags -Wl,-z,defs

	default
}

src_test() {
	rm -r tree_sitter || die
	distutils-r1_src_test
}
