# Distributed under the terms of the GNU General Public License v2

EAPI=8

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
	app-core/help2man
"

src_install() {
	default

	#compat symlinks
	rm "${ED}"/usr/bin/{aclocal,automake}-*

	dosym -r /usr/bin/aclocal /usr/bin/aclocal-1.15
	dosym -r /usr/bin/automake /usr/bin/automake-1.15

	dosym -r /usr/bin/aclocal /usr/bin/aclocal-1.$(ver_cut 1-2)
	dosym -r /usr/bin/automake /usr/bin/automake-$(ver_cut 1-2)

	dosym -r /usr/share/gnuconfig/config.sub /usr/share/automake-$(ver_cut 1-2)/config.sub
	dosym -r /usr/share/gnuconfig/config.guess /usr/share/automake-$(ver_cut 1-2)/config.guess
}
