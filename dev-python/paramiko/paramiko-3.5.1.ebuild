# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( pypy3_11 python3_{11..14} )
PYTHON_REQ_USE="threads(+)"

inherit distutils-r1

DESCRIPTION="SSH2 protocol library"
HOMEPAGE="
	https://www.paramiko.org/
	https://github.com/paramiko/paramiko/
	https://pypi.org/project/paramiko/
"
SRC_URI="
	https://github.com/paramiko/paramiko/archive/${PV}.tar.gz
		-> ${P}.gh.tar.gz
"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="examples server"

RDEPEND="
	>=dev-py/bcrypt-3.1.3[${PYTHON_USEDEP}]
	>=app-crypto/cryptography-2.5[${PYTHON_USEDEP}]
	>=dev-py/pynacl-1.0.1[${PYTHON_USEDEP}]
	>=dev-python/pyasn1-0.1.7[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		dev-python/pytest-rerunfailures[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

EPYTEST_DESELECT=(
	# upstream doesn't really maintain the gssapi support
	tests/test_gssapi.py
	tests/test_kex_gss.py
	tests/test_ssh_gss.py
)

src_prepare() {
	local PATCHES=(
		"${FILESDIR}/${PN}-3.2.0-nih-test-deps.patch"
	)

	if ! use server; then
		PATCHES+=( "${FILESDIR}/${PN}-3.2.0-disable-server.patch" )
	fi
	distutils-r1_src_prepare
}

python_test() {
	local -x PYTEST_DISABLE_PLUGIN_AUTOLOAD=1
	epytest -p rerunfailures --reruns=5
}

python_install_all() {
	distutils-r1_python_install_all

	if use examples; then
		docinto examples
		dodoc -r demos/*
	fi
}
