# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} python3_13t pypy3 pypy3_11 )

inherit distutils-r1

DESCRIPTION="multidict implementation"
HOMEPAGE="
	https://github.com/aio-libs/multidict/
	https://pypi.org/project/multidict/
"
SRC_URI="
	https://github.com/aio-libs/${PN}/archive/v${PV}.tar.gz
		-> ${P}.gh.tar.gz
"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="+native-extensions"

RDEPEND="
	$(python_gen_cond_dep '
		>=dev-python/typing-extensions-4.1.0[${PYTHON_USEDEP}]
	' 3.10)
"
BDEPEND="
	test? (
		dev-python/objgraph[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

python_prepare_all() {
	filter-flags -Wl,-z,defs
	# don't enable coverage or other pytest settings
	sed -i -e '/cov/d' pytest.ini || die
	# don't force -O3
	sed -i -e 's:"-O3"::' setup.py || die
	distutils-r1_python_prepare_all
}

python_compile() {
	filter-flags -Wl,-z,defs
	if ! use native-extensions || [[ ${EPYTHON} == pypy3* ]]; then
		local -x MULTIDICT_NO_EXTENSIONS=1
	fi

	distutils-r1_python_compile
}

python_test() {
	local EPYTEST_IGNORE=(
		tests/test_multidict_benchmarks.py
		tests/test_views_benchmarks.py
	)

	rm -rf multidict || die

	local cext=--c-extensions
	if ! use native-extensions || [[ ${EPYTHON} == pypy3* ]]; then
		cext=--no-c-extensions
	fi
	epytest "${cext}"
}
