# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} pypy3_11 )

inherit distutils-r1

DESCRIPTION="tzinfo object for the local timezone"
HOMEPAGE="
	https://github.com/regebro/tzlocal/
	https://pypi.org/project/tzlocal/
"
# symlinks aren't correctly preserved in sdist, as of 5.0.1
SRC_URI="
	https://github.com/regebro/tzlocal/archive/${PV}.tar.gz
		-> ${P}.gh.tar.gz
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

BDEPEND="
	test? (
		dev-python/pytest-mock[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
