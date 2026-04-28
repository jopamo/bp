# Distributed under the terms of the GNU General Public License v2

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( pypy3_11 python3_{11..14} )

inherit distutils-r1
# lockstep-pypi-managed: true
# lockstep-pypi-deps: begin
RDEPEND+="
"
# lockstep-pypi-deps: end

MY_P=uc.micro-py-${PV}
DESCRIPTION="Micro subset of unicode data files for linkify-it-py projects"
HOMEPAGE="
	https://github.com/tsutsu3/uc.micro-py/
	https://pypi.org/project/uc-micro-py/
"
SRC_URI="
	https://github.com/tsutsu3/uc.micro-py/archive/refs/tags/v${PV}.tar.gz
		-> ${MY_P}.gh.tar.gz
"
S=${WORKDIR}/${MY_P}

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

distutils_enable_tests pytest
