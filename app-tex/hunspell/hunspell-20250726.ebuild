# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="The most popular spellchecking library."
HOMEPAGE="http://hunspell.github.io/"
SNAPSHOT=96466a695cd1aabc2eb038e349a02b9970592d8c
SRC_URI="https://github.com/hunspell/hunspell/archive/${SNAPSHOT}.tar.gz -> hunspell-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/hunspell-${SNAPSHOT}"

LICENSE="LGPL/GPL/MPL"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs minimal"

DEPEND="app-tex/hunspell-dictionaries"

src_prepare() {
	default
	eautoreconf
}

src_install() {
	default

	use static-libs || rm -f "${ED}"/usr/lib/libhunspell-1.7.a || die
	use minimal && rm -f "${ED}"/usr/bin/{makealias,affixcompress,wordforms,ispellaff2myspell,wordlist2hunspell,munch,analyze,chmorph,unmunch,hunzip,hzip}

	for x in libhunspell.so.1 libhunspell.so.1.0 libhunspell.so ; do
		dosym libhunspell-1.7.so.0.0.1 usr/lib/${x}
	done
}
