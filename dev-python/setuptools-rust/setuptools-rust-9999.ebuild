# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..11} pypy3 )

inherit distutils-r1 git-r3

DESCRIPTION="A plugin for setuptools to build Rust Python extensions"
HOMEPAGE="
	https://github.com/PyO3/setuptools-rust/
	https://pypi.org/project/setuptools-rust/
"
#SRC_URI="mirror://pypi/${PN::1}/${PN}/${P}.tar.gz"
EGIT_REPO_URI="https://github.com/PyO3/setuptools-rust.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="test"

RESTRICT="!test? ( test )"

RDEPEND="
	virtual/rust
	<dev-python/semantic_version-3[${PYTHON_USEDEP}]
	>=dev-python/semantic_version-2.8.2[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]
	>=dev-python/typing-extensions-3.7.4.3[${PYTHON_USEDEP}]
"
BDEPEND="
	>=dev-python/setuptools_scm-6.3.2[${PYTHON_USEDEP}]
	test? (
		${RDEPEND}
		dev-python/beautifulsoup4[${PYTHON_USEDEP}]
		$(python_gen_cond_dep '
			dev-python/cffi[${PYTHON_USEDEP}]
		' 'python*')
		dev-python/lxml[${PYTHON_USEDEP}]
		dev-python/pytest[${PYTHON_USEDEP}]
	)
"

python_test() {
	local examples=(
		html-py-ever
		namespace_package
		rust_with_cffi
	)
	for example_dir in ${examples[@]}; do
		pushd examples/${example_dir} >/dev/null || die
		einfo "Running ${example_dir} test"
		esetup.py build --build-lib=build/lib

		case ${example_dir} in
			html-py-ever)
				pushd test >/dev/null || die
				local -x PYTHONPATH=../build/lib
				${EPYTHON} run_all.py || die "Tests failed with ${EPYTHON}"
				popd >/dev/null || die
				;;
			*)
				pushd build/lib >/dev/null || die
				epytest ../../tests
				popd >/dev/null || die
				;;
		esac

		rm -rf build || die
		popd >/dev/null || die
	done
}
