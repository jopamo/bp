# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} pypy3_11 )

inherit distutils-r1 pypi

DESCRIPTION="A fast and simple micro-framework for small web-applications"
HOMEPAGE="
	https://bottlepy.org/
	https://github.com/bottlepy/bottle/
	https://pypi.org/project/bottle/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="test"
RESTRICT="!test? ( test )"

BDEPEND="
	test? (
		dev-python/mako[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests unittest

pkg_postinst() {
 "Templating support" dev-python/mako
}
