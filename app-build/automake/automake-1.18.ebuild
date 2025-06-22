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
    emake DESTDIR="${D}" install || die

    rm "${ED}"/usr/bin/{aclocal,automake}-* || die

    dosym -r /usr/bin/aclocal /usr/bin/aclocal-$(ver_cut 1-2)
    dosym -r /usr/bin/automake /usr/bin/automake-$(ver_cut 1-2)

    mkdir -p "${ED}/usr/share/automake" || die
    cp -rp "${ED}/usr/share/automake-$(ver_cut 1-2)"/* "${ED}/usr/share/automake/" || die
    rm -rf "${ED}/usr/share/automake-$(ver_cut 1-2)" || die
    dosym -r /usr/share/automake /usr/share/automake-$(ver_cut 1-2)

    rm "${ED}"/usr/share/automake/config.sub || die
    rm "${ED}"/usr/share/automake/config.guess || die
    cd "${ED}"/usr/share/automake || die
    ln -s /usr/share/gnuconfig/config.sub  config.sub || die
    ln -s /usr/share/gnuconfig/config.guess config.guess || die
	cd "${ED}" || die

    rm "${ED}"/usr/share/doc/automake-1.18/amhello-1.0.tar.gz || die
}
