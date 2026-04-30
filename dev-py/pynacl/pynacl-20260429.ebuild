# Distributed under the terms of the GNU General Public License v2

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( pypy3_11 python3_{11..14} )

inherit distutils-r1 flag-o-matic
# lockstep-pypi-managed: true
# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/cffi
"
# lockstep-pypi-deps: end
DESCRIPTION="Python binding to the Networking and Cryptography (NaCl) library"
HOMEPAGE="https://github.com/pyca/pynacl/"
SNAPSHOT=676db55a7cd96ace2b0f3b97a4ad0ebd55f523aa
SRC_URI="https://github.com/pyca/pynacl/archive/${SNAPSHOT}.tar.gz -> pynacl-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/pynacl-${SNAPSHOT}

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	lib-core/libsodium:=
"
RDEPEND="
	${DEPEND}
	$(python_gen_cond_dep '
		>=dev-pypi/cffi-1.4.1[${PYTHON_USEDEP}]
	' 'python*')
"
BDEPEND="
	$(python_gen_cond_dep '
		>=dev-pypi/cffi-1.4.1[${PYTHON_USEDEP}]
	' 'python*')
	test? (
		>=dev-pypi/hypothesis-3.27.0[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

src_compile() {
	filter-flags -Wl,-z,defs
	# For not using the bundled libsodium
	local -x SODIUM_INSTALL=system
	distutils-r1_src_compile
}
