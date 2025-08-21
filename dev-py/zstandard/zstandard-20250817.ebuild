# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1

MY_P=python-zstandard-${PV}
DESCRIPTION="Zstandard Bindings for Python"
HOMEPAGE="
	https://github.com/indygreg/python-zstandard/
	https://pypi.org/project/zstandard/
"

MY_PN="python-zstandard"
SNAPSHOT=3aa622286e5eaa92c6071c36a82b73660cf73270
SRC_URI="https://github.com/indygreg/python-zstandard/archive/${SNAPSHOT}.tar.gz -> ${MY_PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${MY_PN}-${SNAPSHOT}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
	${DEPEND}
	$(python_gen_cond_dep '
		>=dev-python/cffi-1.14.0-r2:=[${PYTHON_USEDEP}]
	' 'python*')
"
BDEPEND="
	test? (
		dev-python/hypothesis[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

src_prepare() {
	filter-flags -Wl,-z,defs

	distutils-r1_src_prepare

	DISTUTILS_ARGS=(
		--no-c-backend
	)
}

python_test() {
	local EPYTEST_DESELECT=(
		# unreliable, fails on x86
		tests/test_data_structures.py::TestCompressionParameters::test_estimated_compression_context_size
		# check for bundled zstd version, fails on other system zstd
		tests/test_module_attributes.py::TestModuleAttributes::test_version
	)

	rm -rf zstandard || die
	epytest
}
