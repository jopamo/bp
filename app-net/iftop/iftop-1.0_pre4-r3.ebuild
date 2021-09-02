# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

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
BDEPEND="dev-util/pkgconf"

PATCHES=(
	"${FILESDIR}"/${P}-configure.ac.patch
	"${FILESDIR}"/${P}-Makefile.am.patch
	"${FILESDIR}"/${P}-tsent-set-but-not-used.patch
	"${FILESDIR}"/${P}-ip6.arpa.patch
	"${FILESDIR}"/${PN}-1.0pre4-gcc10.patch
)

src_prepare() {
	default
	# bug 490168
	cat "${FILESDIR}"/ax_pthread.m4 >> "${S}"/acinclude.m4 || die

	eautoreconf
}

src_install() {
	dosbin iftop
	doman iftop.8

	dodoc AUTHORS ChangeLog README "${FILESDIR}"/iftoprc
}
