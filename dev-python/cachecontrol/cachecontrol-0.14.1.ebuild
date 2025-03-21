# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=flit
PYTHON_COMPAT=( python3_{10..13} pypy3 pypy3_11 )

inherit distutils-r1 pypi

DESCRIPTION="httplib2 caching for requests"
HOMEPAGE="
	https://pypi.org/project/CacheControl/
	https://github.com/psf/cachecontrol/
"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
	<dev-python/msgpack-2[${PYTHON_USEDEP}]
	>=dev-python/msgpack-0.5.2[${PYTHON_USEDEP}]
	>=dev-python/requests-2.16.0[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		dev-python/cherrypy[${PYTHON_USEDEP}]
		>=dev-python/filelock-3.8.0[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
