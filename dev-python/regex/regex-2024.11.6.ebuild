# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
# pypy isn't supported upstream because of its UTF8 representation for strings
# See https://github.com/mrabarnett/mrab-regex/issues/521#issuecomment-1936260187.
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1 pypi flag-o-matic

DESCRIPTION="Alternative regular expression module to replace re"
HOMEPAGE="
	https://github.com/mrabarnett/mrab-regex/
	https://pypi.org/project/regex/
"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="doc"

distutils_enable_tests unittest

python_install_all() {
	filter-flags -Wl,-z,defs
	append-flags -ffat-lto-objects
	use doc && local HTML_DOCS=( docs/Features.html )
	local DOCS=( README.rst docs/*.rst )

	distutils-r1_python_install_all
}
