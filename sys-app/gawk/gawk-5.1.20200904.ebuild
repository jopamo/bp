# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="GNU awk pattern-matching language"
HOMEPAGE="https://www.gnu.org/software/gawk/gawk.html"

SNAPSHOT=a9440d51fdf9286dc657b10368503aecb74eb19d
SRC_URI="https://git.savannah.gnu.org/cgit/gawk.git/snapshot/gawk-${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="+mpfr nls readline"

RDEPEND="
	lib-dev/gmp:0=
	mpfr? ( lib-dev/mpfr:0= )
	readline? ( lib-sys/readline:0= )
"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

src_configure() {
	export ac_cv_libsigsegv=no
	local myconf=(
		$(use_with mpfr)
		$(use_enable nls)
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
