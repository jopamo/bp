# Distributed under the terms of the GNU General Public License v2

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( pypy3_11 python3_{11..14} )

inherit distutils-r1 optfeature
# lockstep-pypi-managed: true
# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/certifi
	dev-pypi/h11
"
# lockstep-pypi-deps: end
DESCRIPTION="A minimal low-level HTTP client"
HOMEPAGE="
	https://www.encode.io/httpcore/
	https://github.com/encode/httpcore/
	https://pypi.org/project/httpcore/
"
SRC_URI="
	https://github.com/encode/httpcore/archive/${PV}.tar.gz
		-> ${P}.gh.tar.gz
"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
	<dev-pypi/anyio-5[${PYTHON_USEDEP}]
	dev-pypi/certifi[${PYTHON_USEDEP}]
	>=dev-pypi/h11-0.16[${PYTHON_USEDEP}]
	<dev-pypi/h2-5[${PYTHON_USEDEP}]
	=dev-pypi/sniffio-1*[${PYTHON_USEDEP}]
"
BDEPEND="
	dev-pypi/hatch-fancy-pypi-readme[${PYTHON_USEDEP}]
	test? (
		dev-py/pytest-asyncio[${PYTHON_USEDEP}]
		dev-py/pytest-httpbin[${PYTHON_USEDEP}]
		dev-py/socksio[${PYTHON_USEDEP}]
		dev-pypi/trustme[${PYTHON_USEDEP}]
		$(python_gen_cond_dep '
			dev-py/pytest-trio[${PYTHON_USEDEP}]
			dev-pypi/trio[${PYTHON_USEDEP}]
		' 3.{11..13})
	)
"

distutils_enable_tests pytest

python_test() {
	local opts=()
	local EPYTEST_IGNORE=()

	if ! has_version "dev-pypi/trio[${PYTHON_USEDEP}]"; then
		opts+=( -k "not trio" )
		EPYTEST_IGNORE+=(
			tests/_async/test_connection_pool.py
		)
	fi

	if ! has_version "dev-py/pytest-trio[${PYTHON_USEDEP}]"; then
		opts+=( -m "not trio" -o addopts= )
	fi

	epytest "${opts[@]}"
}

pkg_postinst() {
	optfeature "SOCKS support" dev-py/socksio
}
