# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=flit
PYTHON_COMPAT=( pypy3 python3_{10..13} )

inherit distutils-r1

DESCRIPTION="A Python library for creating 'editable wheels'"
HOMEPAGE="
	https://pypi.org/project/editables/
	https://github.com/pfmoore/editables/
"
SRC_URI="
	https://github.com/pfmoore/editables/archive/${PV}.tar.gz
		-> ${P}.gh.tar.gz
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

distutils_enable_tests pytest
