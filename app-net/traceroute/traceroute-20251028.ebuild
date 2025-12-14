# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic toolchain-funcs

DESCRIPTION="Utility to trace the route of IP packets"
HOMEPAGE="https://traceroute.sourceforge.net/"
SNAPSHOT=9b6de003f20b8160991ec13bb8bf97f3ff94fec7
SRC_URI="https://github.com/jopamo/traceroute/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static"

RDEPEND="!net-misc/iputils[traceroute6(-)]"

src_compile() {
	use static && append-ldflags -static
	# bug #432116
	append-ldflags -L../libsupp
	tc-export AR CC RANLIB

	emake env=yes
}

src_install() {
	emake DESTDIR="${D}" prefix="${EPREFIX}/usr" install
	dodoc ChangeLog CREDITS README TODO
	dosym -r /usr/bin/traceroute /usr/bin/traceroute6
	dosym -r /usr/share/man/man8/traceroute.8 /usr/share/man/man8/traceroute6.8
}
