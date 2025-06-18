# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1 pypi

DESCRIPTION="Modern password hashing for software and servers"
HOMEPAGE="https://pypi.org/project/bcrypt/"
SNAPSHOT=8cbf31dd2b8ee9c024a5b686a6f1876c35583659
SRC_URI="https://github.com/pyca/bcrypt/archive/${SNAPSHOT}.tar.gz -> bcrypt-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/bcrypt-${SNAPSHOT}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

RESTRICT="test network-sandbox"

BDEPEND=">=dev-py/setuptools-rust-1.7.0[${PYTHON_USEDEP}]"

QA_FLAGS_IGNORED="usr/lib.*/py.*/site-packages/bcrypt/_bcrypt.*.so"

distutils_enable_tests pytest

src_prepare() {
	distutils-r1_src_prepare
}

python_configure_all() {
	export RUSTFLAGS="${RUSTFLAGS} --cfg pyo3_unsafe_allow_subinterpreters"
}

python_test() {
	local -x PYTEST_DISABLE_PLUGIN_AUTOLOAD=1
	epytest tests
}
