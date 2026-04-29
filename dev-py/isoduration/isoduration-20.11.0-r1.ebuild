# Distributed under the terms of the GNU General Public License v2

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} pypy3_11 )

inherit distutils-r1
# lockstep-pypi-managed: true
# lockstep-pypi-deps: begin
RDEPEND+="
"
# lockstep-pypi-deps: end
DESCRIPTION="Operations with ISO 8601 durations"
HOMEPAGE="
	https://pypi.org/project/isoduration/
	https://github.com/bolsote/isoduration/
"
SRC_URI="
	https://github.com/bolsote/isoduration/archive/${PV}.tar.gz
		-> ${P}.gh.tar.gz
"

LICENSE="ISC"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
	>=dev-py/arrow-0.15.0[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		dev-py/hypothesis[${PYTHON_USEDEP}]
		dev-py/isodate[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

EPYTEST_IGNORE=(
	tests/test_benchmark.py
)
