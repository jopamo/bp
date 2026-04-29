# Distributed under the terms of the GNU General Public License v2

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( pypy3_11 python3_{11..14} python3_{13,14}t )

inherit distutils-r1
# lockstep-pypi-managed: true
# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/hatchling
	dev-pypi/setuptools-scm
"
# lockstep-pypi-deps: end
DESCRIPTION="Hatch plugin for versioning with your preferred VCS"
HOMEPAGE="
	https://pypi.org/project/hatch-vcs/
	https://github.com/ofek/hatch-vcs/
"
SRC_URI="
	https://github.com/ofek/hatch-vcs/archive/v${PV}.tar.gz
		-> ${P}.gh.tar.gz
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
	>=dev-py/setuptools-scm-8.2.0[${PYTHON_USEDEP}]
"
BDEPEND="
	
"

distutils_enable_tests pytest
