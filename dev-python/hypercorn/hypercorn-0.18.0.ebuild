# Distributed under the terms of the GNU General Public License v2

DISTUTILS_USE_PEP517=pdm-backend
PYTHON_COMPAT=( pypy3_11 python3_{11..14} )

inherit distutils-r1
# lockstep-pypi-managed: true
# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/priority
	dev-python/h11
	dev-python/h2
	dev-python/wsproto
"
# lockstep-pypi-deps: end

DESCRIPTION="A ASGI Server based on Hyper libraries and inspired by Gunicorn"
HOMEPAGE="
	https://github.com/pgjones/hypercorn/
	https://pypi.org/project/Hypercorn/
"
SRC_URI="
	https://github.com/pgjones/hypercorn/archive/${PV}.tar.gz
		-> ${P}.gh.tar.gz
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
	dev-python/h11[${PYTHON_USEDEP}]
	>=dev-python/h2-4.3.0[${PYTHON_USEDEP}]
	dev-python/priority[${PYTHON_USEDEP}]
	>=dev-python/wsproto-0.14.0[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		dev-python/httpx[${PYTHON_USEDEP}]
		>=dev-python/trio-0.22.0[${PYTHON_USEDEP}]
	)
"

EPYTEST_PLUGINS=( pytest-{asyncio,trio} )
distutils_enable_tests pytest

src_prepare() {
	sed -i -e 's:--no-cov-on-fail::' pyproject.toml || die
	distutils-r1_src_prepare
}
