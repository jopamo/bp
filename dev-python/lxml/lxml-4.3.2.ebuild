# Distributed under the terms of the GNU General Public License v2

EAPI=6


inherit distutils-r1 eutils flag-o-matic toolchain-funcs

DESCRIPTION="A Pythonic binding for the libxml2 and libxslt libraries"
HOMEPAGE="http://lxml.de/ https://pypi.python.org/pypi/lxml/ https://github.com/lxml/lxml"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD ElementTree GPL-2 PSF-2"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="test"

# Note: lib{xml2,xslt} are used as C libraries, not Python modules.
RDEPEND="
	>=lib-dev/libxml2-2.9.2
	>=lib-dev/libxslt-1.1.28"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/cssselect[${PYTHON_USEDEP}] )
	"

DISTUTILS_IN_SOURCE_BUILD=1

PATCHES=(
	"${FILESDIR}"/${PN}-3.5.0-cross-compile.patch
	"${FILESDIR}"/${PN}-3.6.4-fix-test_xmlschema.patch
)

python_prepare_all() {
	# avoid replacing PYTHONPATH in tests.
	sed -i '/sys\.path/d' test.py || die

	distutils-r1_python_prepare_all
}

python_compile() {
	if [[ ${EPYTHON} != python3* ]]; then
		local -x CFLAGS="${CFLAGS}"
		append-cflags -fno-strict-aliasing
	fi
	tc-export PKG_CONFIG
	distutils-r1_python_compile
}

python_test() {
	cp -r -l src/lxml/tests "${BUILD_DIR}"/lib/lxml/ || die
	cp -r -l src/lxml/html/tests "${BUILD_DIR}"/lib/lxml/html/ || die
	ln -s "${S}"/doc "${BUILD_DIR}"/ || die

	"${EPYTHON}" test.py -vv --all-levels -p || die "Test ${test} fails with ${EPYTHON}"
}

python_install_all() {
	distutils-r1_python_install_all
}
