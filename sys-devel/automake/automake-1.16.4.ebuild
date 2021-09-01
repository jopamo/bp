# Distributed under the terms of the GNU General Public License v2

EAPI=8

OLDVER=1.15

DESCRIPTION="Used to generate Makefile.in from Makefile.am"
HOMEPAGE="https://www.gnu.org/software/automake/"
SRC_URI="mirror://gnu/${PN}/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="dev-lang/perl"
BDEPEND="
	sys-devel/autoconf
	sys-devel/gnuconfig
	app-core/help2man
"

PATCHES=( "${FILESDIR}"/f4a3a70f69e1dbccb6578f39ef47835098a04624.patch )

src_install() {
	default

	#compat symlinks
	rm "${ED}"/usr/bin/{aclocal,automake}-*

	dosym -r /usr/bin/aclocal /usr/bin/aclocal-${OLDVER}
	dosym -r /usr/bin/automake /usr/bin/automake-${OLDVER}

	dosym -r /usr/bin/aclocal /usr/bin/aclocal-$(ver_cut 1-2)
	dosym -r /usr/bin/automake /usr/bin/automake-$(ver_cut 1-2)

	dosym -r /usr/share/gnuconfig/config.sub /usr/share/automake-$(ver_cut 1-2)/config.sub
	dosym -r /usr/share/gnuconfig/config.guess /usr/share/automake-$(ver_cut 1-2)/config.guess

	mkdir -p "${ED}"/usr/share/{aclocal,automake} || die

	cp -rp "${ED}"/usr/share/aclocal-$(ver_cut 1-2)/* "${ED}"/usr/share/aclocal/ || die
	cp -rp "${ED}"/usr/share/automake-$(ver_cut 1-2)/* "${ED}"/usr/share/automake/ || die

	rm -rf "${ED}"/usr/share/{aclocal,automake}-$(ver_cut 1-2) || die

	dosym -r /usr/share/aclocal /usr/share/aclocal-$(ver_cut 1-2)
	dosym -r /usr/share/automake /usr/share/automake-$(ver_cut 1-2)
}
