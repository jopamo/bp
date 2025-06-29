# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} pypy3_11 )

inherit distutils-r1

DESCRIPTION="Minimal PyPI server"
HOMEPAGE="
	https://github.com/pypiserver/pypiserver/
	https://pypi.org/project/pypiserver/
"
SRC_URI="
	https://github.com/pypiserver/pypiserver/archive/v${PV}.tar.gz
		-> ${P}.gh.tar.gz
"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
	dev-python/bottle[${PYTHON_USEDEP}]
	>=dev-python/packaging-23.2[${PYTHON_USEDEP}]
	>=dev-python/pip-7[${PYTHON_USEDEP}]
	$(python_gen_cond_dep '
		dev-python/importlib-resources[${PYTHON_USEDEP}]
	' 3.11)
"
# NB: many test deps are optional/specific to tests we skip
BDEPEND="
	dev-py/setuptools-git[${PYTHON_USEDEP}]
	test? (
		>=dev-python/build-1.2.0[${PYTHON_USEDEP}]
		>=dev-python/passlib-1.6[${PYTHON_USEDEP}]
		dev-py/setuptools[${PYTHON_USEDEP}]
		dev-python/webtest[${PYTHON_USEDEP}]
	)
"

DOCS=( CHANGES.rst README.md )

PATCHES=(
	"${FILESDIR}/${PN}-2.3.1-unbundle-bottle.patch"
)

distutils_enable_tests pytest

src_prepare() {
	distutils-r1_src_prepare

	# remove bundled bottle
	rm pypiserver/bottle.py || die
}

python_test() {
	local EPYTEST_DESELECT=(
		# Internet
		tests/test_server.py::test_hash_algos
		tests/test_server.py::test_pip_install_open_succeeds
		tests/test_server.py::test_pip_install_authed_succeeds
		# seems to rely on internal bottle details
		tests/test_main.py::test_auto_servers
	)

	if ! has_version "dev-python/twine[${PYTHON_USEDEP}]"; then
		EPYTEST_DESELECT+=(
			tests/test_server.py::test_twine_upload
			tests/test_server.py::test_twine_register
		)
	fi

	local -x PYTEST_DISABLE_PLUGIN_AUTOLOAD=1
	epytest tests
}
