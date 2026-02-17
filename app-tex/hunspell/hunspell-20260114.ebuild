# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools qa-policy

DESCRIPTION="The most popular spellchecking library"
HOMEPAGE="http://hunspell.github.io/"
SNAPSHOT=d5911c735cbb26884c34f6fb338d208039e48d50
SRC_URI="https://github.com/hunspell/hunspell/archive/${SNAPSHOT}.tar.gz -> hunspell-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/hunspell-${SNAPSHOT}"

LICENSE="LGPL/GPL/MPL"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs minimal"

DEPEND="app-tex/hunspell-dictionaries"
BDEPEND="app-dev/patchelf"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	qa-policy-configure

	default
}

src_install() {
	default

	use static-libs || rm -f "${ED}"/usr/lib/libhunspell-1.7.a || die
	use minimal && rm -f "${ED}"/usr/bin/{makealias,affixcompress,wordforms,ispellaff2myspell,wordlist2hunspell,munch,analyze,chmorph,unmunch,hunzip,hzip}

	for x in libhunspell.so.1 libhunspell.so.1.0 libhunspell.so ; do
		dosym -r /usr/lib/libhunspell-1.7.so.0.0.1 /usr/lib/${x}
	done

	qa-policy-install
}
