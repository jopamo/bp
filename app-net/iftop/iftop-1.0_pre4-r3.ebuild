# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

DESCRIPTION="display bandwidth usage on an interface"
SRC_URI="http://www.ex-parrot.com/pdw/iftop/download/${P/_/}.tar.gz"
HOMEPAGE="http://www.ex-parrot.com/pdw/iftop/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
	lib-net/libpcap
	lib-sys/ncurses:0=
"
DEPEND="
	${RDEPEND}
	dev-util/pkgconf
"
S="${WORKDIR}"/${P/_/}
PATCHES=(
	"${FILESDIR}"/${P}-configure.ac.patch
	"${FILESDIR}"/${P}-Makefile.am.patch
	"${FILESDIR}"/${P}-tsent-set-but-not-used.patch
	"${FILESDIR}"/${P}-ip6.arpa.patch
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
