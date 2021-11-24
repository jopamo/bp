# Distributed under the terms of the GNU General Public License v2

EAPI=8

SNAPSHOT=5dd74ca177fc6e748c0098da1af8c94228ee6e90

inherit flag-o-matic

DESCRIPTION="GNU awk pattern-matching language"
HOMEPAGE="https://www.gnu.org/software/gawk/gawk.html"
SRC_URI="https://git.savannah.gnu.org/cgit/gawk.git/snapshot/gawk-${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="+mpfr readline"

DEPEND="
	lib-core/gmp
	mpfr? ( lib-core/mpfr )
	readline? ( lib-core/readline )
"

filter-flags -Wl,-z,defs

src_configure() {
	export ac_cv_libsigsegv=no
	local myconf=(
		$(use_with mpfr)
		--disable-nls
		$(use_with readline)
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_install() {
	default

	insinto usr/include/awk
	doins *.h || die
	rm "${ED}"/usr/include/awk/config.h || die
	dosym gawk usr/bin/awk
}
