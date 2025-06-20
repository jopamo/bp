# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( pypy3_11 python3_{11..14} )

inherit distutils-r1 pypi

DESCRIPTION="Turn HTML into equivalent Markdown-structured text"
HOMEPAGE="
	https://github.com/Alir3z4/html2text/
	https://pypi.org/project/html2text/
"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"

DOCS=( AUTHORS.rst ChangeLog.rst README.md )

BDEPEND="
	dev-py/setuptools-scm[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest

src_prepare() {
	# naming conflict with app-text/html2text, bug 421647
	sed -e 's/html2text = "html2text.cli:main"/py\0/' -i pyproject.toml || die
	distutils-r1_src_prepare
}
