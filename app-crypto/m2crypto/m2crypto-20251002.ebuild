# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools

PYPI_PN="M2Crypto"

inherit distutils-r1 toolchain-funcs pypi flag-o-matic

DESCRIPTION="A Python crypto and SSL toolkit"
HOMEPAGE="
	https://gitlab.com/m2crypto/m2crypto/
	https://pypi.org/project/M2Crypto/
"

SNAPSHOT=c59eb6ed8f61d7c0041fa06000b9c2e3f6b174a2
SRC_URI="https://gitlab.com/m2crypto/m2crypto/-/archive/${SNAPSHOT}/${PN}-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="MIT openssl"
SLOT="0"
KEYWORDS="amd64 arm64"

swig_define() {
	local x
	for x; do
		if tc-cpp-is-true "defined(${x})"; then
			SWIG_FEATURES+=" -D${x}"
		fi
	done
}

src_prepare() {
	filter-flags -Wl,-z,defs

	# relies on very exact clock behavior which apparently fails
	# with inconvenient CONFIG_HZ*
	sed -e 's:test_server_simple_timeouts:_&:' \
		-i tests/test_ssl.py || die
	distutils-r1_src_prepare
}

python_compile() {
	# setup.py looks at platform.machine() to determine swig options.
	# For exotic ABIs, we need to give swig a hint.
	local -x SWIG_FEATURES=

	distutils-r1_python_compile
}

python_test() {
	"${EPYTHON}" -m unittest -b -v tests.alltests.suite ||
		die "Tests failed for ${EPYTHON}"
}
