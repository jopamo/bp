# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} pypy3_11 )

inherit distutils-r1

DESCRIPTION="Pure-Python HPACK header compression"
HOMEPAGE="
	https://python-hyper.org/projects/hpack/en/latest/
	https://github.com/python-hyper/hpack/
	https://pypi.org/project/hpack/
"
# PyPI sdist is missing test fixtures, as of 4.0.0
SRC_URI="
	https://github.com/python-hyper/hpack/archive/v${PV}.tar.gz
		-> ${P}.gh.tar.gz
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

BDEPEND="
	test? (
		>=dev-python/hypothesis-3.4.2[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
