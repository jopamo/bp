# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( pypy3_11 python3_{11..14} )

inherit distutils-r1 

DESCRIPTION="Fully-featured HTTP client which provides sync and async APIs"
HOMEPAGE="
	https://www.python-httpx.org/
	https://github.com/encode/httpx/
	https://pypi.org/project/httpx/
"
SRC_URI="
	https://github.com/encode/httpx/archive/${PV}.tar.gz
		-> ${P}.gh.tar.gz
"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="cli"

RDEPEND="
	dev-python/anyio[${PYTHON_USEDEP}]
	dev-python/certifi[${PYTHON_USEDEP}]
	=dev-python/httpcore-1*[${PYTHON_USEDEP}]
	dev-python/idna[${PYTHON_USEDEP}]
	cli? (
		=dev-python/click-8*[${PYTHON_USEDEP}]
		=dev-python/pygments-2*[${PYTHON_USEDEP}]
		dev-python/rich[${PYTHON_USEDEP}]
	)
"
# httptools cause tests to fail
# https://github.com/encode/httpx/discussions/3429
BDEPEND="
	dev-python/hatch-fancy-pypi-readme[${PYTHON_USEDEP}]
	test? (
		dev-python/brotlicffi[${PYTHON_USEDEP}]
		dev-python/chardet[${PYTHON_USEDEP}]
		app-crypto/cryptography[${PYTHON_USEDEP}]
		dev-python/h2[${PYTHON_USEDEP}]
		dev-python/socksio[${PYTHON_USEDEP}]
		dev-python/trustme[${PYTHON_USEDEP}]
		dev-python/typing-extensions[${PYTHON_USEDEP}]
		dev-python/uvicorn[${PYTHON_USEDEP}]
		>=dev-py/zstandard-0.18.0[${PYTHON_USEDEP}]
		$(python_gen_cond_dep '
			dev-python/trio[${PYTHON_USEDEP}]
		' 3.{11..13})
	)
"

distutils_enable_tests pytest

src_prepare() {
	local PATCHES=(
		"${FILESDIR}/${PN}-0.27.0-opt-trio.patch"
		# fix test failures when httptools are installed
		# https://github.com/encode/httpx/discussions/3429
		# https://gitlab.archlinux.org/archlinux/packaging/packages/python-httpx/-/blob/main/uvicorn-test-server-use-h11.diff
		"${FILESDIR}/${PN}-0.28.1-httptools-test.patch"
	)

	if ! use cli; then
		sed -i -e '/^httpx =/d' pyproject.toml || die
	fi
	sed -i -e '/rich/s:,<14::' pyproject.toml || die

	distutils-r1_src_prepare
}

python_test() {
	local args=()
	local EPYTEST_DESELECT=(
		# Internet
		tests/client/test_proxies.py::test_async_proxy_close
		tests/client/test_proxies.py::test_sync_proxy_close
	)

	use cli || EPYTEST_IGNORE+=(
		tests/test_main.py
	)

	if ! has_version "dev-python/trio[${PYTHON_USEDEP}]"; then
		args+=( -o filterwarnings= -k "not trio" )
	fi

	local -x PYTEST_DISABLE_PLUGIN_AUTOLOAD=1
	epytest -p anyio "${args[@]}"
}

pkg_postinst() {
 "HTTP/2 support" dev-python/h2
 "SOCKS proxy support" dev-python/socksio
 "Decoding for brotli compressed responses" dev-python/brotlicffi
}
