# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Used to create autoconfiguration files"
HOMEPAGE="https://www.gnu.org/software/autoconf/autoconf.html"
SRC_URI="mirror://gnu/${PN}/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="$(ver_cut 1).$(ver_cut 2)"
KEYWORDS="amd64 arm64"

DEPEND="
	app-build/m4
	app-lang/perl
"

src_install() {
	default

	dosym -r /usr/share/gnuconfig/config.sub /usr/share/autoconf/build-aux/config.sub
	dosym -r /usr/share/gnuconfig/config.guess /usr/share/autoconf/build-aux/config.guess
}
