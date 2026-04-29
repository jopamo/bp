# Distributed under the terms of the GNU General Public License v2

DISTUTILS_USE_PEP517=setuptools
PYPI_VERIFY_REPO=https://github.com/networkx/networkx
PYTHON_FULLY_TESTED=( python3_{11..14} )
PYTHON_COMPAT=( "${PYTHON_FULLY_TESTED[@]}" )

inherit distutils-r1 optfeature pypi
# lockstep-pypi-managed: true
# lockstep-pypi-deps: begin
RDEPEND+="
"
# lockstep-pypi-deps: end
DESCRIPTION="Python tools to manipulate graphs and complex networks"
HOMEPAGE="
	https://networkx.org/
	https://github.com/networkx/networkx/
	https://pypi.org/project/networkx/
"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

BDEPEND="
	test? (
		>=dev-py/lxml-4.6[${PYTHON_USEDEP}]
		$(python_gen_cond_dep '
			>=dev-pypi/matplotlib-3.8[${PYTHON_USEDEP}]
			>=dev-pypi/numpy-1.25[${PYTHON_USEDEP}]
			>=dev-py/scipy-1.11.2[${PYTHON_USEDEP}]
		' "${PYTHON_FULLY_TESTED[@]}")
	)
"

EPYTEST_PLUGINS=()
EPYTEST_XDIST=1
distutils_enable_tests pytest

src_test() {
	virtx distutils-r1_src_test
}

python_test() {
	# virtx implies nonfatal
	nonfatal epytest || die
}

src_install() {
	distutils-r1_src_install
	# those examples use various assets and pre-compressed files
	docompress -x /usr/share/doc/${PF}/examples
}

pkg_postinst() {
	optfeature "recommended dependencies" "dev-pypi/matplotlib dev-pypi/numpy dev-py/pandas dev-py/scipy"
	optfeature "graph drawing and graph layout algorithms" dev-py/pygraphviz dev-py/pydot
	optfeature "YAML format reading and writing" dev-pypi/pyyaml
	optfeature "shapefile format reading and writing" "sci-libs/gdal[python]"
	optfeature "GraphML XML format" dev-py/lxml
}
