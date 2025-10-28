# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic toolchain-funcs

DESCRIPTION="Utility to trace the route of IP packets"
HOMEPAGE="https://traceroute.sourceforge.net/"

SNAPSHOT=fc6c4ab7625c870eabd166919c2074b41700042b
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
	dosym traceroute /usr/bin/traceroute6
	dosym traceroute.8 /usr/share/man/man8/traceroute6.8
}
