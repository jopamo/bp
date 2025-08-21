# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( pypy3_11 python3_{11..14} )

inherit distutils-r1 flag-o-matic

DESCRIPTION="Python binding to the Networking and Cryptography (NaCl) library"
HOMEPAGE="https://github.com/pyca/pynacl/"
SNAPSHOT=b712d60990092eaf58f3b5ff5858f904dd8159f4
SRC_URI="https://github.com/pyca/pynacl/archive/${SNAPSHOT}.tar.gz -> pynacl-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/pynacl-${SNAPSHOT}

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	lib-util/libsodium:=
"
RDEPEND="
	${DEPEND}
	$(python_gen_cond_dep '
		>=dev-python/cffi-1.4.1[${PYTHON_USEDEP}]
	' 'python*')
"
BDEPEND="
	$(python_gen_cond_dep '
		>=dev-python/cffi-1.4.1[${PYTHON_USEDEP}]
	' 'python*')
	test? (
		>=dev-python/hypothesis-3.27.0[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

src_compile() {
	filter-flags -Wl,-z,defs
	# For not using the bundled libsodium
	local -x SODIUM_INSTALL=system
	distutils-r1_src_compile
}
