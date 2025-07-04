# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( pypy3_11 python3_{11..14} )

inherit distutils-r1 pypi

DESCRIPTION="Library for making terminal apps using colors, keyboard input and positioning"
HOMEPAGE="
	https://github.com/jquast/blessed/
	https://pypi.org/project/blessed/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
	dev-python/wcwidth[${PYTHON_USEDEP}]
"

distutils_enable_sphinx docs dev-python/sphinx-rtd-theme
EPYTEST_XDIST=1
distutils_enable_tests pytest

python_prepare_all() {
	# Skip those extensions as they don't have a Gentoo package
	# Remove calls to scripts that generate rst files because they
	# are not present in the tarball
	sed -e '/sphinxcontrib.manpage/d' -e '/sphinx_paramlinks/d' \
		-e '/^for script in/,/runpy.run_path/d' \
		-i docs/conf.py || die
	distutils-r1_python_prepare_all
}

python_test() {
	# COLORTERM must not be truecolor
	# See https://github.com/jquast/blessed/issues/162
	# Ignore coverage options
	COLORTERM= epytest --override-ini="addopts="
}
