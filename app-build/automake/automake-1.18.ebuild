# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Used to generate Makefile.in from Makefile.am"
HOMEPAGE="https://www.gnu.org/software/automake/"
SRC_URI="mirror://gnu/${PN}/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="app-lang/perl"
BDEPEND="
	app-build/autoconf
	app-build/gnuconfig
	app-core/help2man
"

src_install() {
	default

	dosym -r /usr/share/gnuconfig/config.sub /usr/share/automake-$(ver_cut 1-2)/config.sub
	dosym -r /usr/share/gnuconfig/config.guess /usr/share/automake-$(ver_cut 1-2)/config.guess

	mkdir -p "${ED}"/usr/share/{aclocal,automake} || die

	cp -rp "${ED}"/usr/share/aclocal-$(ver_cut 1-2)/* "${ED}"/usr/share/aclocal/ || die
	cp -rp "${ED}"/usr/share/automake-$(ver_cut 1-2)/* "${ED}"/usr/share/automake/ || die

	rm -rf "${ED}"/usr/share/{aclocal,automake}-$(ver_cut 1-2) || die

	dosym -r /usr/share/aclocal /usr/share/aclocal-$(ver_cut 1-2)
	dosym -r /usr/share/automake /usr/share/automake-$(ver_cut 1-2)

	rm "${ED}"/usr/share/automake/config.sub || die
    rm "${ED}"/usr/share/automake/config.guess || die
    cd "${ED}"/usr/share/automake || die
    ln -s ../gnuconfig/config.sub  config.sub || die
    ln -s ../gnuconfig/config.guess config.guess || die
}
