# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} python3_{13,14}t pypy3_11 )

inherit distutils-r1 pypi

DESCRIPTION="Python library providing a few tools handling SemVer in Python"
HOMEPAGE="
	https://github.com/rbarrois/python-semanticversion/
	https://pypi.org/project/semantic-version/
"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

distutils_enable_sphinx docs \
	dev-python/sphinx-rtd-theme
distutils_enable_tests pytest

python_test() {
	local -x PYTEST_DISABLE_PLUGIN_AUTOLOAD=1
	epytest
}
