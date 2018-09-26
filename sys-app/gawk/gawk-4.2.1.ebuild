# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit toolchain-funcs multilib

DESCRIPTION="GNU awk pattern-matching language"
HOMEPAGE="https://www.gnu.org/software/gawk/gawk.html"
SRC_URI="mirror://gnu/${PN}/${P}.tar.xz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64 x86"

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
	local myeconfargs=(
		--libexec='$(libdir)/misc'
		$(use_with mpfr)
		$(use_enable nls)
		$(use_with readline)
	)
	econf "${myeconfargs[@]}"
}

src_install() {
	default
	insinto /usr/include/awk
	doins *.h || die
	rm "${ED}"/usr/include/awk/config.h || die
	dosym gawk /usr/bin/awk
}
