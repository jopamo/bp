# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=standalone
PYTHON_COMPAT=( python3_{11..14} python3_{13,14}t pypy3_11 )

inherit distutils-r1

DESCRIPTION="A PEP 517 backend for PDM that supports PEP 621 metadata"
HOMEPAGE="
	https://pypi.org/project/pdm-backend/
	https://github.com/pdm-project/pdm-backend/
"
SRC_URI="
	https://github.com/pdm-project/pdm-backend/archive/${PV}.tar.gz
		-> ${P}.gh.tar.gz
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

# see src/pdm/backend/_vendor/vendor.txt
RDEPEND="
	>=dev-python/editables-0.5[${PYTHON_USEDEP}]
	>=dev-python/packaging-24.0[${PYTHON_USEDEP}]
	>=dev-python/pyproject-metadata-0.9.0_beta7[${PYTHON_USEDEP}]
	>=dev-python/tomli-w-1.0.0[${PYTHON_USEDEP}]

	$(python_gen_cond_dep '
		>=dev-python/tomli-2.0.1[${PYTHON_USEDEP}]
	' 3.10)
"
BDEPEND="
	${RDEPEND}
	test? (
		dev-py/setuptools[${PYTHON_USEDEP}]
	)
"
# setuptools are used to build C extensions
RDEPEND+="
	dev-py/setuptools[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest

src_prepare() {
	rm -r src/pdm/backend/_vendor || die
	find -name '*.py' -exec sed \
		-e 's:from pdm\.backend\._vendor\.:from :' \
		-e 's:from pdm\.backend\._vendor ::' \
		-e 's:import pdm\.backend\._vendor\.:import :' \
		-i {} + || die
	distutils-r1_src_prepare
}

src_compile() {
	# this must not be set during src_test()
	local -x PDM_BUILD_SCM_VERSION=${PV}
	distutils-r1_src_compile
}

src_test() {
	git config --global user.email "test@example.com" || die
	git config --global user.name "Test User" || die
	distutils-r1_src_test
}

python_test() {
	local -x PYTEST_DISABLE_PLUGIN_AUTOLOAD=1
	epytest -k "not [hg"
}
