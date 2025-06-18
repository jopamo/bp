# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=flit
PYTHON_COMPAT=( python3_{11..14} pypy3_11 )

inherit distutils-r1

DESCRIPTION="Markdown URL utilities"
HOMEPAGE="
	https://pypi.org/project/mdurl/
	https://github.com/executablebooks/mdurl/
"
SRC_URI="
	https://github.com/hukkin/mdurl/archive/${PV}.tar.gz
		-> ${P}.gh.tar.gz
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

distutils_enable_tests pytest
