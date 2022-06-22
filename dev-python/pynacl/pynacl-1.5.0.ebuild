# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit distutils-r1 flag-o-matic

DESCRIPTION="Python binding to the Networking and Cryptography (NaCl) library"
HOMEPAGE="https://github.com/pyca/pynacl/ https://pypi.org/project/PyNaCl/"
SRC_URI="https://github.com/pyca/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="test"

RDEPEND="
	dev-python/six[${PYTHON_USEDEP}]
	>=dev-python/cffi-1.4.1[${PYTHON_USEDEP}]
	lib-live/libsodium
"
DEPEND="${RDEPEND}
	dev-python/wheel[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( >=dev-python/hypothesis-3.27.0[${PYTHON_USEDEP}]
		>=dev-python/pytest-3.2.1[${PYTHON_USEDEP}] )
"

filter-flags -Wl,-z,defs

src_prepare() {
	# For not using the bundled libsodium
	export SODIUM_INSTALL=system
	distutils-r1_python_prepare_all
}

python_test() {
	py.test -v || die "Tests failed under ${EPYTHON}"
}
