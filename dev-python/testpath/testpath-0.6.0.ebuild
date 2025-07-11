# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=flit
PYTHON_COMPAT=( pypy3_11 python3_{11..14} python3_{13,14}t )

inherit distutils-r1

DESCRIPTION="Test utilities for code working with files and commands"
HOMEPAGE="
	https://github.com/jupyter/testpath/
	https://testpath.readthedocs.io/en/latest/
	https://pypi.org/project/testpath/
"
SRC_URI="
	https://github.com/jupyter/testpath/archive/${PV}.tar.gz
		-> ${P}.gh.tar.gz
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

distutils_enable_tests pytest
distutils_enable_sphinx doc
