# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=flit
PYTHON_COMPAT=( python3_{11..14} pypy3_11 )

inherit distutils-r1 pypi 

DESCRIPTION="CFFI-based drop-in replacement for Pycairo"
HOMEPAGE="
	https://github.com/Kozea/cairocffi/
	https://pypi.org/project/cairocffi/
"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	>=dev-python/xcffib-0.3.2[${PYTHON_USEDEP}]
	x11-libs/cairo:0=[X,xcb(+)]
	x11-libs/gdk-pixbuf[jpeg]
"
RDEPEND="
	${DEPEND}
	$(python_gen_cond_dep '
		>=dev-python/cffi-1.1.0:=[${PYTHON_USEDEP}]
	' 'python*')
"
BDEPEND="
	dev-py/setuptools[${PYTHON_USEDEP}]
	$(python_gen_cond_dep '
		>=dev-python/cffi-1.1.0:=[${PYTHON_USEDEP}]
	' 'python*')
	test? (
		dev-py/numpy[${PYTHON_USEDEP}]
		dev-python/pikepdf[${PYTHON_USEDEP}]
	)
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest

PATCHES=(
	"${FILESDIR}"/${PN}-0.8.0-tests.patch
)

src_test() {
	virtx distutils-r1_src_test
}
