# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=flit
PYTHON_COMPAT=( pypy3_11 python3_{11..14} )

inherit distutils-r1 pypi

DESCRIPTION="Low-level, pure Python DBus protocol wrapper"
HOMEPAGE="
	https://gitlab.com/takluyver/jeepney/
	https://pypi.org/project/jeepney/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="examples"

BDEPEND="
	test? (
		$(python_gen_cond_dep '
			dev-python/async-timeout[${PYTHON_USEDEP}]
		' 3.10)
		>=dev-python/pytest-asyncio-0.7.1[${PYTHON_USEDEP}]
		dev-python/testpath[${PYTHON_USEDEP}]
		sys-apps/dbus
	)
"

distutils_enable_tests pytest

distutils_enable_sphinx docs \
	dev-python/sphinx-rtd-theme

src_test() {
	local dbus_params=(
		$(dbus-daemon --session --print-address --fork --print-pid)
	)
	local -x DBUS_SESSION_BUS_ADDRESS=${dbus_params[0]}

	distutils-r1_src_test

	kill "${dbus_params[1]}" || die
}

python_test() {
	local EPYTEST_IGNORE=()
	if ! has_version "dev-python/pytest-trio[${PYTHON_USEDEP}]"; then
		EPYTEST_IGNORE+=( jeepney/io/tests/test_trio.py )
	fi
	epytest
}

python_install_all() {
	if use examples; then
		docompress -x "/usr/share/doc/${PF}/examples"
		dodoc -r examples
	fi
	distutils-r1_python_install_all
}
