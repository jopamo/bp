# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} pypy3_11 )
PYTHON_REQ_USE="xml(+)"

inherit distutils-r1 pypi

DESCRIPTION="HTML parser based on the HTML5 specification"
HOMEPAGE="https://github.com/html5lib/html5lib-python/"

SNAPSHOT=fd4f032bc090d44fb11a84b352dad7cbee0a4745
SRC_URI="https://github.com/html5lib/html5lib-python/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-python-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="test"

RDEPEND="
	>=dev-python/six-1.9[${PYTHON_USEDEP}]
	dev-python/webencodings[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		dev-python/pytest-expect[${PYTHON_USEDEP}]
	)
"

src_prepare() {
	# switch only the README/CHANGES codecs.open calls to open(..., encoding='utf-8') to avoid buffering arg issues
	sed -E -i \
		"s/codecs\.open\(\s*join\(here,\s*'README\.rst'\)\s*,\s*'r'\s*,\s*'utf8'\s*\)/open(join(here, 'README.rst'), 'r', encoding='utf-8')/" \
		setup.py || die
	sed -E -i \
		"s/codecs\.open\(\s*join\(here,\s*'CHANGES\.rst'\)\s*,\s*'r'\s*,\s*'utf8'\s*\)/open(join(here, 'CHANGES.rst'), 'r', encoding='utf-8')/" \
		setup.py || die

	# make the ast version extraction work on Python 3.14 by using ast.Constant and .value
	sed -E -i \
		's/isinstance\(\s*a\.value\s*,\s*ast\.Str\s*\)/isinstance(a.value, ast.Constant) and isinstance(a.value.value, str)/' \
		setup.py || die
	sed -E -i \
		's/\ba\.value\.s\b/a.value.value/' \
		setup.py || die

	# optional: quiet legacy mock import in tests
	sed -e 's:from mock:from unittest.mock:' \
		-i html5lib/tests/test_meta.py || die

	distutils-r1_src_prepare
}
