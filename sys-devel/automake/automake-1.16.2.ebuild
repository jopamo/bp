# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Used to generate Makefile.in from Makefile.am"
HOMEPAGE="https://www.gnu.org/software/automake/"
SRC_URI="mirror://gnu/${PN}/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	dev-lang/perl
	sys-devel/autoconf
	sys-devel/gnuconfig
	sys-app/help2man
"

src_prepare() {
	default
	export WANT_AUTOCONF=2.5
	./bootstrap || die
}

src_install() {
	default

	#compat symlinks
	rm "${ED}"/usr/bin/{aclocal,automake}-*
	dosym aclocal usr/bin/aclocal-1.15
	dosym aclocal usr/bin/aclocal-1.16

	dosym automake usr/bin/automake-1.15
	dosym automake usr/bin/automake-1.16
}
