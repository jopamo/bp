# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} pypy3 )

inherit distutils-r1

DESCRIPTION="Parse CSS3 Selectors and translate them to XPath 1.0"
HOMEPAGE="
	https://cssselect.readthedocs.io/en/latest/
	https://github.com/scrapy/cssselect/
	https://pypi.org/project/cssselect/
"
SRC_URI="
	https://github.com/scrapy/cssselect/archive/v${PV}.tar.gz
		-> ${P}.gh.tar.gz
"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

BDEPEND="
	test? (
		dev-python/lxml[${PYTHON_USEDEP}]
	)
"

distutils_enable_sphinx docs
distutils_enable_tests unittest
