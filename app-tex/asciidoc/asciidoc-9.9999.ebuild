# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools python-single-r1 git-r3

DESCRIPTION="A plain text human readable/writable document format"
HOMEPAGE="https://asciidoc.org/ https://github.com/asciidoc-py/asciidoc-py/"

EGIT_REPO_URI="https://github.com/asciidoc-py/asciidoc-py.git"
EGIT_BRANCH="$(ver_cut 1).x"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="doc test"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RESTRICT="!test? ( test )"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	econf --sysconfdir="${EPREFIX}"/usr/share
}

src_install() {
	default

	python_fix_shebang "${ED}"/usr/bin/*.py
}
