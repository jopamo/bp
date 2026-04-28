# Distributed under the terms of the GNU General Public License v2

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( pypy3_11 python3_{11..14} python3_{13,14}t )

inherit distutils-r1 pypi
# lockstep-pypi-managed: true
# lockstep-pypi-deps: begin
RDEPEND+="
"
# lockstep-pypi-deps: end

DESCRIPTION="Expand system variables Unix style"
HOMEPAGE="
	https://github.com/sayanarijit/expandvars/
	https://pypi.org/project/expandvars/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
