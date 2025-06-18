# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_SINGLE_IMPL=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} pypy3 pypy3_11 )
inherit distutils-r1 git-r3

DESCRIPTION="A plain text human readable/writable document format"
HOMEPAGE="https://asciidoc.org/ https://github.com/asciidoc-py/asciidoc-py/"

EGIT_REPO_URI="https://github.com/asciidoc-py/asciidoc-py.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="test"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RESTRICT="!test? ( test )"

src_install() {
	distutils-r1_src_install

	insinto /usr/share/asciidoc
	doins -r asciidoc/resources/.
}
