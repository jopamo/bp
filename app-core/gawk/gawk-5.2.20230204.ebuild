# Distributed under the terms of the GNU General Public License v2

EAPI=8

SNAPSHOT=a6e03b9f35b553903901f48d09908e41a7ea189d

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

src_configure() {
	filter-flags -Wl,-z,defs

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
