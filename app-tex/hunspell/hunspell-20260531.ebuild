# Distributed under the terms of the GNU General Public License v2

inherit autotools qa-policy

DESCRIPTION="The most popular spellchecking library"
HOMEPAGE="http://hunspell.github.io/"
SNAPSHOT=7515bda0ec7edd02e0827d6fa310128b11ce4860
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

	local hunspell_devel_link= hunspell_soname_link= path=

	for path in "${ED}"/usr/lib/libhunspell-*.so ; do
		[[ -L ${path} ]] || continue
		hunspell_devel_link="/usr/lib/${path##*/}"
		break
	done
	[[ -n ${hunspell_devel_link} ]] || die "failed to find installed libhunspell linker symlink"

	for path in "${ED}"/usr/lib/libhunspell-*.so.* ; do
		[[ -L ${path} ]] || continue
		[[ ${path##*.so.} =~ ^[0-9]+$ ]] || continue
		hunspell_soname_link="/usr/lib/${path##*/}"
		break
	done
	[[ -n ${hunspell_soname_link} ]] || die "failed to find installed libhunspell SONAME symlink"

	for x in libhunspell.so.1 libhunspell.so.1.0 ; do
		dosym -r "${hunspell_soname_link}" /usr/lib/${x}
	done
	dosym -r "${hunspell_devel_link}" /usr/lib/libhunspell.so

	qa-policy-install
}
