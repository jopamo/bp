# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=standalone
PYTHON_TESTED=( pypy3_11 python3_{11..14} )
PYTHON_COMPAT=( "${PYTHON_TESTED[@]}" )

inherit distutils-r1 pypi

DESCRIPTION="Poetry PEP 517 Build Backend"
HOMEPAGE="
	https://github.com/python-poetry/poetry-core/
	https://pypi.org/project/poetry-core/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

# check inside vendors/pyproject.toml
# (note that some are indirect deps)
RDEPEND="
	>=dev-python/fastjsonschema-2.21.1[${PYTHON_USEDEP}]
	>=dev-python/lark-1.2.2[${PYTHON_USEDEP}]
	>=dev-python/packaging-24.2[${PYTHON_USEDEP}]
"
BDEPEND="
	${RDEPEND}
	test? (
		$(python_gen_cond_dep '
			dev-python/build[${PYTHON_USEDEP}]
			dev-python/pytest-mock[${PYTHON_USEDEP}]
			dev-python/tomli-w[${PYTHON_USEDEP}]
			>=dev-python/trove-classifiers-2022.5.19[${PYTHON_USEDEP}]
			>=dev-python/virtualenv-20.21[${PYTHON_USEDEP}]
		' "${PYTHON_TESTED[@]}")
	)
"

distutils_enable_tests pytest

src_prepare() {
	# remove vendoring of dependencies
	rm -r src/poetry/core/_vendor || die
	sed -e '/__vendor_site__/d' -i src/poetry/core/__init__.py || die

	distutils-r1_src_prepare
}

python_test() {
	if ! has "${EPYTHON/./_}" "${PYTHON_TESTED[@]}"; then
		einfo "Skipping tests on ${EPYTHON} (unported deps)"
		return
	fi

	# Poetry expects test to be run inside a git repository, otherwise
	# VCS-related logic doesn't get triggered.  An empty repository
	# suffices, though.
	git init || die

	local -x PYTEST_DISABLE_PLUGIN_AUTOLOAD=1
	epytest -p pytest_mock
}
