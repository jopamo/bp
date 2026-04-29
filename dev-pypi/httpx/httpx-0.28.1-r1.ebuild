# Distributed under the terms of the GNU General Public License v2

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( pypy3_11 python3_{11..14} )

inherit distutils-r1 optfeature
# lockstep-pypi-managed: true
# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/anyio
	dev-pypi/certifi
	dev-pypi/httpcore
	dev-pypi/idna
"
# lockstep-pypi-deps: end
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
	dev-pypi/anyio[${PYTHON_USEDEP}]
	dev-pypi/certifi[${PYTHON_USEDEP}]
	=dev-pypi/httpcore-1*[${PYTHON_USEDEP}]
	dev-pypi/idna[${PYTHON_USEDEP}]
	cli? (
		=dev-pypi/click-8*[${PYTHON_USEDEP}]
		=dev-pypi/pygments-2*[${PYTHON_USEDEP}]
		dev-pypi/rich[${PYTHON_USEDEP}]
	)
"
# httptools cause tests to fail
# https://github.com/encode/httpx/discussions/3429
BDEPEND="
	dev-pypi/hatch-fancy-pypi-readme[${PYTHON_USEDEP}]
	test? (
		dev-pypi/brotlicffi[${PYTHON_USEDEP}]
		dev-pypi/chardet[${PYTHON_USEDEP}]
		app-crypto/cryptography[${PYTHON_USEDEP}]
		dev-pypi/h2[${PYTHON_USEDEP}]
		dev-py/socksio[${PYTHON_USEDEP}]
		dev-pypi/trustme[${PYTHON_USEDEP}]
		dev-pypi/typing-extensions[${PYTHON_USEDEP}]
		dev-pypi/uvicorn[${PYTHON_USEDEP}]
		>=dev-py/zstandard-0.18.0[${PYTHON_USEDEP}]
		$(python_gen_cond_dep '
			dev-pypi/trio[${PYTHON_USEDEP}]
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

	if ! has_version "dev-pypi/trio[${PYTHON_USEDEP}]"; then
		args+=( -o filterwarnings= -k "not trio" )
	fi

	local -x PYTEST_DISABLE_PLUGIN_AUTOLOAD=1
	epytest -p anyio "${args[@]}"
}

pkg_postinst() {
	optfeature "HTTP/2 support" dev-pypi/h2
	optfeature "SOCKS proxy support" dev-py/socksio
	optfeature "Decoding for brotli compressed responses" dev-pypi/brotlicffi
}
