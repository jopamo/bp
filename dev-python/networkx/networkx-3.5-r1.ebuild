# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_FULLY_TESTED=( python3_{11..13} )
PYTHON_COMPAT=( "${PYTHON_FULLY_TESTED[@]}" python3_14 )

inherit distutils-r1 pypi 

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
			>=dev-py/matplotlib-3.8[${PYTHON_USEDEP}]
			>=dev-python/numpy-1.25[${PYTHON_USEDEP}]
			>=dev-python/scipy-1.11.2[${PYTHON_USEDEP}]
		' "${PYTHON_FULLY_TESTED[@]}")
	)
"

EPYTEST_XDIST=1
distutils_enable_tests pytest

PATCHES=(
	# minimal fix for https://github.com/networkx/networkx/issues/8091
	"${FILESDIR}/${P}-py314.patch"
)

src_test() {
	virtx distutils-r1_src_test
}

python_test() {
	local -x PYTEST_DISABLE_PLUGIN_AUTOLOAD=1
	# virtx implies nonfatal
	nonfatal epytest || die
}

src_install() {
	distutils-r1_src_install
	# those examples use various assets and pre-compressed files
	docompress -x /usr/share/doc/${PF}/examples
}

pkg_postinst() {
 "recommended dependencies" "dev-py/matplotlib dev-python/numpy dev-python/pandas dev-python/scipy"
 "graph drawing and graph layout algorithms" "dev-python/pygraphviz dev-python/pydot"
 "YAML format reading and writing" "dev-python/pyyaml"
 "shapefile format reading and writing" "sci-libs/gdal[python]"
 "GraphML XML format" "dev-py/lxml"
}
