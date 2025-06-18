# Distributed under the terms of the GNU General Public License v2

EAPI=8

BRANCH_NAME="gawk-$(ver_cut 1-2)-stable"
SNAPSHOT=edf247cf0fd79ada619371192f1069440e181893

inherit flag-o-matic

DESCRIPTION="GNU awk pattern-matching language"
HOMEPAGE="https://www.gnu.org/software/gawk/gawk.html"

SRC_URI="https://github.com/1g4-mirror/gawk/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

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
