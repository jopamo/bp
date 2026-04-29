# Distributed under the terms of the GNU General Public License v2

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( pypy3_11 python3_{11..14} )

inherit distutils-r1
# lockstep-pypi-managed: true
# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/anyio
"
# lockstep-pypi-deps: end
MY_P=${P/_p/.post}
DESCRIPTION="The little ASGI framework that shines"
HOMEPAGE="
	https://www.starlette.io/
	https://github.com/Kludex/starlette/
	https://pypi.org/project/starlette/
"
# no docs or tests in sdist, as of 0.27.0
SRC_URI="
	https://github.com/Kludex/starlette/archive/${PV/_p/.post}.tar.gz
		-> ${MY_P}.gh.tar.gz
"
S=${WORKDIR}/${MY_P}

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
	<dev-py/anyio-5[${PYTHON_USEDEP}]
	>=dev-py/anyio-3.6.2[${PYTHON_USEDEP}]
	<dev-py/httpx-0.29[${PYTHON_USEDEP}]
	>=dev-py/httpx-0.22.0[${PYTHON_USEDEP}]
	dev-py/itsdangerous[${PYTHON_USEDEP}]
	dev-py/jinja[${PYTHON_USEDEP}]
	>=dev-py/python-multipart-0.0.18[${PYTHON_USEDEP}]
	dev-py/pyyaml[${PYTHON_USEDEP}]
	$(python_gen_cond_dep '
		>=dev-py/typing-extensions-3.10.0[${PYTHON_USEDEP}]
	' 3.11)
"
BDEPEND="
	test? (
		>=dev-py/pytest-8[${PYTHON_USEDEP}]
		dev-py/trio[${PYTHON_USEDEP}]
	)
"

EPYTEST_PLUGINS=( anyio )
: ${EPYTEST_TIMEOUT:-180}
distutils_enable_tests pytest

EPYTEST_IGNORE=(
	# Unpackaged 'databases' dependency
	tests/test_database.py
)
