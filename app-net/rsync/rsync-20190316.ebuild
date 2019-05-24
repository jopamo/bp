# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit flag-o-matic autotools

DESCRIPTION="File transfer program to keep remote files into sync"
HOMEPAGE="https://rsync.samba.org/"
SRC_URI="https://1g4.org/files/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="acl examples iconv ipv6 static stunnel xattr"

LIB_DEPEND="acl? ( sys-app/acl[static-libs(+)] )
	xattr? ( kernel_linux? ( sys-app/attr[static-libs(+)] ) )"

RDEPEND="!static? ( ${LIB_DEPEND//\[static-libs(+)]} )"

DEPEND="${RDEPEND}
	static? ( ${LIB_DEPEND} )"

S="${WORKDIR}/${P/_/}"

src_prepare() {
	eautoreconf
	default
}

src_configure() {
	use static && append-ldflags -static
	local myeconfargs=(
		$(use_enable acl acl-support)
		$(use_enable iconv)
		$(use_enable ipv6)
		$(use_enable xattr xattr-support)
	)
	econf "${myeconfargs[@]}"
}

src_install() {
	emake DESTDIR="${D}" install

	# Install stunnel helpers
	if use stunnel ; then
		emake DESTDIR="${D}" install-ssl-client
		emake DESTDIR="${D}" install-ssl-daemon
	fi
}
