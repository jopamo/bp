# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit flag-o-matic

DESCRIPTION="File transfer program to keep remote files into sync"
HOMEPAGE="https://rsync.samba.org/"
SRC_URI="https://download.samba.org/pub/rsync/src/${P}.tar.gz"

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

PATCHES=(
			${FILESDIR}/3fe4469bfa84ed23414f4f581c798945dcfa41f0.patch
			${FILESDIR}/a3668685354e7457ac3e29634083906ee5435bf2.patch
			${FILESDIR}/efcbec3df5277ab14fe2757bd9187e4bb77d1ee2.patch
			${FILESDIR}/eec6ab7615535e02cfcb691d44575268bdcf656f.patch
			${FILESDIR}/ad17b2188958dabe2f957cde1357ae70f75d3bbd.patch
			${FILESDIR}/8eb50bce43634b9ef9ae940778ac08a959a7e8e4.patch
			${FILESDIR}/c37617064494ecc2da52f2da97aa8768f75f247f.patch
			${FILESDIR}/fc10fafa252ae1055296831506e6e2dcdc1853c5.patch
		)

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
	default

	# Install stunnel helpers
	if use stunnel ; then
		emake DESTDIR="${D}" install-ssl-client
		emake DESTDIR="${D}" install-ssl-daemon
	fi
}
