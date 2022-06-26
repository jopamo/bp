# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit distutils-r1

DESCRIPTION="A fast and thorough lazy object proxy"
HOMEPAGE="
	https://github.com/ionelmc/python-lazy-object-proxy
	https://pypi.org/project/lazy-object-proxy/
	https://python-lazy-object-proxy.readthedocs.org/"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

BDEPEND="dev-python/setuptools_scm[${PYTHON_USEDEP}]"

distutils_enable_tests pytest

python_prepare_all() {
	# No need to benchmark
	sed \
		-e '/benchmark/s:test_:_&:g' \
		-e '/pytest.mark.benchmark/d' \
		-i tests/test_lazy_object_proxy.py || die
	distutils-r1_python_prepare_all
}
