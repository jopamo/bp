# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools flag-o-matic

DESCRIPTION="display bandwidth usage on an interface"
HOMEPAGE="http://www.ex-parrot.com/pdw/iftop/"
SRC_URI="http://www.ex-parrot.com/pdw/iftop/download/${P/_/}.tar.gz"
S="${WORKDIR}"/${P/_/}

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	lib-net/libpcap
	virtual/curses
"
BDEPEND="app-dev/pkgconf"

PATCHES=(
	"${FILESDIR}"/${P}-configure.ac.patch
	"${FILESDIR}"/${P}-Makefile.am.patch
	"${FILESDIR}"/${P}-tsent-set-but-not-used.patch
	"${FILESDIR}"/${P}-ip6.arpa.patch
	"${FILESDIR}"/${PN}-1.0pre4-gcc10.patch
	"${FILESDIR}"/bc66e31834419c12770d790694bc9e60eccd11e2.diff
	"${FILESDIR}"/96a691484e6e3c6fa415b46e466c85323d017baa.diff
	"${FILESDIR}"/9addd978c444aabfc2af6fa888436ac00770a4c8.diff
	"${FILESDIR}"/53e1150f66a478d3c52180d395a123ae9fcb8618.diff
	"${FILESDIR}"/949ed0f7e2c54c598868c270b82c2d702131a339.diff
	"${FILESDIR}"/77901c8c53e01359d83b8090aacfe62214658183.diff
)

src_prepare() {
	append-flags "-fpermissive -std=gnu17"
	rm aclocal.m4 || die
	default
	eautoreconf
}

src_install() {
	dobin iftop
	doman iftop.8
}
