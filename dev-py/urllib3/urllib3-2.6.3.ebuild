# Distributed under the terms of the GNU General Public License v2


DISTUTILS_USE_PEP517=hatchling
PYPI_VERIFY_REPO=https://github.com/urllib3/urllib3
PYTHON_TESTED=( python3_{11..14} pypy3_11 )
PYTHON_COMPAT=( "${PYTHON_TESTED[@]}" )
PYTHON_REQ_USE="ssl(+)"

inherit distutils-r1 pypi
# lockstep-pypi-managed: true
# lockstep-pypi-deps: begin
RDEPEND+="
"
# lockstep-pypi-deps: end
# The package has a test dependency on their own hypercorn fork.
HYPERCORN_COMMIT=d1719f8c1570cbd8e6a3719ffdb14a4d72880abb
DESCRIPTION="HTTP library with thread-safe connection pooling, file post, and more"
HOMEPAGE="
	https://github.com/urllib3/urllib3/
	https://pypi.org/project/urllib3/
"
SRC_URI+="
	test? (
		https://github.com/urllib3/hypercorn/archive/${HYPERCORN_COMMIT}.tar.gz
			-> hypercorn-${HYPERCORN_COMMIT}.gh.tar.gz
	)
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="brotli http2 test zstd"
RESTRICT="!test? ( test )"

# [secure] extra is deprecated and slated for removal, we don't need it:
# https://github.com/urllib3/urllib3/issues/2680
RDEPEND="
	>=dev-py/pysocks-1.5.8[${PYTHON_USEDEP}]
	<dev-py/pysocks-2.0[${PYTHON_USEDEP}]
	brotli? ( >=dev-py/brotlicffi-1.2.0.0[${PYTHON_USEDEP}] )
	http2? (
		<dev-py/h2-5[${PYTHON_USEDEP}]
		>=dev-py/h2-4[${PYTHON_USEDEP}]
	)
	zstd? (
		$(python_gen_cond_dep '
			>=dev-py/backports-zstd-1.0.0[${PYTHON_USEDEP}]
		' 3.{11..13})
	)
"
BDEPEND="
	dev-py/hatch-vcs[${PYTHON_USEDEP}]
	test? (
		$(python_gen_cond_dep "
			${RDEPEND}
			dev-py/brotlicffi[\${PYTHON_USEDEP}]
			dev-py/freezegun[\${PYTHON_USEDEP}]
			dev-py/h2[\${PYTHON_USEDEP}]
			dev-py/httpx[\${PYTHON_USEDEP}]
			dev-py/pytest[\${PYTHON_USEDEP}]
			dev-py/pytest-rerunfailures[\${PYTHON_USEDEP}]
			dev-py/pytest-timeout[\${PYTHON_USEDEP}]
			dev-py/pytest-xdist[\${PYTHON_USEDEP}]
			dev-py/quart[\${PYTHON_USEDEP}]
			dev-py/quart-trio[\${PYTHON_USEDEP}]
			dev-py/trio[\${PYTHON_USEDEP}]
			>=dev-py/tornado-4.2.1[\${PYTHON_USEDEP}]
			>=dev-py/trustme-0.5.3[\${PYTHON_USEDEP}]
		" "${PYTHON_TESTED[@]}")
		$(python_gen_cond_dep '
			>=dev-py/backports-zstd-1.0.0[${PYTHON_USEDEP}]
		' 3.{11..13})
	)
"

src_prepare() {
	# upstream considers 0.5 s to be "long" for a timeout
	# we get tons of test failures on *fast* systems because of that
	sed -i -e '/LONG_TIMEOUT/s:0.5:5:' test/__init__.py || die
	distutils-r1_src_prepare
}

python_test() {
	local -x PYTHONPATH=${WORKDIR}/hypercorn-${HYPERCORN_COMMIT}/src
	local -x CI=1
	if ! has "${EPYTHON}" "${PYTHON_TESTED[@]/_/.}"; then
		einfo "Skipping tests on ${EPYTHON}"
		return
	fi

	local EPYTEST_DESELECT=(
		# TODO: timeouts
		test/contrib/test_pyopenssl.py::TestSocketClosing::test_timeout_errors_cause_retries
		test/with_dummyserver/test_socketlevel.py::TestSocketClosing::test_timeout_errors_cause_retries
		# TODO
		test/contrib/test_pyopenssl.py::TestSocketClosing::test_socket_shutdown_stops_recv
		test/with_dummyserver/test_socketlevel.py::TestSocketClosing::test_socket_shutdown_stops_recv
		# hangs randomly
		test/contrib/test_pyopenssl.py::TestHTTPS_TLSv1_{2,3}::test_http2_probe_blocked_per_thread
		test/with_dummyserver/test_https.py::TestHTTPS_TLSv1_{2,3}::test_http2_probe_blocked_per_thread
	)

	local EPYTEST_PLUGINS=( pytest-timeout )
	local EPYTEST_RERUNS=10
	local EPYTEST_XDIST=1
	epytest --reruns-delay=2
}
