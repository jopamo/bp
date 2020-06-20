# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit flag-o-matic autotools

DESCRIPTION="File transfer program to keep remote files into sync"
HOMEPAGE="https://rsync.samba.org/"
SRC_URI="https://download.samba.org/pub/rsync/src/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="acl iconv ipv6 static xattr +xxhash zstd"

LIB_DEPEND="acl? ( sys-app/acl[static-libs(+)] )
	xattr? ( sys-app/attr[static-libs(+)] )
	xxhash? ( lib-dev/xxhash[static-libs(+)] )
	zstd? ( app-compression/zstd[static-libs(+)] )"

RDEPEND="!static? ( ${LIB_DEPEND//\[static-libs(+)]} )"

DEPEND="${RDEPEND}
	static? ( ${LIB_DEPEND} )"

PATCHES=( "${FILESDIR}"/simd.patch )

append-ldflags -Wl,-z,noexecstack

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	use static && append-ldflags -static

	local myconf=(
		$(use_enable acl acl-support)
		$(use_enable iconv)
		$(use_enable ipv6)
		$(use_enable xattr xattr-support)
		$(use_enable xxhash)
		$(use_enable zstd)
	)
	econf "${myconf[@]}"
}

src_compile() {
	emake reconfigure
	default
}
