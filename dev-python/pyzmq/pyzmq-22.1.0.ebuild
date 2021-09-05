# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic distutils-r1 toolchain-funcs

DESCRIPTION="Lightweight and super-fast messaging library built on top of the ZeroMQ library"
HOMEPAGE="http://www.zeromq.org/bindings:python https://pypi.org/project/pyzmq/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="test"

RDEPEND="
	lib-live/libzmq
	dev-python/cffi:=[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}
	dev-python/cython[${PYTHON_USEDEP}]
	test? (
		dev-python/pytest[${PYTHON_USEDEP}]
		>=www-servers/tornado-5.0.2[${PYTHON_USEDEP}]
	)"

PATCHES=( "${FILESDIR}"/${P}-test_message.patch )

python_prepare_all() {
	# Prevent un-needed download during build
	sed -e "/'sphinx.ext.intersphinx',/d" -i docs/source/conf.py || die
	distutils-r1_python_prepare_all
}

python_configure_all() {
	tc-export CC
	append-cppflags -DZMQ_BUILD_DRAFT_API=1
}

python_compile() {
	esetup.py cython --force
	python_is_python3 || local -x CFLAGS="${CFLAGS} -fno-strict-aliasing"
	distutils-r1_python_compile
}

python_test() {
	${EPYTHON} -m pytest -v "${BUILD_DIR}/lib" || die
}
