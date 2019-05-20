# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit distutils-r1

DESCRIPTION="package to manage versions by scm tags via setuptools"
HOMEPAGE="https://github.com/pypa/setuptools_scm https://pypi.org/project/setuptools_scm/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0/1"
KEYWORDS="amd64 arm64"

IUSE="test"

RESTRICT="!test? ( test )"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"

python_prepare_all() {
	# network access
	sed -i -e 's:test_pip_download:_&:' testing/test_regressions.py || die
	# all fetch specific setuptools versions
	rm testing/test_setuptools_support.py || die
	# remove self-dependency
	sed -i -e "/arguments\.update/s@scm_config()@{'version': '${PV}'}@" \
		-e "/__main__/i del sys.path[0]" setup.py || die

	distutils-r1_python_prepare_all
}

python_test() {
	PYTHONPATH= distutils_install_for_testing
	py.test -v -v -x || die "Tests fail with ${EPYTHON}"
}

python_install() {
	PYTHONPATH= distutils-r1_python_install
}
