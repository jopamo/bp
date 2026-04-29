# Distributed under the terms of the GNU General Public License v2

DISTUTILS_USE_PEP517=standalone
PYPI_VERIFY_REPO=https://github.com/python-poetry/poetry-core
PYTHON_TESTED=( pypy3_11 python3_{11..14} )
PYTHON_COMPAT=( "${PYTHON_TESTED[@]}" )

inherit distutils-r1 pypi
# lockstep-pypi-managed: true
# lockstep-pypi-deps: begin
RDEPEND+="
"
# lockstep-pypi-deps: end
DESCRIPTION="Poetry PEP 517 Build Backend"
HOMEPAGE="
	https://github.com/python-poetry/poetry-core/
	https://pypi.org/project/poetry-core/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="test"
RESTRICT="!test? ( test )"

# check inside vendors/pyproject.toml
# (note that some are indirect deps)
RDEPEND="
	>=dev-pypi/fastjsonschema-2.21.2[${PYTHON_USEDEP}]
	>=dev-pypi/lark-1.3.1[${PYTHON_USEDEP}]
	>=dev-pypi/packaging-25.0[${PYTHON_USEDEP}]
"
BDEPEND="
	${RDEPEND}
	test? (
		$(python_gen_cond_dep '
			dev-pypi/build[${PYTHON_USEDEP}]
			dev-py/pytest-mock[${PYTHON_USEDEP}]
			dev-pypi/tomli-w[${PYTHON_USEDEP}]
			>=dev-pypi/trove-classifiers-2022.5.19[${PYTHON_USEDEP}]
			>=dev-pypi/virtualenv-20.21[${PYTHON_USEDEP}]
		' "${PYTHON_TESTED[@]}")
	)
"

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

	local EPYTEST_PLUGINS=( pytest-mock )
	epytest
}
