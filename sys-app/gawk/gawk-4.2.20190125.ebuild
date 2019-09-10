# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

DESCRIPTION="GNU awk pattern-matching language"
HOMEPAGE="https://www.gnu.org/software/gawk/gawk.html"

SNAPSHOT=dc189dc65b6c9b0f521beb4c6105130c6e33a274
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
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/lib
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
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
