# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools git-r3

DESCRIPTION="The most popular spellchecking library."
HOMEPAGE="http://hunspell.github.io/"
EGIT_REPO_URI="https://github.com/hunspell/hunspell.git"

LICENSE="LGPL/GPL/MPL"
SLOT="0/1"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

src_prepare() {
	default
	eautoreconf
}

src_install() {
	default

	use static-libs || rm "${ED}"/usr/lib/libhunspell-1.7.a || die

	for x in libhunspell.so.1 libhunspell.so.1.0 libhunspell.so ; do
		dosym libhunspell-1.7.so.0.0.1 usr/lib/${x}
	done
}
