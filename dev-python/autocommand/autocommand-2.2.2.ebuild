# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} pypy3 )

inherit distutils-r1

DESCRIPTION="Library to create a command-line program from a function"
HOMEPAGE="
	https://github.com/Lucretiel/autocommand/
	https://pypi.org/project/autocommand/
"
SRC_URI="
	https://github.com/Lucretiel/autocommand/archive/${PV}.tar.gz
		-> ${P}.gh.tar.gz
"

LICENSE="LGPL-3+"
SLOT="0"
KEYWORDS="amd64 arm64"

PATCHES=(
	"${FILESDIR}"/${PN}-2.2.2-setuptools-license.patch
)

distutils_enable_tests pytest
